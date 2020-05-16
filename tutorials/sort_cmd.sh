#! /bin/bash

if [ -z $1 ];then
  echo "Usage is \"Script_Name -option op1 op2...\""
  exit 1 
elif [ $# -eq 1 ] ; then
  no_data=1
fi

if [ "$1" = "-c" ] ; then
  if [ $no_data = 1 ];then
    echo " " 
    echo -n "Enter Source for Copy: "
    read src
    echo " "
    echo -n "Enter Destination for Copy: " 
    read dest
    
    if [ -e $src ] && [-e $dest] ; then
       cp $src $dest
    else 
       echo " Sourc or destination not exisat"
    fi
 
  else
    cp $2 $3
  fi
   if [ $? -eq 0 ] ; then
     echo "File successfully Completed"
   fi

elif [ "$1" = "-m" ] ; then
    if [ $no_data = 1 ] ; then
       echo " " 
       echo -n "Source for Move: "
       read src
       echo " " 
       echo -n "Destination for Move: "
       read dest
       mv $src $dest
    else
       mv $1 $2
    fi

fi 
