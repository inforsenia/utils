#!/bin/bash

FILE_OF_STUDENTS="/tmp/INF_ALUMNOS.txt"

GREP_V_OPTIONS="2021|2022|Pàgina|Data|[0-9]{5}|Segon|Any|Cognoms|Grup"
GREP_V_OPTIONS="$GREP_V_OPTIONS|2023|Página|Fecha|[0-9]{5}|Segon|Any|Cognoms|Grup|Alumno|Edad|Curso"
GREP_V_OPTIONS="$GREP_V_OPTIONS|LLISTA|CENTRE|SÈNIA|CODI|ADREÇA|ESCULTOR|C.P|LOCALITAT|PAIPORTA|TELÈFON"
GREP_V_OPTIONS="$GREP_V_OPTIONS|LISTADO|CENTRO|SÈNIA|POSTAL|TELÉFONO|Código|CÓDIGO|Orden|NIA"
GREP_V_OPTIONS="$GREP_V_OPTIONS|Primer|PRIMER"
GREP_V_OPTIONS="$GREP_V_OPTIONS|TUTOR"
GREP_V_OPTIONS="$GREP_V_OPTIONS|Núm|^[0-9]{2}$|^[0-9]{1}$|^$"

cat  ${FILE_OF_STUDENTS} | grep -vE ${GREP_V_OPTIONS} | sed -e "s%GRUPO:%\n\\n\\\newpage\nGRUPO:%g" > /tmp/onlystudents1.txt

cat /tmp/onlystudents1.txt| sed -e "s%GRUPO:%#GRUPO:%g"|sed -e "s%.*[0-9].*%*&*%g"  >  /tmp/onlystudents.txt


cat /tmp/onlystudents.txt | while read line; do 

    rc=0
	rg=0
	#echo "==$line=="
    echo $line | grep -q ',' || rc=1
    echo $line | grep -q 'GRUPO'| rg=1
	
    if  [ ${rc} -eq 0 ]; then
        #echo  " * ES UN ALUMNO : $line"
        NOMBRE=$(echo $line|cut -d "," -f2)
        APELLIDOS=$(echo $line|cut -d "," -f1)
        APELLIDOSLOPD=$(./python-lopdize-names.py "${APELLIDOS}")
        echo " | $NOMBRE | $APELLIDOSLOPD | "
	else
	    rc=0
	    echo $line | grep -q "GRUPO" || rc=1
		if [ ${rc} -eq 0 ]; then
			echo "" 
			echo "\newpage"
			echo " "
			echo "$line " #|sed -e "s%newpage%\\\newpage%g"
			echo " "
			echo " | NOMBRE | APELLIDOS|"
			echo " |--------|----------|"
		fi
    fi


done

exit 0
