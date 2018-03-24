flag="false"

for file in /home/hala/dbEngine/DB/*
do
	if [ "$file" == "/home/hala/dbEngine/DB/$1" ]
	then
		flag="true"
		break
	fi
done

if [ "$flag" == 'false' ]
then
	echo "No Such Database"
else
	select choice in "create table" "drop table" "select" "insert" "update" "delete rows" "exit"
	do
	case $REPLY in
        1)      
                echo "enter table name"
		read tbname
   		if [[ -z "$tbname" ]]
   		then
   			echo "ERROR: you must enter table name"
   		else
   			./createtb.sh $1 $tbname
   		fi
        ;;
        2)
		echo "enter table name"
		read tbname
   		if [[ -z "$tbname" ]]
   		then
   			echo "ERROR: you must enter table name"
   		else
   			./droptb.sh $1 $tbname
   		fi
        ;;
        3)
                echo "enter table name"
		read tbname
   		if [[ -z "$tbname" ]]
   		then
   			echo "ERROR: you must enter table name"
   		else
   			./select.sh $1 $tbname
   		fi
        ;;
        4)
                echo "enter table name"
		read tbname
   		if [[ -z "$tbname" ]]
   		then
   			echo "ERROR: you must enter table name"
   		else
   			./insert.sh $1 $tbname
   		fi
         ;;
         5)
                echo "enter table name"
		read tbname
   		if [[ -z "$tbname" ]]
   		then
   			echo "ERROR: you must enter table name"
   		else
   			./update.sh $1 $tbname
   		fi
         ;;
         6)
                echo "enter table name"
		read tbname
   		if [[ -z "$tbname" ]]
   		then
   			echo "ERROR: you must enter table name"
   		else
   			./deletetb.sh $1 $tbname
   		fi
          ;;
          7)
                 break
          ;;
          *)
                echo "invalid choice!!"
          ;;
esac
done
fi

