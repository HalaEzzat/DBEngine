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
        m=1       
        coun=1
        for c in `cut -d: -f2 "/home/hala/dbEngine/DB/$db/$tb/schema"`
        do
            echo "enter value for : $c"
            read val
            pk=`awk -F: -v var1="$c" '{if($2==var1){print $3}}' /home/hala/dbEngine/DB/$db/$tb/schema`
            pos=`awk -F: -v var1="$c" '{if($2==var1){print NR}}' /home/hala/dbEngine/DB/$db/$tb/schema`
            if [ "$pk" == 'primarykey' ]
            then
                faild2="true"
                 while [ "$faild2" == 'true' ]
                 do
                   if [[ -z "$val" ]]
                   then
                      echo "$c can't be null because it's the primary key"
                      read val
                   else
               		found=`awk -F: -v var1="$pos" -v ver2="$val" '{if($var1==ver2){print var1}}' /home/hala/dbEngine/DB/$db/$tb/data`
               		if [[ -z "$found" ]]
               		then
                    		faild2="false"
               		else
                    		echo "ERROR: primarykey exists,enter valid primarykey"
                    		read val
               		fi
                   fi
                 done
             fi
              if [[ -z "$val" ]]
              then
                      val="null"
              else
                 tp=`awk -F: -v var1="$c" '{if($2==var1){print $1}}' /home/hala/dbEngine/DB/$db/$tb/schema`
                 if [ "$tp" == 'int' ]
                 then 
                    if ! [[ "$val" =~ ^[0-9]+$ ]]
                    then
                        echo "ERROR: you must enter an integer value,insert operation failed"
                        break
                    fi
                  elif [ "$tp" == 'String' ]
                  then
                        if ! [[ "$val" =~ ^[a-zA-Z]+$ ]]
                        then
                            echo "ERROR: you must enter characters only,insert operation failed"
                            break
                        fi
                   elif [ "$tp" == 'mix' ]
                   then
                        if ! [[ "$val" =~ ^[a-zA-Z0-9]+$ ]]
                        then
                            echo "ERROR: you must enter mix only,insert operation failed"
                            break
                         fi 
                  fi
                fi
                  
                colarr[$m]=$val
                (( m = m + 1 ))  
            

        done
 
   str=''  
   for (( i=1; i<=${#colarr[@]}; i++))
   do
     mycolon=":"
     if [ "$i" == "${#colarr[@]}" ]
     then
         str=$str${colarr[$i]}
     else
         str=$str${colarr[$i]}$mycolon
     fi
done
echo $str >> "/home/hala/dbEngine/DB/$db/$tb/data"
echo "successfully inserted one row"
else
echo "ERROR: no such table"
fi
