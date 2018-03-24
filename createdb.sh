flag="false"
for file in /home/hala/dbEngine/DB/*
do
if [ "$file" == "/home/hala/dbEngine/DB/$1" ]
then
echo "ERROR: Can't create database $1; database exists"
flag="true"
break
fi
done
if [ "$flag" == 'false' ]
then
mkdir /home/hala/dbEngine/DB/$1
echo "Database Successfully created"
fi
