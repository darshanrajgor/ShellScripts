a[1]=5
a[2]=2
a[3]=6
max=0
for i in 1 2 3 
do
	if [ $max -le ${a[i]} ] ; then
		max=${a[i]}
	fi
done
echo $max
