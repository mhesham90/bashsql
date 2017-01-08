#!/bin/bash

function createtble() {
	printf "Enter name for your new table\nName :\t"
	read tblename
	if [ ! -f $tblename ]
	then
		touch $tblename
		printf "Enter the number of columns : "
		read cols
		for num in `seq 1 $cols`
		do
			PS3="->"
			while true
			do
				printf "Enter column $num name : "
				read clnm
				if echo ${colname[@]}|grep $clnm>/dev/null
				then printf "Column exists !\n"
				else
					colname+=($clnm)
					break
				fi
			done
			select choice in 'char' 'integer'
			do
			case $REPLY in
				1)coltype[(( $num - 1 ))]="char"
				break;;
				2)coltype[(( $num - 1 ))]="integer"
				break;;
				*)printf "Not a valid type!\nEnter 1 or 2 "
			esac
			done
		done
		echo ${coltype[@]}|awk '{printf $1;for(i=2;i<=NF;i++){printf ":"$i}printf"\n"}'>>$tblename
		echo ${colname[@]}|awk '{printf $1;for(i=2;i<=NF;i++){printf ":"$i}printf"\n"}'>>$tblename
	else
		printf "Table already exists !\n"
		createtble
	fi
}

function choosetble() {
	select choice in `ls`
	do
		choiceno=0
		for choice in `ls`
		do
			choiceno+=1
			if [[ $choiceno -eq $REPLY ]]
			then
				currtble=$choice
				break 2
			fi
		done
		printf "Not valid !!\nTry again"
	done
	
	select choice in 'Insert into table' 'Update table' 'Delete' 'Display table' 'Drop table'
	do
	case $REPLY in
		1)
		break;;
		2)
		break;;
		3)
		break;;
		4)tail -n +2 $currtble|column -t -s:
		break;;
		5)echo rm currtble
		break;;
		*)printf "Not a valid choice !"
	esac
	done

}
