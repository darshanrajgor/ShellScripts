#!/bin/bash
v=`ls -ali | cut -c 1-7 | sort | uniq -d`
echo $v
echo ----
ls -ali > lsfile
echo "total pairs are-is = `echo $v | wc -w`"
for i in $v
do
	grep "$i" lsfile 
	count=`grep "$i" lsfile | wc -l`
	echo "same file for $i = $count"
	echo "--------------------------"
done

