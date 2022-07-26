#! /usr/bin/awk -f
#Nombre y apellidos del alumno: Enrique Villalobos Torregrosa
#Usuario de la UOC del alumno: pscrevillalobosto
#Fecha: 29/05/2022
#Objetivos del script: Convertir la columna fecha al nombre del mes, ordenar los datos por hora y nombre del mes, borrar las #dobles comillas, convertir a minuscula el campo distrito y reformatear la hora de la columna hora. Se crea el nuevo campo #"anyo"
#Nombre y tipo de los campos manipulados: 
	#fecha(Date)
	#Distrito(String)
	#hora(Time)

# función para ordenar los registros por hora y mes
function ordenar(ia, va, ib, vb, sa, sb) {
  if(split(toupper(ia), sa) && split(toupper(ib), sb)) {
    if(sa[2] < sb[2]) return -1;
    else if (sa[2] > sb[2]) return 1;
    else {
      
      if(sa[1] < sb[1]) return -1;
      else if (sa[1] > sb[1]) return 1;
      else return 0;
    }
  }
  else return 0;
}
BEGIN { FS=OFS=","; 
	i=0;
	
	}
	
    
	NR==1 { gsub(/"/,"",$0); #eliminamos las dobles comillas 
		print $3",mes",$4, $5, $6, $7, $8, $9",dia_accidente, anyo"} # primera linea
	NR > 1 {
		count+=1
		gsub(/"/,"",$0); #eliminamos las dobles comillas 
		split($2,a,"/"); # spliteamos la fecha usando como separador /
		
		for(i=1;i<=NF;i++){ 
			if($i=="Desconocido"){ #eliminamos los registros que tienen   desconocido 
			next
			};
			
			# cambiamos el número del mes por su nombre
			if(a[2] == "01") { a[2] = "Enero" };  
			if(a[2] == "02") { a[2] = "Febrero" };
			if(a[2] == "03") { a[2] = "Marzo" };
			if(a[2] == "04") { a[2] = "Abril" };
			if(a[2] == "05") { a[2] = "Mayo" };
			if(a[2] == "06") { a[2] = "Junio" };
			if(a[2] == "07") { a[2] = "Julio" };
			if(a[2] == "08") { a[2] = "Agosto" };
			if(a[2] == "09") { a[2] = "Septiembre" };
			if(a[2] == "10") { a[2] = "Octubre" };
			if(a[2] == "11") { a[2] = "Noviembre" };
			if(a[2] == "12") { a[2] = "Diciembre" };
			
			#convertimos el campo "distrito" a minusculas
			 tmp=match($i, /[A-Z]/)
                		if(tmp) {
                        	$4= tolower($4)
               		}
               	
			
		};
		
		#completamos las horas, ejem: 9:43:00 a 09:43:00
               	if ($3 ~ /[0-9]:[0-9]{1,2}:[0-9]{1,2}/){
				split($3,horas,":"); # spliteamos 
				if(horas[1] < 10){
					hora=sprintf("%02d", horas[1]);
					$3 = hora":"horas[2]":"horas[3];
					
				}
				
				
			}
	
		# construimos el record a ordenar
		b[$3","a[2]","$4","$5","$6","$7","$8","$9","a[1]","a[3]];
	
	
		}
		
		
		
END {
	PROCINFO["sorted_in"] = "ordenar";
  	for(i in b) print i;
	cmd="rm " ARGV[1] ; system(cmd) # borramos basura
	} 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
