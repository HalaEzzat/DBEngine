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
flag2="false"
faild="false"
l=1
m=1
if [ "$flag" == 'true' ]
then   
      select choice in "delete all rows" "delete with condition" "Exit"
	do
	case $REPLY in
        1)rm /home/hala/dbEngine/DB/$db/$tb/data
          touch /home/hala/dbEngine/DB/$db/$tb/data
          ;;
        2)
          echo "enter coulmn name"
     	  read col
          for c in `cut -d: -f2 "/home/hala/dbEngine/DB/$db/$tb/schema"`
          do
               if [ "$col" == "$c" ]
               then
                      flag2="true"
                      break
               fi
          done

          if [ "$flag2" == 'true' ]
          then
                echo "enter coulmn value"
                read myval
                if [[ -z "$myval" ]]
                then
                        myval="null"
                else
                               tp=`awk -F: -v var1="$col" '{if($2==var1){print $1}}' /home/hala/dbEngine/DB/$db/$tb/schema`
                               if [ "$tp" == 'int' ]
                               then 
                                     if ! [[ "$myval" =~ ^[0-9]+$ ]]
                                     then
                                             echo "ERROR: you must enter an integer value,update operation failed"
                                             faild="true"

                                      fi
                               elif [ "$tp" == 'String' ]
                               then
                                     if ! [[ "$myval" =~ ^[a-zA-Z]+$ ]]
                                     then
                                              echo "ERROR: you must enter characters only,update operation failed"
                                              faild="true"

                                      fi
                                elif [ "$tp" == 'mix' ]
                                then
                                      if ! [[ "$myval" =~ ^[a-zA-Z0-9]+$ ]]
                                      then
                                              echo "ERROR: you must enter mix only,update operation failed"
                                              faild="true"

                                       fi 
                                 fi
           fi
                                 if [ "$faild" == 'true' ]
                                 then
                                         echo "can't delete with this condition"
                                 else
                                         colpos=`awk -F: -v var1="$col" '{if($2==var1){print NR}}' /home/hala/dbEngine/DB/$db/$tb/schema`
                                         
                                            awk -F: -v var=$colpos -v var2="$myval" '{if($var!=var2){print $0}}' OFS=: /home/hala/dbEngine/DB/$db/$tb/data > /home/hala/temp/tmp.txt && mv /home/hala/temp/tmp.txt /home/hala/dbEngine/DB/$db/$tb/data

               		                  
                                 
                                 fi 

  fi        
;;    
   3)break;;                   
esac 
done
else   
echo "ERROR: no such table"  
fi
