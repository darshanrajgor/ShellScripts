LeaveScript()
{
	echo "Script has interrupted"
	exit 1
}

PASSWDDIR="/home/23it91/Ass"

echo "Enter User name : "
read groupname

if [ `grep "^${groupname}:" ${PASSWDDIR}/group | wc -l` -le 0 ]
then
	echo "${groupname} not exists"
else
	echo "Are you sure to delete ${groupname} (y/n) : "
	read ch
	if [ $ch == "y" ]
	then
		grep -v -w "${groupname}" ${PASSWDDIR}/group > list1
		grep -v -w "${groupname}" ${PASSWDDIR}/gshadow > list2
	
		mv ${PASSWDDIR}/list1 ${PASSWDDIR}/group
		mv ${PASSWDDIR}/list2 ${PASSWDDIR}/gshadow
	else
		exit 2
	fi
fi

echo ""
echo "Group Deleted"
echo ""

exit 0		
