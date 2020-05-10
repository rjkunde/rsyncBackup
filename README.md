# rsyncBackup
Linux rsync backup script with email alerting

#### Requirements
sendemail command line tool, SSL libraries, rsync, and log a file to write to

### Installation

##### Install sendemail command line too
```sudo apt-get install sendemail```
##### Install SSL libraries
```sudo apt-get install libio-socket-ssl-perl libnet-ssleay-perl```
##### Install rsync (present on Ubuntu 18.04 by default)
```sudo apt-get install rsync```
##### Create log file for sendemail
```sudo touch /var/log/sendEmail```
##### Make sendemail log file writable
```sudo chmod 666 /var/log/sendEmail```

### Edit backup-with-email.sh file
1. Set /path/to/primary/ to source directory
2. Set /path/to/secondary/ to destination directory
3. Replace fromEmailAddress@gmail.com
4. Replace toEmailAddress@gmail.com
5. Customize text, ex XYZ server, error messages etc
6. Optional: In the else statement, comment out the echo, and uncomment the longer statement to enable "On Success Emails" 

*Note*: If using gmail as your smtp email provider, you will receive authentication errrors. See ```/var/log/sendEmail``` for debugging. In this case, you must enable "Allow less secure apps: ON" located in google account settings https://myaccount.google.com/lesssecureapps.

### Running backup-with-email.sh script
Copy backup-with-email.sh to a location that is accessible by the user account you wish to run it as. For example, a logical place might be /home/username/backup-with-email.sh. If placed outside of an accessible directory, you will need to give read permissions to this user. Additionally, if you look at the rsync command:  
```/usr/bin/rsync -av --delete /path/to/primary/ /path/to/secondary/```  
The user running this must have read acccess to the primary directory, and read/write to the secondary.



