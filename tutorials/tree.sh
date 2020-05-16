#! /bin/bash

if [ -z $2 ] ; then
 echo " "
 echo "Usage : <scriptname> <sourcedir> <destdir>"
 exit 1
fi

if [ ! -d $1 ] ; then
 echo " "
 echo "Source Directory not Exist"
 echo " "
fi

if [ ! -d $2 ] ; then
 echo " "
 echo "Destination Directory not Exist"
 echo " "
 exit 1
fi

dirlist=`ls -R $1 | grep : | cut -d ":" -f 1 | replace "/" "/t"`

for i in `echo "$dirlist"`
 do
  mkdir "t${2}/$i"
 done


