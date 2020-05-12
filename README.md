# rsyncBackup
Linux rsync backup script with email alerting

### Requirements
sendemail command line tool, SSL/TLS libraries, rsync, and log a file to write to

### Installation

##### Install sendemail command line too
`sudo apt-get install sendemail`
##### Install SSL libraries
`sudo apt-get install libio-socket-ssl-perl libnet-ssleay-perl`
##### Install rsync (present on Ubuntu 18.04 by default)
`sudo apt-get install rsync`
##### Create log file for sendemail
`sudo touch /var/log/sendEmail`
##### Make sendemail log file writable
`sudo chmod 666 /var/log/sendEmail`

### Edit backup-with-email.sh file
1. Set /path/to/primary/ to source directory
2. Set /path/to/secondary/ to destination directory
3. Replace all instances of fromEmailAddress@gmail.com
4. Replace all instances of toEmailAddress@gmail.com
5. Customize text, ex: XYZ server, error messages etc
6. Optional: In the else statement, comment out the echo, and uncomment the longer statement to enable "On Success Emails" 
7. Optional: Modify `/usr/bin/rsync -av --delete /path/to/source/directory /path/to/destination/directory/`, add or remove "v" to enable or disable verbose output to console. Nice for testing, not needed while running as a cron job.

*Note*: If using gmail as your smtp email provider, you will receive authentication errrors. See `/var/log/sendEmail` for debugging. In this case, you must enable "Allow less secure apps: ON" located in google account settings https://myaccount.google.com/lesssecureapps.

### Running backup-with-email.sh script
Copy backup-with-email.sh to a location that is accessible by the user account you wish to run it as. For example, a logical place might be /home/username/backup-with-email.sh. If placed outside of an accessible directory, you will need to give read permissions to this user. Additionally, if you look at the rsync command:  
`/usr/bin/rsync -av --delete /path/to/primary/ /path/to/secondary/`  
The user running this must have read acccess to the primary directory, and read/write to the secondary.

#### Run script
sh backup-with-email.sh

*Note:* Try with -av switch first, make sure it all works.

#### Automate script with a cronjob
`crontab -e`

Choose one (or modify to your needs) and add it the bottom of crontab:

`0 3 * * 1 sh /home/username/backup-with-email.sh` <-- Top of the hour, 3am, weekly

`* * * * * sh /home/username/backup-with-email.sh` <-- Every minute

Quick Reference:
```
*     *     *   *    *   command to be executed
-     -     -   -    -
|     |     |   |    |
|     |     |   |    +----- day of week (0 - 6) (Sunday=0)
|     |     |   +------- month (1 - 12)
|     |     +--------- day of        month (1 - 31)
|     +----------- hour (0 - 23)
+------------- min (0 - 59)
```
Source: https://www.jessicayung.com/automate-running-a-script-using-crontab/

