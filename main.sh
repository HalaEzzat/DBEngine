select choice in "create database" "use Database" "delete database" "Exit"
do
case $REPLY in
1) echo "enter the name of the database"
   read dbname
   if [[ -z "$dbname" ]]
   then
   echo "ERROR: you must enter the database name"
   else
   ./createdb.sh $dbname
   fi
;;
2) echo "enter the name of the database"
   read dbname
   if [[ -z "$dbname" ]]
   then
   echo "ERROR: you must enter the database name"
   else
   ./usedb.sh $dbname
   fi
;;
3)  echo "enter the name of the database"
   read dbname
   if [[ -z "$dbname" ]]
   then
   echo "ERROR: you must enter the database name"
   else
   ./deletedb.sh $dbname
   fi
;;
4) break
;;
5)echo "invalid choice"
;;
esac
done
