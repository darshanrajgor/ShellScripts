LeaveScript()
{
	echo "Script has been interruped, leaving now..."
	diff ${PASSWDDIR}/passwd tmp/ptmp
	rm /tmp/ptmp /tmp/stmp
	exit 1
}

ALIASDIR="/etc/mail"
PASSWDDIR="/home/23it91/Ass"
TMPDIR="/var/tmp"
PASSWD="/usr/bin/passwd"

DSHELL="/usr/bin/sh"

DGROUP="other"

DHOME="/home"

if [ $# -eq 0 ]
then
	echo "usage : add_user required user name as argument"
	exit
fi

#if [ -f /home/23it91/Ass/passwd ]
#then
#	echo "The passwd file is in use"
#else
	cp ${PASSWDDIR}/passwd /tmp/ptmp
	cp ${PASSWDDIR}/shadow /tmp/stmp
 	chmod 777 /tmp/stmp
#fi

for username in $*
do
	echo "Select user id for ${username}:"
	read nuid

	echo "${username}'s full name:"
	read fullname

	echo "default group for ${username}: (${DGROUP}):"
	read group
	
	if [ -z "${group}" ]
	then
		group=${DGROUP}
	else
		DGROUP=${group}
	fi
	
	echo "default home directory for ${username}: (${DHOME}):"
	read home
 
	if [ -z "${home}" ]
	then
		home=${DHOME}
	else
		DHOME=${home}
	fi

	if [ -d ${DHOME}/${username} ]
	then
		echo "${username}'s home directory already exists, skipping"
	fi
	#else
	#	mkdir ${DHOME}/${username}
	#	cp /etc/skel/local.profile ${DHOME}/${username}/.profile
	#	cp /etc/skel/local.login ${DHOME}/${username}
	#	chown ${nuid} ${DHOME}/${username}
	#	chgrp ${DGROUP} ${DHOME}/${usernmae}
	#	chown ${nuid} ${DHOME}/${username}/.profile
	#	chgrp ${DGROUP} ${DHOME}/${username}/.profile
	#	chown ${nuid} ${DHOME}/${username}/.login
	#	chgrp ${DGROUP} ${DHOME}/${username}/.login
	#fi

	if [ `grep "^${username}:" /tmp/ptmp | wc -l` -gt 0 ]
	then
		echo "${username} already exists in the file. choose another"
		rm /tmp/ptmp /tmp/stmp
		exit 1
	fi

	gid=`grep "^${group}:" /home/23it91/Ass/group` 
	
	if [ -z "${gid}" ]
	then
		echo "${group} is not a reasonable group"
		rm /tmp/ptmp /tmp/stmp
		exit
	fi

	echo "${username}:x:${nuid}:${gid}:${fullname}:${home}/${username}:${DSHELL}" >> /tmp/ptmp

	echo "${username}:.Cl4oC4GX7df0i:9999::::::" >> /tmp/stmp
	
done

#cp ${PASSWDDIR}/passwd ${PASSWDDIR}/passwd.`date "+%y%m%d"`
#cp ${PASSWDDIR}/shadow ${PASSWDDIR}/shadow.`date "+%y%m%d"`

cp /tmp/ptmp ${PASSWDDIR}/passwd
cp /tmp/stmp ${PASSWDDIR}/shadow

rm -f /tmp/ptmp tmp/stmp

#for username in `cat /tmp/change.passwords | awk -F: '{print $1}'`
#do 
#	echo "Password for ${username} should be \c"
#
#	${PASSWD} ${username}
#done

#rm -f /tmp/change.passwords

exit 0

	
	
