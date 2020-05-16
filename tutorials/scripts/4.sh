LeaveScript()
{
	echo "Script has interrupted"
	exit 1
}

PASSWDDIR="/home/23it91/Ass"

echo "Enter User name : "
read username

if [ `grep "^${username}:" ${PASSWDDIR}/passwd | wc -l` -lt 0 ]
then
	echo "${username} not exists"
else
	echo "Are you sure to delete ${username} (y/n) : "
	read ch
	if [ $ch == "y" ]
	then
		grep -v "${username}" ${PASSWDDIR}/passwd > list1
		grep -v "${username}" ${PASSWDDIR}/shadow > list2
	
		mv ${PASSWDDIR}/list1 ${PASSWDDIR}/passwd
		mv ${PASSWDDIR}/list2 ${PASSWDDIR}/shadow
	else
		exit 2
	fi
fi

echo ""
echo "User Deleted"
echo ""

exit 0		
