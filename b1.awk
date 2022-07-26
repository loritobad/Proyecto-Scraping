#! /usr/bin/awk -f
#Nombre y apellidos del alumno:Enrique Villalobos Torregrosa
#Usuario de la UOC del alumno: pscrevillalobosto
#Fecha:31/05/2022
#Objetivos del script: Sacar punto medio de la columna rango_edad (excluimos niños menores de 10 y mayores de 75), dividir
# el dia del accidente por quincenas. 
#Nombre y tipo de los campos manipulados: 
	#rango_edad(String)
	#day(Int)
	#hora(String)


BEGIN { FS=OFS=","; 
	denominador_edad=2;
	}
	
    	NR==1 { print $1,$2,$3,$4,$5",edad_media",$7,$8,$9,$10",quincena,periodo_dia"} # header
	NR > 1 {
		
		
		
			#excluimos a los menores de 10 años y los mayores de 75 años de la columna rango_edad
			if ($6 ~ /[^,]+[De]\s[0-9][0-9]\s[a]\s[0-9]{2}\s[a-zñ]+[^,]/){
				split($6,anios," "); # spliteamos 
				
				edad1=anios[2];
				edad2=anios[4];
				edad_media=(edad1 + edad2)/denominador_edad;
				$6 = edad_media;
				
			}else{
				next;
			}
			
			
			
			
			#convertimos el dia del accidente en su quincena
			if($9 ~ /[0-9]{1,2}/){
				 if($9 <= 15){
				 	resul = "1ª Quincena"
				 	
				 }else{
				 	resul = "2ª Quincena"
				 	
				 }
				  
			}
			
			# convertimos la hora del día en su parte del día.
			if($1 ~ /[0-9]{1,2}:/){
				 split($1,a,":"); # spliteamos 
				 if(a[1] > "06" && a[1] <= "12"){
				 	dsy= "Mañana"
				 	
				 }
				  if(a[1] > "12"){
				 	dsy= "Tarde"
				 	
				 }
				 if(a[1] >= "21"){
				 	dsy= "Noche"
				 	
				 }
				 if(a[1] >= "00" && a[1] <= "06"){
				 	dsy= "Madrugada"
				 	
				 }
				 
				  
			}
			
			
			print $0, resul, dsy;
		      
		}
		
	
		
END {	} 
