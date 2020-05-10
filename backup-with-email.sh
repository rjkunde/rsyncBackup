#!/bin/bash

# Monthly rsync backup with email report
# RJ Kunde
# rj.kunde@gmail.com
# Complete list of rsync options: https://ss64.com/bash/rsync_options.html
# Tested on Linux Ubuntu 18.04LTS

# Run rsync to clone one directory, to another
# Any files deleted from primary directory are removed from secondary
# Caution: if primary drive starts to fail, some files might fail to sync, resulting in loss of data
# If this worries you, remove the "--delete" switch and manually remove files from secondary
# If running as a cron job, you can remove "v" from "-av" to supress console output
/usr/bin/rsync -av --delete /path/to/primary/ /path/to/secondary/

# Check if rsync is successful.
# 0 = success on POSIX systems
# If exit code is not zero, send email
# If exit code is zero, print success to console
# Log email results in /var/log/sendEmail
# If you want succces emails, remove echo and uncomment the second rysnc statement in the else clause
if [ $? != "0" ]
  then
   echo rysnc cron job failed! | /usr/bin/sendemail -f fromEmailAddress@gmail.com -s smtp.gmail.com:587 -xu fromEmailAddress@gmail.com -xp PasswordGoesHere -t toEmailAddress@gmail.com -o tls=yes -u "rsync backup FAILED on XYZ server" -m "Exit code is nonzero, check into this!" -l /var/log/sendEmail
  else
   # echo rsync cron job was successful | /usr/bin/sendemail -f fromEmailAddress@gmail.com -s smtp.gmail.com:587 -xu fromEmailAddress@gmail.com -xp PasswordGoesHere -t toEmailAddress@gmail.com -o tls=yes -u "rsync backup was SUCCESSFUL on XYZ server" -m "No need to do anything, have a nice day!" -l /var/log/sendEmail
   echo rsync cron job was successful
fi
