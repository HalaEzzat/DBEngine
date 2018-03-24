flag="false"
db=$1
tb=$2
echo "This operation will drop the table: y/n"
read ans
if [ "$ans" = 'y' ]
then
for file in /home/hala/dbEngine/DB/$db/*
do
if [ "$file" == "/home/hala/dbEngine/DB/$db/$tb" ]
then
rm -r $file
flag="true"
break
fi
done

if [ "$flag" == 'false' ]
then
echo "ERROR: No Such Table"
else
echo "Table $tb successfully deleted"
fi
else
echo "Nothing deleted"
fi
