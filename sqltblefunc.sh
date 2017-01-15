#!/bin/bash
chmod +x sqltblemodfunc.sh
. ./sqltblemodfunc.sh

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
				if [[ $num -eq 1 ]]
				then
				printf "Enter Primary key column name : "
				else
				printf "Enter column $num name : "
				fi
				read clnm
				if echo ${colname[@]}|grep $clnm>/dev/null
				then printf "Column exists !\n"
				else
					colname+=($clnm)
					break
				fi
			done
			printf "choose column type\n"
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
	printf "\n Choose table:\n"
	select choice in `ls`
	do
			if [[ $REPLY -lt `ls|wc -w` ]]
			then
				currtble=$choice
				break 
			fi
	
		printf "Not valid !!\nTry again"
	done
	printf "\nSelect choice for table $currtble\n"	
	select choice in 'Insert into table' 'Update table' 'Delete' 'Display table' 'Drop table' 'Back'
	do
	case $REPLY in
		1)insrt
		break;;
		2)updt
		break;;
		3)dlt
		break;;
		4)disptble
		break;;
		5)echo rm $currtble
		break;;
		6)break;;
		*)printf "Not a valid choice !"
	esac
	done

}
