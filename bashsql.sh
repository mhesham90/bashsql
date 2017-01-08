#!/bin/bash
chmod +x sqlfunc.sh
. ./sqlfunc.sh
if [ ! -d /home/$LOGNAME/bashdbs ]
then
	mkdir /home/$LGNAME/bashdbs
fi
printf "\n------------------------------------------------------------------\n\e[32;40;1mHello $LOGNME\e[0m\nThis is a simple bashsql DBMS\nEvery single letter in this script was written in vi editor\nIt\`s ok to use and modify it for free\nThis script was written by mhesham :)\n------------------------------------------------------------------\n"
sleep 1

while true
do
	PS3="->"
        printf "\n\e[1mEnter any of the following choices\e[0m\n"
        select choice in 'Create new database' 'Show existing databases' 'use database' 'Delete database' 'Exit'
        do
        case $REPLY in
                1)createdb
                break;;
		2)showdb
		break;;
                3)usdb
                break;;
                4)deletedb
                break;;
                5)extdb
                break;;
		*)printf "Not a valid choice!\nEnter value From 1 to 5."
        esac
done

