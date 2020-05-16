#! /bin/bash

tmp="/root/Temp"
LeaveScript()
 {
   rm $tmp/gtmp $tmp/sgtmp
   exit 1
 }

trap LeaveScript INT TERM
if [ $UID -ne 0 ] ; then
 echo " "
 echo "Only Root or Super User can run this script"
 echo " "
 exit 1
fi

if [ -f $tmp/gtmp ] ; then
 echo " "
 echo "Group file is in use"
 echo " "
 exit 1
else
 cp $tmp/group $tmp/gtmp
 cp $tmp/gshadow $tmp/sgtmp
fi

clear
echo "          ***********************************************"
echo "                  This script add the new group"
echo "          ***********************************************"
echo " "

echo -n "Enter Group Name : "
read gname
echo " "
if [ -z $gname ] ; then
 echo " "
 echo "You must enter Group Name"
 echo " "
 LeaveScript
fi

if [ `cat $tmp/group | cut -d ":" -f 1 | grep -w -c $gname` -ne 0 ] ; then
 echo " "
 echo "Group name already exist"
 echo " "
 LeaveScript
fi

echo -n "Enter Group ID : "
read gid
if [ `cat $tmp/group | cut -d ":" -f 3 | grep -w -c "$gid"` -ne 0 ] ; then
 echo " "
 echo "Group ID aleady in use"
 echo " "
 LeaveScript
fi

if [ -z $gid ] ; then
 gid=`cat $tmp/group | cut -d ":" -f 3 | sort -n |tail -n 2 | head -n 1`
 #echo $gid
 let "gid= $gid+1"
fi

ginfo="${gname}:x:${gid}:"
sginfo="${gname}:::"

echo $ginfo >> $tmp/group
echo $sginfo >> $tmp/gshadow

echo " "
echo "Group Sucessfily added"
LeaveScript
