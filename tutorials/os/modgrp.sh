#! /bin/bash

tmp="/root/Temp"
LeaveScript()
 {
   rm $tmp/gtmp $tmp/gstmp $tmp/ptmp
   exit 1
 }

trap LeaveScript INT TERM
if [ $UID -ne 0 ] ; then
 echo " "
 echo "Only Root can run this script"
 echo " "
 exit 1
fi

if [ -f "$tmp/ptmp" ] ;  then
 echo " "
 echo "Group and Password files are in use"
 echo " "
 exit 1
else
 cp ${tmp}/passwd ${tmp}/ptmp
 cp ${tmp}/group ${tmp}/gtmp
 cp ${tmp}/gshadow ${tmp}/gstmp
fi

echo "          ************************************************"
echo "            This script modifies some sensitive files"
echo "                      So, Be careful"
echo "          ************************************************"
echo " "

while true
 do
   echo "========== CHOICE ==========="
   echo " "
   echo "1. Group Name"
   echo "2. Group ID"
   echo "3. Exit"
   echo " "
   echo -n "Enter Choice : "
   read ch

   case $ch in 
     1) echo "Enter Group Name : "
        echo -n "OLD : "
        read oldgname
        
        if [ `cat $tmp/group | cut -d ":" -f 1 | grep -w -c $oldgname` -eq 0 ] ; then
          echo " "
          echo "Group Does not exist"
          echo " " 
          LeaveScrit
        fi
        echo -n "NEW : "
        read newgname
        
        if [ `cat $tmp/group | cut -d ":" -f 1 | grep -w -c $newgname` -ne 0 ] ; then
          echo " "
          echo "Group Name is in use"
          echo " " 
          LeaveScrit
        fi
        if [ ! -z "$newgname" ] ; then
          tmp1=`cat $tmp/group | grep -w -v "$oldgname"`
          tmp2=`cat $tmp/group | grep -w  "$oldgname" | cut -d ":" -f 2-`
          newinfo="${newgname}:${tmp2}"
 	  echo "$tmp1" > $tmp/group
	  echo "$newinfo" >> $tmp/group

          tmp1=`cat $tmp/gshadow | grep -w -v "$oldgname"`
          tmp2=`cat $tmp/gshadow | grep -w  "$oldgname" | cut -d ":" -f 2-`
          newinfo="${newgname}:${tmp2}"
 	  echo "$tmp1" > $tmp/gshadow
          echo "$newinfo" >> $tmp/gshadow
       fi
       ;;
    2)echo "Enter Group ID : "
      echo -n "OLD : "
      read oldgid
      if [ `cat $tmp/group | cut -d ":" -f 3 | grep -w -c "$oldgid"` -eq 0 ] ; then
        echo " "
        echo "Group ID Does not exist"
        echo " " 
        LeaveScript
      fi
      echo -n "NEW : "
      read newgid
      if [ `cat $tmp/group | cut -d ":" -f 3 | grep -w -c "$newgid"` -ne 0 ] ; then
        echo " "
        echo "Group ID is already in use"
        echo " " 
        LeaveScrit
      fi ;;
   3) LeaveScript;;
   *)echo "Invalid choice"
esac
done
