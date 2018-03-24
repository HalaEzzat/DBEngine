flag="false"
db=$1
tb=$2
for file in /home/hala/dbEngine/DB/$db/*
do
	if [ "$file" == "/home/hala/dbEngine/DB/$db/$tb" ]
	then
		flag="true"
		break
	fi
done

if [ "$flag" == 'true' ]
then
	echo "do you like to retrieve all columns? y/n"
	read ans
	if [ "$ans" == 'n' ] || [ "$ans" == 'N' ]
	then
                echo "a menue of availbale coulmns will be displayed please choose one as 1 or 1,2 or 1,2,3"
                echo "to end enter 'end' to apply condition enter 'con' ready? y/n"
                read ans
		select col in `cut -d: -f2 "/home/hala/dbEngine/DB/$db/$tb/schema"`
                do
                case $REPLY in
                "end")break
                  ;;
                "con")echo "enter coulmn number from the menue to apply condition"
                      read col
                      echo "enter colmn value"
                      read val
                      awk -F: -v var1="$col" -v var2="$val"  '{if($var1==var2){print $0}}' /home/hala/dbEngine/DB/$db/$tb/data
                   ;;
                *) cut -d: -f$REPLY "/home/hala/dbEngine/DB/$db/$tb/data"
                   ;;
                 esac
                 done
	else
			cat "/home/hala/dbEngine/DB/$db/$tb/data"
        fi
else
echo "ERROR: no such table"
fi
