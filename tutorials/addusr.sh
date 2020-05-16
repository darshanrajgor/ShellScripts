#! /bin/bash

LeaveScript()
 {
   rm /root/Temp/ptmp /root/Temp/stmp /root/Temp/gtmp
   exit 1;
 }

trap LeaveScript INT

if [ $UID -ne 0 ] ; then
  echo " "
  echo " Only Super User or  Root can run this script "
  echo " "
  exit 0
fi

if [ -f /root/Temp/ptmp ] ; then
  echo "Password file is in Use"
  exit 1;
else
  cp /etc/passwd /root/Temp/ptmp
  cp /etc/shadow /root/Temp/stmp
  cp /etc/group /root/Temp/gtmp
  chmod 700 /etc/shadow
fi

echo "   ***************************************************************"
echo "                This script add the new user"
echo "       This will change some sensitive file so be careful"
echo "   ***************************************************************"

echo -n " Enter User Name : "
read name

if [ -z $name ] ; then
  echo " You must enter the User Name"
  LeaveScript
  exit 1
fi

#stty -echo
#echo -n "Enter Password : "
#read pass
#stty echo
#echo " "


echo -n " Enter User ID : "
read uid

echo -n " Enter Group ID : "
read gid

echo -n " Enter Description About User : "
read descri

echo -n " Do u want to create Default home direcotry /home/$name : "
read ch
if [ "$ch" = "y" ] ; then
 homedir="/home/$name"
  
else
 echo -n " Enter Home Directory : "
 read homedir
 
fi

echo -n " You want to enter default shell as current shell $SHELL : "
read ch
if [ "$ch" = "y" ] ; then
 shell="$SHELL"
else
echo -n " Enter Default Shell : "
read shell
fi

chkusr=`cat /etc/passwd | cut -d ":" -f 1 | grep -c $name`
if [ $chkusr -ne 0 ] ; then
  echo " "
  echo "   User alredy Exist"
  echo " "
  LeaveScript
  exit 0
fi

chkid=`cat /etc/passwd | cut -d ":" -f 3 | grep -c $uid`
if [ $chkid -ne 0 ] ; then
  echo " "
  echo " User ID alredy exist "
  echo " "
  LeaveScript
  exit 1
fi

chkgid=`cat /etc/group | cut -d ":" -f 3 | grep -c $gid`
if [ $chkgid -eq 0 ] ; then
  echo " "
  echo " Group ID not Exist"
  echo " "
  LeaveScript
  exit 1
fi
tmpgrp1=`grep $gid /etc/group`
tmpgrp2=`grep -v $gid /etc/group`
echo "$tmpgrp2">/etc/group
echo "${tmpgrp1},${name}">>/etc/group

userinfo=$name":x:"$uid":"$gid":"$descri":"$homedir":"$shell
#echo $userinfo
echo $userinfo>>/etc/passwd
#echo $userinfo>>/etc/passwd
chmod 700 /etc/shadow
defaultpass="\$1\$A6BMm0\$TpCiblKCT7tpyG33LT4Pj0"
last=`date +%s`/86400
lastchpass=`echo $last | bc`
shadowinfo=$name":"$defaultpass":"$lastchpass":0:99999:7:::"
#echo $shadowinfo>>/root/Temp/shadow
echo $shadowinfo>>/etc/shadow
chmod 400 /etc/shadow
#passwd $name


mkdir $homedir
#chown -R $name:$gid $homedir
chown -R $name $homedir
cp /etc/skel/.[a-z,A-Z,0-9]* $homedir
touch /var/spool/mail/$name
chown $name /var/spool/mail/$name

echo " "
echo " User Successfuly added and Default Password is \"redhat\""
LeaveScript
