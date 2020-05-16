#! /bin/bash

if [ -z $1 ] ; then
 echo " "
 echo "Usage : <script name> <filename>"
 echo " "
 exit 1
fi

if [ ! -f "$1" ] ; then
 echo " " 
 echo "$1 : File does not exist"
 echo " "
 exit 1
fi

echo -n "Enter First String : "
read str1

echo " "

echo -n "Enter Second string : "
read str2

list=`replace "$str1" "$str2" < "$1"`
echo "$list" > "$1"

echo " "
echo "$str1 is replaced with $str2"
echo " "
  
