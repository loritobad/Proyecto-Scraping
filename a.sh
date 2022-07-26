#!/bin/bash
#Nombre y apellidos del alumno: Enrique Villalobos Torregrosa
#Usuario de la UOC del alumno: pscrevillalobosto
#Fecha: 11/05/2022
#Objetivos del script: Descargar el dataset desde la url https://datos.madrid.es/egob/catalogo/300110-22-
#accidentes-bicicleta.csv y seleccionar los datos necesarios.
#Nombre y tipo de los campos manipulados:


url='https://datos.madrid.es/egob/catalogo/300110-22-accidentes-bicicleta.csv'
file='AccidentesBicicletas_2021.csv'
reducido='short.csv'
#descarga del csv
curl -sSL  -L  --compressed $url > $file

#lectura y selección de atributos del csv
while IFS=';' read -a line; do 

	echo \"${line[0]}\",\"${line[1]}\",\"${line[2]}\",\"${line[6]}\",\"${line[8]}\",\"${line[10]}\",\"${line[11]}\",\"${line[12]}\",\"${line[13]}\"
	       

done < AccidentesBicicletas_2021.csv > short.csv

# valores pedidos
col=( ` head -n1 $reducido| tail -1 |tr ',' '\n' |wc -l` )
reg=( `tail -n+2 $reducido | wc -l  `) 
format_file=( ` ls | sed 's/[^\.]*//' ` )

    			

#identificación de parámetros
if [[ $1 == "" ]]; then
    printf "URL de descarga: $url \n"
    echo "Número de columnas: $col"
    echo "Número de registros: $reg"   
   
    
else
	while getopts ":v" option; do
   	 case $option in
    		v) printf "URL de descarga: $url \n"
    		   echo "Número de columnas: $col"
                  echo "Número de registros: $reg"
                  echo "Formato de los archivos: $format_file"
                  printf "Tipos de datos  \n"
    		   sed -rn	'1p; 
				2s/^[^,][a-zA-Z0-9]{11}[^,]/(String)/g
				2s/[^,][0-9]{2}\/[0-9]{2}\/[0-9]{4}[^,]/(Date)/g
				2s/[^,][0-9]{1,2}\:[0-9]{1,2}\:[0-9]{1,2}[^,]/(Time)/g
				2s/[^,][A-ZÁÉÍÓÚ-]+\s?\w+\s?[A-ZÁÉÍÓÚ-]+[^,]/(String)/g
				2s/[^,](\b(Despejado)\b|\b(Nublado)\b|\b(Lluvia débil)\b|NULL)[^,]/(String)/g
				2s/[^,](\b(Conductor)\b|\b(Peatón)\b|\b(Pasajero)\b)[^,]/(String)/g
				2s/[^,]+[De]\s[0-9][0-9]\s[a]\s[0-9]{2}\s[a-zñ]+[^,]/(String)/g
				2s/[^,](\b(Hombre)\b|\b(Mujer)\b)[^,]/(String)/g
				2s/[^,][0-9][^,]$/(Int)/gp' $reducido
    			;;
    	
        	*)L=${OPTARG}
          	printf "Parámetro no válido --> $L.\n"
          		;;
	esac
done
fi

#borramos el archivo descargado y nos quedamos con short.csv
rm $file
