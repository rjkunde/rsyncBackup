#!/bin/bash

# Monthly rsync backup with email report
# RJ Kunde
# rj.kunde@gmail.com
# Complete list of rsync options: https://ss64.com/bash/rsync_options.html
# Tested on Linux Ubuntu 18.04LTS
# 
# Requirements: sendemail command line tool, SSL libraries, rsync, and log file to write to
#
# sudo apt-get install sendemail
# sudo apt-get install libio-socket-ssl-perl libnet-ssleay-perl
# sudo apt-get install rsync
# sudo touch /var/log/sendEmail
# sudo chmod 666 /var/log/sendEmail
#
# Run as scheduled cron job - if desired
# Note: Make sure the user you run this as has the ability to read this script, and read/write to your destination/source directories!
# Edit crontab:
# crontab -e
# Add the following:
# 0 3 * * 1 /script/source/directory/backup-with-email.sh (0 mins, 3am, * day of month, * month, 1st day of week) 

# Run rsync weekly to clone one drive, to another
# Any files deleted from primary drive are removed from secondary
# Caution: if primary drive starts to fail, some files might fail to sync, resulting in loss of data
# If this worries you, remove the --delete switch and manually remove files from secondary
/usr/bin/rsync -av --delete /path/to/source/directory /path/to/destination/directory/

# Check if rsync is successful. 0 = success on POSIX systems
# If exit code is not zero, send email
# If exit code is zero, print success to console
# Log email results in /var/log/sendEmail
# If you want succces emails, comment/remove line 39, and uncomment line 38
if [ $? != "0" ]
  then
   echo rysnc cron job failed! | /usr/bin/sendemail -f fromAddress@gmail.com -s smtp.gmail.com:587 -xu fromAddress@gmail.com -xp PasswordGoesHere -t toEmaillAddress@gmail.com -o tls=yes -u "rsync backup FAILED on XYZ server" -m "Exit code is nonzero, check into this!" -l /var/log/sendEmail
  else
   # echo rsync cron job was successful | /usr/bin/sendemail -f fromAddress@gmail.com -s smtp.gmail.com:587 -xu fromAddress@gmail.com -xp PasswordGoesHere -t toEmaillAddress@gmail.com -o tls=yes -u "rsync backup was SUCCESSFUL on XYZ server" -m "No need to do anything, have a nice day!" -l /var/log/sendEmail
   echo rsync cron job was successful   
 fi
