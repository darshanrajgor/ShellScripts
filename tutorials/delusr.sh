#! /bin/bash

LeaveScript()
 {
   rm /root/Temp/ptmp /root/Temp/stmp /root/Temp/gtmp
   exit 1
 }

trap LeavScript INT
if [ $UID -ne 0 ] ; then
  echo " "
  echo "Only Root can run this script"
  echo " "
  exit 1
fi

if [ -f /root/Temp/ptmp ] ; then
  echo "  "
  echo " Password file is in use"
  echo " "
  LeaveScript
else
  cp /etc/passwd /root/Temp/ptmp
  cp /etc/shadow /root/Temp/stmp
  cp /etc/group /root/Temp/gtmp
fi
 

echo "    ************************************************"
echo "         This script Delete user, So be careful"
echo "    ************************************************"
echo " "

echo -n "Enter User Name  : "
read name

if [ -z $name ] ; then
  echo " "
  echo " You must enter User Name"
  echo " "
  LeaveScript
fi

if [ `cat /etc/passwd | cut -d ":" -f 1 | grep -c -w $name` -eq 0 ] ; then
  echo " "
  echo " User Does not exist"
  echo " "
  LeaveScript
fi

echo -n "Do U want to Delete user's home directory and Files :  "
read ch

echo " "
echo -n "Are U sure U want to delete User ? : "
read confirm

if [ $confirm != "y" ] ; then
  echo " "
  echo "   Aborted By User "
  echo " "
  LeaveScript
fi

homedir=`cat /etc/passwd | grep -w  $name | cut -d ":" -f 6`
#echo $homedir

gid=`cat /etc/passwd | grep -w  $name | cut -d ":" -f 4`
#echo $gid

ptmp=`cat /etc/passwd | grep -w -v $name`
stmp=`cat /etc/shadow | grep -w -v $name`


chmod 700 /etc/shadow
echo "Deleting password file entries...."
echo "$ptmp"> /etc/passwd
echo "Deleted !!!"
echo " "

echo "Deleting shadow file entries...."
echo "$stmp"> /etc/shadow
echo "Deleted !!!"                                                 
echo " "
chmod 400 /etc/shadow

echo "Deleting Group file entries ...."
gtmp1=`cat /etc/group | grep -w -v "$name"`
gtmp2=`cat /etc/group | grep -w $name`
deltmp=",${name}"
gtmp3="${gtmp2/$deltmp*/}"
gtmp4="${gtmp3}${deltmp}"
gtmp5="${gtmp2##$gtmp4}"
gtmp6="${gtmp3}${gtmp5}"
echo "$gtmp1" > /etc/group
echo "$gtmp6" >> /etc/group
echo "Deleted !!!"
echo " "

if [ "$ch" == "y" ] ; then
  echo " "
  echo "Deleting home directory and files ...."
  echo " "
  rm -r $homedir
  rm /var/spool/mail/$name
  echo " "
  echo "Deletion Completed!!!"
  echo " "
fi

echo " " 
echo " User Sucessfuly Deleted !!!!"
echo " " 

LeaveScript 
