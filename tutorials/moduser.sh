#! /bin/bash
#set -x
TMP="/root/Temp"

LeaveScript()
 {
   rm $TMP/ptmp $TMP/stmp $TMP/gtmp
   exit 1
 }

trap LeaveScript INT TERM

if [ $UID -ne 0 ] ; then
  echo " "
  echo "Only Root can run This script"
  echo " "
  exit 1
fi

if [ -f $TMP/ptmp ] ; then
  echo " "
  echo "Password file is in use " 
  echo " "
  exit 1
else
  cp $TMP/passwd $TMP/ptmp
  cp $TMP/shadow $TMP/stmp
  cp $TMP/group $TMP/gtmp
fi

clear
echo " "
echo "      ****************************************************"
echo "              This script Modify User Information"
echo "                         So Be careful"
echo "      ****************************************************"
echo " "

echo -n "Enter User Name : "
read name

if [ -z $name ] ; then
  echo " "
  echo "U must enter user name"
  echo " "
  LeaveScript
fi

if [ `cat $TMP/passwd | cut -d ":" -f 1 | grep -c -w "$name"` -eq 0 ] ; then
  echo " "
  echo "User does not Exist"
  echo " "
  LeaveScript
fi

echo "Name : ${name}"
echo " " 

uid=`cat $TMP/passwd | grep -w $name | cut -d ":" -f 3`
gid=`cat $TMP/passwd | grep -w $name | cut -d ":" -f 4`
descri=`cat $TMP/passwd | grep -w $name | cut -d ":" -f 5`
home=`cat $TMP/passwd | grep -w $name | cut -d ":" -f 6`
shell=`cat $TMP/passwd | grep -w $name | cut -d ":" -f 7`

echo "UID : $uid"
echo " "

echo "Group ID Information :"
echo "OLD : $gid"
echo -n "NEW : "
read newgid

if [ -z "$newgid" ] ; then
  newgid=$gid
fi
echo " "

echo "Description or comment about the User :"
echo "OLD : $descri"
echo -n "NEW : "
read newdescri
echo " "

if [ -z "$newdescri" ] ; then
  newdescri=$descri
fi

echo "HOME Direcory of User : "
echo "OLD : $home"
echo -n "NEW : "
read newhome
echo " "

if [ -z "$newhome" ] ; then
  newhome=$home
fi

echo "Default SHELL Information  : "
echo "OLD : $shell"
echo -n "NEW : "
read newshell
echo " "

if [ -z "$newshell" ] ; then
 newshell=$shell
fi


pass=`cat $TMP/shadow | grep -w "$name" | cut -d ":" -f 2`
challow=`cat $TMP/shadow | grep -w "$name" | cut -d ":" -f 4`
lastchpass=`cat $TMP/shadow | grep -w "$name" | cut -d ":" -f 3`
chrequi=`cat $TMP/shadow | grep -w "$name" | cut -d ":" -f 5`
chwarn=`cat $TMP/shadow | grep -w "$name" | cut -d ":" -f 6`
accinact=`cat $TMP/shadow | grep -w "$name" | cut -d ":" -f 7`


echo -n "R u want to reset password to \"redhat\" : "
read ch
echo " "
if [ "$ch" = "y" ] ; then
  newpass="\$1\$O72un0\$2yqfGeyQv0eLrEKwJ/Y5//"
  last=`date +%s/86400`
  newlastchpass=`echo "$last" | bc`
else
  newpass='$pass'
  newlastchpass="$lastchpass"
fi

echo "Days before changed allowed : "
echo "OLD : ${challow}"
echo -n "NEW : "
read newchallow
echo " "
if [ -z $newchallow ] ; then
  newchallow=$challow
fi

echo "Days before changed Required : "
echo "OLD : ${chrequi}"
echo -n "NEW : "
read newchrequi
echo " "
if [ -z $newchrequi ] ; then
 newchrequi=$chrequi
fi

echo "Days warning Before change : "
echo "OLD : ${chwarn}"
echo -n "NEW : "
read newchwarn
echo " "
if [ -z $newchwarn ] ; then
 newchwarn=$chwarn
fi

echo "Days before Account inactive :"
echo "OLD : ${accinact}"
echo -n "NEW : "
read newaccinact
if [ -z $newaccinact ] ; then
 newaccinact=$accinact
fi

echo " "
echo -n "Account Expires on (YYYY-MM-DD) : "
read accexpr
if [ "$accexpr" != "" ] ; then
 curdate=`date +"%Y-%m-%d %H:%M:%S"`
 time=`date +%H:%M:%S`
 date -s "${accexpr} ${time}"  > /dev/null
 seconds=`date +%s`
 date -s "$curdate" > /dev/null
 accexpr=`echo "${seconds}/86400" | bc`
fi

userinfo="${name}:x:${uid}:${newgid}:${newdescri}:${newhome}:${newshell}"
tmp1=`cat $TMP/passwd | grep -v -w "$name"`
tmp2=`cat $TMP/passwd | grep -w "$name"`

tmp3=`cat $TMP/shadow | grep -v -w "$name"`
tmp4=`cat $TMP/shadow | grep -w "$name"`

suserinfo="${name}:${newpass}:${newlastchpass}:${newchallow}:${newchrequi}:${newchwarn}:${newaccinact}:${accexpr}:"

echo "$userinfo"
echo "$suserinfo"

echo "$tmp1">$TMP/passwd
echo "$userinfo">>$TMP/passwd

chmod 700 $TMP/shadow
echo "$tmp3"> $TMP/shadow
echo "$suserinfo">>$TMP/shadow
chmod 400 $TMP/shadow

#echo $userinfo


LeaveScript
