#!/bin/bash
#Nombre y apellidos del alumno: Enrique Villalobos Torregrosa
#Usuario de la UOC del alumno: pscrevillalobosto
#Fecha: 11/05/2022
#Objetivos del script: Eliminar de la columna estado_metereológico los valores NULL y SE DESCONOCE y cambiar los valores NULL de #la columna cod_lesividad por 0
#Nombre y tipo de los campos manipulados:
	#estado_metereologico(String)
	#cod_lesividad(Int)

file_ext1='dat1.csv'
file_ext2='dat2.csv'

# guardamos la cabecera del .csv
header=( ` head -n1 $1| tail -1 ` )

# recorremos el .csv
while IFS=',' read -a line; do 

	# se modifica la columna estado_meterologico para eliminar las filas con valores NULL o Se desconoce.
	 if [ "${line[4]}" == '"NULL"' ] || [ "${line[4]}" == '"Se desconoce"' ]; then
	 	sed -e 1p -e '/\"NULL\",\|,\"Se desconoce\"/d'
         fi
       

done < $1 >$file_ext1

# recorremos el .csv
while IFS=',' read -a line; do 

	# se modifica la columna cod_lesividad para cambiar los valores NUll por 0
	 if [ "${line[8]}" == '"NULL"' ]; then
	 	sed 's/\"NULL\"/\"0\"/g'
         fi
      
done < $file_ext1 > $file_ext2


# insertamos la cabecera
sed -i -e "1 i\\${header}" $file_ext2




#borramos basura
rm $1
rm $file_ext1
