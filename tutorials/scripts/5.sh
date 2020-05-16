LeaveScript()
{
	echo "Script has been interruped, leaving now..."
	diff ${PASSWDDIR}/passwd tmp/gtmp
	rm /tmp/gtmp /tmp/stmp
	exit 1
}

PASSWDDIR="/home/23it91/Ass"

cp ${PASSWDDIR}/group /tmp/gtmp
cp ${PASSWDDIR}/gshadow /tmp/stmp
chmod 777 /tmp/stmp

echo "Enter Group Name:"
read groupname

if [ `grep "^${groupname}:" /tmp/gtmp | wc -l` -gt 0 ]
then
	echo "${groupname} already exists in the file. choose another"
	rm /tmp/gtmp /tmp/stmp
	exit 1
fi

echo "Enter Gid"
read gid

if [`grep "^${gid}:" /tmp/gtmp | wc -l` -gt 0 ]
then 
	echo"${gid} already exists in the file. choose another"
	rm /tmp/gtmp /tmp/stmp
	exit 1
fi

echo "${groupname}:x:${gid}:" >> /tmp/gtmp

echo "${groupname}:.Cl4oC4GX7df0i::" >> /tmp/stmp
	
cp /tmp/gtmp ${PASSWDDIR}/group
cp /tmp/stmp ${PASSWDDIR}/gshadow

rm -f /tmp/gtmp tmp/stmp

echo ""
echo "Group Added"
echo ""
exit 0


	
	
