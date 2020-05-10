# rsyncBackup

Application Requirements  
Created 1/30/2019  
Updated 3/30/2020  
1.	Run on linux machine
2.	Can use any language, bash, sh, script etc.
3.  Descoped to include only local storage, network can be added later	
4.  Be able to specify databases, their users, and what directories need backups
5.	Run rysnc or comparable backup process, alongsige my
6.	store results in a log file
7.	email on failure

## Requirements
Linux based system capable of running rync and MySQL/MariaDB

### Install Rsync (Ubuntu/Debian)
This came stock on Ubuntu 18.04 LTS at time of testing  
`sudo apt-get install rsync`  

rsync syntax and switches  
`# rsync options source destination`  

-v : verbose  
-r : copies data recursively (but don’t preserve timestamps and permission while transferring data  
-a : archive mode, archive mode allows copying files recursively and it also preserves symbolic links, file permissions, user & group ownerships and timestamps  
-z : compress file data  
-h : human-readable, output numbers in a human-readable format  

`sudo rsync -avzh mydir/ /mnt/sdb1/testdir`  
