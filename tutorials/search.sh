#! /bin/bash

count=0
if [ -z $1 ] ; then
  echo "Usage is ./serach.sh <filename>"
  exit 1
fi

dirlist=`ls -R -1 | grep ./ | cut -d ":" -f 1`

ls "./$1" > /dev/null 2> /dev/null

if [ $? -eq 0 ] ; then
 if [ -f "./$1" ] ; then
   echo "./$1 -Regular file"
 elif [ -d "./$1" ] ; then
   echo "./$1 -Directory File "
 else
   echo "./$1 - Special file"
fi

 let "count+=1"

fi

for i in `echo "$dirlist"` 
 do  
  
   ls "$i/$1" > /dev/null 2> /dev/null
   if [ $? -eq 0 ] ; then
     
        if [ -f "$i/$1" ] ; then
           echo "$i/$1 -Regular file"
        elif [ -d "$i/$1" ] ; then
           echo "$i/$1 -Directory File "
        else
           echo "$i/$1 - Special file"
        fi
      let "count+=1"
   fi
done

echo "No Of files and Direcory found : ${count}"  
