flag="false"
db=$1
tb=$2
for file in /home/hala/dbEngine/DB/$db/*
do
if [ "$file" == "/home/hala/dbEngine/DB/$db/$tb" ]
then
echo "ERROR: Can't create table $2; table exists"
flag="true"
break
fi
done
pk="false"
pkcol='' 
flag3="false"
if [ "$flag" == 'false' ]
then
	
	echo "enter number of coulmns"
	read colNo
	typeset typearr[colNo]
	typeset colarr[colNo]
	for (( i=1; i<=$colNo; i++))
	do
		flag2="true"
                while [ "$flag2" == 'true' ]
                do		
		echo "choose the type of the column($i): 1) int 2)String 3)mix"
		read choice
		if [ "$choice" == '1' ]
		then
			typearr[$i]="int"
			flag2="false"
		elif [ "$choice" == '2' ]
		then
			typearr[$i]="String"
			flag2="false"
		elif [ "$choice" == '3' ]
                then
			typearr[$i]="mix"
			flag2="false"
                else
			echo "undefined choice"		
		fi
                done
		echo "please enter the name of the coulmn"
		read colName
                if [ "$colName" == 'colNo' ] || [ "$colName" == 'primarykey' ]
                then 
                echo "ERROR: Invalid coulmn name"
                echo "Table couldn't be created"
                colNo=0
                flag3="true"
                break
                else
		colarr[$i]=$colName
                fi
                if [ "$pk" == 'false' ]
                then
                echo "is primary key? y/n"
                read ans
                if [ "$ans" == 'y' ]
                then 
                pk="true"
                pkcol=$colName
                pkcolno=$i
                fi
                fi
	done
#                flag3 ="false"
		for (( j=1; j<=$colNo; j++))
		do
                  for (( m=$j+1; m<=$colNo; m++))
		  do
			if [ "${colarr[$j]}" == "${colarr[$m]}" ]
                        then
                             echo "ERROR: you can't have two columns with the same name ,table couldn't be created!!"
                             flag3="true;"
                        fi
		  done	
		done
             if [ "$flag3" == 'false' ]
             then
                mkdir /home/hala/dbEngine/DB/$db/$tb
                touch /home/hala/dbEngine/DB/$db/$tb/data
	        touch /home/hala/dbEngine/DB/$db/$tb/schema
                
		for (( l=1; l<=$colNo; l++))
		do
                         if [ "$l" == "$pkcolno" ]
                         then
                             echo "${typearr[$l]}:${colarr[$l]}:primarykey" >> "/home/hala/dbEngine/DB/$db/$tb/schema"
                         else
                             echo "${typearr[$l]}:${colarr[$l]}" >> "/home/hala/dbEngine/DB/$db/$tb/schema"
                         fi

		done

	     fi
fi

