echo "Enter Id:"
read a
who | cut -d" " -f1-4 > temp
j=0
for x in `who | cut -d" " -f1`
do
	if [ $x = $a ] ; then
		j=`expr $j + 1`
	fi
done
if [ $j != 0 ] ; then
	echo "User has login on $j terminal" 
	grep -i "$a" temp | cut -d" " -f4
else
	echo "User has not login"
fi
