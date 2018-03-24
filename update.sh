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
   while :
   do
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
      		flag3='false'
      		for (( i=1; i<=${#colarr[@]}; i++))
      		do
            		if [ "$col" == "${colarr[$i]}" ]
            		then
                 		flag3='true'
                 		break
             		fi
      		done
                
                if [ "$flag3" == 'true' ]
                then
                    echo "you can't update the same field twice in one query!! this field will be updated once"
                    break 
                else
                    colarr[$l]=$col
                    (( l = l + 1 ))
                fi
                echo "do you want to add a coulmn ?y/n"
                read ans
                if [ "$ans" == 'n' ]||[ "$ans" == 'N' ]
                then
                     break
                fi
          fi
     done           
                for (( i=1; i<=${#colarr[@]}; i++))
                do
                  pk=`awk -F: -v var1="${colarr[$i]}" '{if($2==var1){print $3}}' /home/hala/dbEngine/DB/$db/$tb/schema`
                  if [ "$pk" == 'primarykey' ]
                  then
                      echo "ERROR: you can't update the primary key field,update faild"
                      faild="true"
                      break 
                  else
                      echo "enter value for : ${colarr[$i]}"
                      read val
                      if [[ -z "$val" ]]
                      then
                           val="null"
                      else
                           tp=`awk -F: -v var1="${colarr[$i]}" '{if($2==var1){print $1}}' /home/hala/dbEngine/DB/$db/$tb/schema`
                           if [ "$tp" == 'int' ]
                           then 
                                if ! [[ "$val" =~ ^[0-9]+$ ]]
                                then
                                        echo "ERROR: you must enter an integer value,update operation failed"
                                        faild="true"
                                break
                           fi
                           elif [ "$tp" == 'String' ]
                           then
                                if ! [[ "$val" =~ ^[a-zA-Z]+$ ]]
                                then
                                        echo "ERROR: you must enter characters only,update operation failed"
                                        faild="true"
                                        break
                                 fi
                           elif [ "$tp" == 'mix' ]
                           then
                                        if ! [[ "$val" =~ ^[a-zA-Z0-9]+$ ]]
                                        then
                                                echo "ERROR: you must enter mix only,update operation failed"
                                                faild="true"
                                                break
                                         fi 
                           fi
                           valarr[$m]=$val
                           (( m = m + 1 ))  
                      fi
                fi
               done
            if [ "$faild" == 'false' ]
            then
               echo "do you want to add a condition to your update statement?y/n"
               read ans

               if [ "$ans" == 'n' ] || [ "$ans" == 'N' ]
               then
               		for (( i=1; i<=${#colarr[@]}; i++))
      	       		do
                    		pos=`awk -F: -v var1="${colarr[$i]}" '{if($2==var1){print NR}}' /home/hala/dbEngine/DB/$db/$tb/schema`
                           awk -F: -v var=$pos -v var2="${valarr[$i]}" '{$var=var2}1' OFS=: /home/hala/dbEngine/DB/$db/$tb/data > /home/hala/temp/tmp.txt && mv /home/hala/temp/tmp.txt /home/hala/dbEngine/DB/$db/$tb/data

               		done

               else 
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
                                            break
                                    fi
                                    elif [ "$tp" == 'String' ]
                                    then
                                                  if ! [[ "$myval" =~ ^[a-zA-Z]+$ ]]
                                                  then
                                                           echo "ERROR: you must enter characters only,update operation failed"
                                                           faild="true"
                                                           break
                                                  fi
                                   elif [ "$tp" == 'mix' ]
                                   then
                                                  if ! [[ "$myval" =~ ^[a-zA-Z0-9]+$ ]]
                                                  then
                                                           echo "ERROR: you must enter mix only,update operation failed"
                                                           faild="true"
                                                           break
                                                   fi 
                                    fi
                            if [ "$faild" == 'true' ]
                            then
                                    echo "can't update table"
                            else
                                    colpos=`awk -F: -v var1="$col" '{if($2==var1){print NR}}' /home/hala/dbEngine/DB/$db/$tb/schema`
                                    for (( i=1; i<=${#colarr[@]}; i++))
      	       		            do
                    		            pos=`awk -F: -v var1="${colarr[$i]}" '{if($2==var1){print NR}}' /home/hala/dbEngine/DB/$db/$tb/schema`
                                            awk -F: -v var=$pos -v var2="${valarr[$i]}" -v var3=$colpos -v var4="$myval" '{if($var3==var4){$var=var2}}1' OFS=: /home/hala/dbEngine/DB/$db/$tb/data > /home/hala/temp/tmp.txt && mv /home/hala/temp/tmp.txt /home/hala/dbEngine/DB/$db/$tb/data

               		            done   
                                 
                            fi       
               fi
             fi
      fi
fi
else
echo "ERROR: No such table"
fi

