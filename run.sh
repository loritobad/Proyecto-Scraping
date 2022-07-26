#!/bin/bash
#Nombre y apellidos del alumno:Enrique Villalobos Torregrosa
#Usuario de la UOC del alumno: pscrevillalobosto
#Fecha:11/05/2022
#Objetivos del script:el script hace la llamada a todos los scripts de la práctica
#Nombre y tipo de los campos manipulados: 
	

source a.sh
source b.sh short.csv
gawk -f b.awk dat2.csv | gawk -f b1.awk | gawk -f c.awk > final.html
 
