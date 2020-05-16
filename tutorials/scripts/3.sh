LeaveScript()
{
	echo "Script has interrupted"
	exit 1
}

PASSWDDIR="/home/23it91/Ass"
TMPDIR="/var/tmp"
PASSWD="/usr/bin/passwd"
DSHELL="/usr/bin/sh"
DGROUP="other"
DHOME="/home"

i=1

echo "Enter User name : "
read username

if [ `grep "^${username}:" ${PASSWDDIR}/passwd | wc -l` -lt 0 ]
then
	echo "${username} not exists"
else
	grep -v "${username}" ${PASSWDDIR}/passwd > list1
	grep "${username}" ${PASSWDDIR}/passwd > list
	
	while [ $i -lt 11 ]
	do
		for j in `cut list -d":" -f$i`
		do
			a[i]=$j
		#	echo ${a[i]}
			i=`expr $i + 1`
		done
	done
fi

echo ""
echo "Login Name : ${a[1]}"	
echo "Password : ${a[2]}"
echo "UID : ${a[3]}"
echo "Group Name : ${a[4]}"
echo "Comment : ${a[5]}"
echo "GID : ${a[6]}"
echo "Home Directory : ${a[9]}"
echo "Shell : ${a[10]}"

echo ""
echo "Modify Menu"
echo "1.Loginname"
echo "2.UID"
echo "3.Group"
echo "4.Home Directory"
echo "5.Shell"
echo "6.Exit"
echo "Enter ur Choice:"
read ch

while [ $ch -ne 6 ]
do
	if [ $ch -eq 1 ]
	then
		echo "Enter New Login Name"
		read a[1]

	elif [ $ch -eq 2 ]
	then
		echo "Enter New UID"
		read a[3]

	elif [ $ch -eq 3 ]
	then
		echo "Enter New Group"
		read a[4]
		
		if [ -z "${a[4]}" ]
		then
			a[4]=${DGROUP}
		else
			DGROUP=${a[4]}
		fi
	
	elif [ $ch -eq 4 ]
	then
		echo "Enter New Home Directory"
		read a[9]
	
		if [ -z "${a[9]}" ]
		then
			a[9]=${DHOME}
		else
			DHOME=${a[9]}
		fi

	elif [ $ch -eq 5 ]
	then
		echo "Enter New Shell"
		read a[10]
	
	elif [ $ch -eq 6 ]
	then
		exit 2

	else
		echo "Invalid Choice"
	fi
	
	echo ""
	echo "Modify Menu"
	echo "1.Login name"
	echo "2.UID"
	echo "3.Group"
	echo "4.Home Directory"
	echo "5.Shell"
	echo "6.Exit"
	echo "Enter ur Choice:"
	read ch
done

echo "${a[1]}:${a[2]}:${a[3]}:${a[4]}:${a[5]}:${a[6]}:${a[7]}:${a[8]}:${a[9]}:${a[10]}" >> ${PASSWDDIR}/list1
		 	 
mv ${PASSWDDIR}/list1 ${PASSWDDIR}/passwd

exit 0		
