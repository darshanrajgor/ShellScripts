#!/bin/bash

#This script counts the no of users

no_user=`who | wc -l` #store the no of users in variable

echo " "
echo "No Of Users Loged in is :  "$no_user #Display no of users
echo " "

