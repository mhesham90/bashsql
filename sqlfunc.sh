#!/bin/bash
chmod +x sqltblefunc.sh
. ./sqltblefunc.sh
function createdb() {
	printf "\nEnter database name :\t"
	read
	if [ ! -d /home/$LOGNAME/bashdbs/$REPLY ]
	then
		mkdir /home/$LOGNAME/bashdbs/$REPLY
		printf "you successfully created $REPLY in '/home/$LOGNAME/bashdbs'\n"
	else
		printf "Database already exists !\n"
		createdb
	fi
	sleep 2
}

function showdb() {
	i=1
	if [ "`ls /home/$LOGNAME/bashdbs`" == "" ]
	then
		printf "No databases found !!\n"
	else
		for file in `ls /home/$LOGNAME/bashdbs`
		do
			printf "$i) $file\n"
			(( i=$i+1 ))
		done
	fi
	sleep 1 
}

function usedb() {
	printf "Select database to use \n"
#	showdb
#	printf "Database NAME :\t"
#	read usdb
#	if [ -d  /home/$LOGNAME/bashdbs/$usdb ]
#	then
	select choice in `ls /home/$LOGNAME/bashdbs`
	do
	if [[ $REPLY -lt `ls /home/$LOGNAME/bashdbs|wc -w` ]]
      	then
       		usdb=$choice
       		cd /home/$LOGNAME/bashdbs/$usdb
		while true
		do
			PS3="->"
        		printf "\n\e[1mEnter any of the following choices\e[0m\n"
        		select choice in 'Create new table' 'choose existing table' 'back'
		        do
		        case $REPLY in
                		1)createtble
                		continue ;;
				2)choosetble
				continue ;;
                		3)
                		break 3;;
				*)printf "Not a valid choice!\nEnter value From 1 to 5."
        		esac
        		done
			printf "Database doesn\`t exist !!\n\n"
			sleep 1
			usedb
		
		done
	fi
	
	done
}

function deletedb() {
	printf "Enter database NAME to delete\n"
	showdb
	printf "Database NAME :\t"
	read dltdb
	if [ -d  /home/$LOGNAME/bashdbs/$dltdb ]
	then

	printf "Are you sure you want to delete $dltdb![y/n]"
	while true
	do
		read
		if [[ "$REPLY" =~ ^([yY][eE][sS]|[yY])$ ]]
		then
			printf "\n\e[1m\e[34m\e[41mDeleting $dltb"
			rm -r /home/$LOGNAME/bashdbs/$dltdb
			sleep .5
			printf "."
			sleep .5
			printf "."
			sleep .5
			printf ".\e[0m\n$dltdb deleted successfully.\n"
			sleep .5
			break
		elif [[ "$REPLY" =~ ^([nN][oO]|[nN])$ ]]
		then
			printf "\nOK that was close but NVM!\n"
			break
		else
			printf "Not a valid choice!\ntype 'y' or 'yes' or 'n' or 'no'"
		fi 
	done
	else
		printf "Database doesn\`t exist !!\n\n"
		sleep 1
		deletedb
	fi
}

function extdb() {
	printf "Are you sure you want to exit ![y/n]"
	while true
	do
		read
		if [[ "$REPLY" =~ ^([yY][eE][sS]|[yY])$ ]]
		then
			printf "\n\e[1m\e[34m\e[41mBye $LOGNAME"
			sleep .5
			printf "."
			sleep .5
			printf "."
			sleep .5
			printf ".\e[0m\n"
			sleep .5
			exit 0
		elif [[ "$REPLY" =~ ^([nN][oO]|[nN])$ ]]
		then
			printf "\nYAY nice choice\n"
			break
		else
			printf "Not a valid choice!\ntype 'y' or 'yes' or 'n' or 'no'"
		fi 
	done
	sleep 2
}
