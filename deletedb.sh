echo "This operation will drop the database: y/n"
read ans
flag="false"

if [ "$ans" == 'y' ]
then
	for file in /home/hala/dbEngine/DB/*
	do
		if [ "$file" == "/home/hala/dbEngine/DB/$1" ]
		then
			rm -r "/home/hala/dbEngine/DB/$1"
                        flag="true"
                        break
		fi
	done
fi


if [ "$flag" == 'true' ]
then
	echo "Database $1 successfully deleted"
else
	echo "ERROR: No Such Database"
fi

