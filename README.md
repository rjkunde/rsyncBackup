# rsyncBackup

### Requirements
sendemail command line tool, SSL libraries, rsync, and log file to write to

### Installation
#### Install sendemail command line too
sudo apt-get install sendemail
#### Install SSL libraries
sudo apt-get install libio-socket-ssl-perl libnet-ssleay-perl
#### Install rsync (present on Ubuntu 18.04 by default)
sudo apt-get install rsync
#### Create log file for sendemail
sudo touch /var/log/sendEmail
#### Make sendemail log file writable
sudo chmod 666 /var/log/sendEmail

### Running backup-with-email.sh script
Copy backup-with-email.sh to a location that is accessible by the user account you wish to run it as. For example, a logical place might be /home/username/backup-with-email.sh. If placed outside of an accessible directory, you will need to give read permissions to your user. Additionally, if you look at the rsync command:  
/usr/bin/rsync -av --delete /path/to/primary/ /path/to/secondary/  
The user running this must have read acccess to the primary directory, and read/write to the secondary.
