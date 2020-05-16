LeaveScript()
{
	echo "Script has interrupted"
	exit 1
}

PASSWDDIR="/home/23it91/Ass"

i=1

echo "Enter Group name : "
read groupname

if [ `grep "^${groupname}:" ${PASSWDDIR}/group | wc -l` -le 0 ]
then
	echo "${groupname} not exists"
	exit 2
else
	grep -v -w "${groupname}" ${PASSWDDIR}/gshadow > list2
	grep -v -w "${groupname}" ${PASSWDDIR}/group > list1
	grep "${groupname}" ${PASSWDDIR}/group > list
	gname=`cut list -d":" -f1`
	pass=`cut list -d":" -f2`
	gid=`cut list -d":" -f3`
	user=`cut list -d":" -f4`	
fi

echo ""
echo "Group Name : ${gname}"	
echo "Password : ${pass}"
echo "GID : ${gid}"
echo "Group Member : ${user}"
echo ""
echo "Modify Menu"
echo "1.Group nname"
echo "2.GID"
echo "3.Exit"
echo "Enter ur Choice:"
read ch

while [ $ch -ne 3 ]
do
	if [ $ch -eq 1 ]
	then
		echo "Enter New Group Name"
		read gname
		if [ `grep "^${gname}:"  ${PASSWDDIR}/group | wc -l` -gt 0 ]
		then
			echo "${Group}" already exists"
		 	exit 1
		fi

	elif [ $ch -eq 2 ]
	then
		echo "Enter New GID"
		read gid
		if [ `grep "^{gid}:" ${PASSWDDIR}/group | wc -l` -gt 0 ]
		then
			echo "${gid}" already exists"
			exit 1
		fi

	elif [ $ch -eq 3 ]
	then
		exit 2

	else
		echo "Invalid Choice"
	fi
	
	echo ""
	echo "Modify Menu"
	echo "1.Group Name"
	echo "2.GID"
	echo "3.Exit"
	echo "Enter ur Choice:"
	read ch
done

echo "${gname}:x:${gid}" >> ${PASSWDDIR}/list1
echo "${gname}:.Cl4oC4GX7df0i::" >> ${PASSWDDIR}/list2
	 	 
mv ${PASSWDDIR}/list1 ${PASSWDDIR}/group
mv ${PASSWDDIR}/list2 ${PASSWDDIR}/gshadow

echo ""
echo "Group Modify"
echo ""

exit 0		
