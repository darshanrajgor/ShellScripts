#! /bin/bash

if [ $UID -ne  0 ] ; then
  echo " "
  echo "Only Root or Super user can run this script"
  echo " " 
  exit 1
fi

clear
echo "          ***********************************************"
echo "             This script take Backup of Files which are"
echo "                    Not Accessed from 1 year or more"
echo "          ***********************************************"

echo " "
echo " "
echo "Wait for some time....."
echo " "

count=0
filelist=`find / -atime +365`

for i in `echo "$filelist"`
 do
  cp $i /root/script/backup
  let "count+=1"
 done

if [ $count -ne 0 ] ; then
 backupdate=`date`
 echo "$backupdate">> /root/script/backup/backup.log
 echo " ">> /root/script/backup/backup.log
 echo "$filelist" >> /root/script/backup/backup.log
 echo " ">> /root/script/backup/backup.log
fi

echo " "
echo "Backup stores in /root/script/backup Directory"
echo "Backup : ${count} files backuped successfuly "
echo "For more information see the logfile in /root/script/backuu/backup.log"

