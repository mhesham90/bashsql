#!/bin/bash
shopt -s extglob
function insrt () {
	typeset -i i=1
	for insrtclmn in `awk -F: '{$1=$1;if(NR==2)print $0}' $currtble`
	do
		printf "\nInsert column '$insrtclmn' value : "
		while true
		do
			read columnval
			
			#check pk
			exists=`awk -F: '{if($1=='"$columnval"'){print $0}}' $currtble`
			if [[ $i -eq 1 ]]
 			then
				if [[ $columnval = "" ]]
				then 
       					echo "primary key can't be null !!" 
     				elif [[ "$exists" != "" ]]
    				then  
					echo "primary key already exists !!"
         			else
					break
				fi
			else
				break
			fi
		done
		
		#check datatype
		while true
		do
			datatype=`awk -F: -v j=$i '{if(NR==1)print$j}' $currtble`
			if [[ "$datatype" = integer ]]
			then 
			case $columnval in 
				+([[:digit:]]))
				insrt+=($columnval)
				break
				;;
				*) echo "Please Enter integer datatype"
				read columnval
				;;
			esac
			else 
				insrt+=($columnval)
				break
			fi 
	
		done
	i+=1
	done
	
	echo ${insrt[@]}|awk '{printf $1;for(i=2;i<=NF;i++){printf ":"$i}printf"\n"}'>>$currtble
	unset insrt[@]
}

function updt () {
	printf "Enter Primary key for row you wish to update : "
        read pttrn
        lined=`cat $currtble|awk -F: '{if($1=='$pttrn')print $0}'`
        echo $lined
        if [ "$lined" != "" ]
        then

	typeset -i i=1
	for insrtclmn in `awk -F: '{$1=$1;if(NR==2)print $0}' $currtble`
	do
		printf "\nUpdate column '$insrtclmn' value : "
		while true
		do
			read columnval
			
			#check pk
			exists=`sed /$lined/d $currtble|awk -F: '{if($1=='"$columnval"'){print $0}}'`
			if [[ $i -eq 1 ]]
 			then
				if [[ $columnval = "" ]]
				then 
       					echo "primary key can't be null !!" 
     				elif [[ "$exists" != "" ]]
    				then  
					echo "primary key already exists !!"
         			else
					break
				fi
			else
				break
			fi
		done
		
		#check datatype
		while true
		do
			datatype=`awk -F: -v j=$i '{if(NR==1)print$j}' $currtble`
			if [[ "$datatype" = integer ]]
			then 
			case $columnval in 
				+([[:digit:]]))
				insrt+=($columnval)
				break
				;;
				*) echo "Please Enter integer datatype"
				read columnval
				;;
			esac
			else 
				insrt+=($columnval)
				break
			fi 
	
		done
	i+=1
	done
	
		newline=`echo ${insrt[@]}|awk '{printf $1;for(i=2;i<=NF;i++){printf ":"$i}printf"\n"}'`
        	        
		sed s/"$lined"/"$newline"/ $currtble>/home/$LOGNAME/bashdbs/$usdb/temp
		mv /home/$LOGNAME/bashdbs/$usdb/temp $currtble
		unset insrt[@]	

        else
                printf "Primary key doesn't exist!"
        fi

}

function dlt () {
	printf "Enter Primary key for row you wish to delete : "
	read pttrn
	lined=`cat $currtble|awk -F: '{if($1=='$pttrn')print $0}'`
	echo $lined
	if [[ "$lined" != "" ]]
	then
		sed /"$lined"/d $currtble>/home/$LOGNAME/bashdbs/$usdb/temp
		mv /home/$LOGNAME/bashdbs/$usdb/temp $currtble
		echo deleted successfuly
	else
		printf "Primary key doesn't exist!"
	fi
}

function disptble {
printf "Select choice from:\n"
select choice in "display row from $currtble" "disaplay all table $currtble"
do
case $REPLY in
	1)
	printf "\nEnter primary key of the row you wish to display"
	read pttrn
	lined=`awk -F: '{if($1=='$pttrn'){print $0}}' $currtble`
	if [[ "$lined" != "" ]]
	then

	echo --------------------------------------------------------
		awk -F: '{$1=$1;if(NR==2 || $1=='$pttrn'){print $0}}' $currtble|column -t

	echo --------------------------------------------------------
	else
		printf "key doesn't exist\n\n" 
	fi
	read -sn 1 -p "press any key"
	echo " "
	break;;
	
	2)
	echo --------------------------------------------------------
	tail -n +2 $currtble|column -t -s:
	echo --------------------------------------------------------
	read -sn 1 -p "press any key"
	echo " "
	break;;
	
	*) echo $REPLY is not a choice 
	;;
	esac
	done

	break
}

