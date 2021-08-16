#!/bin/bash

#Variablen
date=`date +%Y_%b_%d_%H-%M`

#Server 1
server1=''
server_ip1=''

#Server 2
server2=''
server_ip2=''

cd /Backend/

##REQUEST IF BACKUP DIR ALREADY EXISTS?
if [ -d "sicherung" ]; then
    printf "Folder will be recreated\n"
    rm -r sicherung
    mkdir sicherung
else
    printf "Folder will be created for the first time\n"
    mkdir sicherung
fi

##COPY CONTENT TO TEMP FILE
sshpass -p "$server1" scp -r root@$server_ip1:/home/bauserver-neu-15_5_2021/ /Backend/sicherung
sshpass -p "$server1" scp -r root@$server_ip1:/var/www/ /Backend/sicherung
sshpass -p "$server2" scp -r root@$server_ip2:/IFH/mcserver_test/ /Backend/sicherung


tar -cf $date.tar sicherung

##GOOGLE DRIVE UPLOAD
cd /usr/sbin && ./drive upload --file /Backend/$date.tar

##REMOVE BACKUP TAR file
rm -r /Backend/$date.tar
rm -r /Backend/sicherung