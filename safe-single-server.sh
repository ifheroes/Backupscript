#!/bin/bash
#0 0 */3 * * /Backend/safe.sh >/dev/null 2>&1

#Variablen
date=`date +%Y_%b_%d_%H-%M`

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
cp -r /home/minecraft/ /Backend/sicherung
cp -r /var/www/ /Backend/sicherung


tar -cf $date.tar sicherung

##GOOGLE DRIVE UPLOAD
cd /root && ./gdrive upload /Backend/$date.tar

##REMOVE BACKUP TAR file
rm -r /Backend/$date.tar
rm -r /Backend/sicherung