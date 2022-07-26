#! /usr/bin/awk -f
#Nombre y apellidos del alumno: Enrique Villalobos Torregrosa
#Usuario de la UOC del alumno: pscrevillalobosto
#Fecha:03/06/2022
#Objetivo: Producir un documento en formato html con los principales indicadores.
#Nombre y tipo de los campos de entrada:
	#hora(Time)
	#mes(String)
	#distrito(String)
	#estado_metereologico(String)
	#tipo_persona(String)
	#edad_media(Int)
	#sexo(String)
	#cod_lesividad(Int)
	#dia_accidente(Int)
	#anyo(Int)
	#quincena(String)
	#periodo_día(String)
#Operaciones realizadas: 
	# cálculo porcentaje entre hombres y mujeres
	# edad media de hombres y mujeres
	# distrito donde ocurren más accidentes
	# la concentración de accidentes por mes
	# la concentracion de accidentes según mes y sexo.
	# la influencia del tiempo atmosferico y periodo del día por genero.
#Nombre y tipo de los nuevo campos generados:
	#no hay.

function html_head(){
print "<!DOCTYPE html>"
print "<html lang=\"es\">"
print "<head>"    
print "<title>Accidentes de Bicicleta - Madrid 2021 -</title>"
print "<meta charset=\"UTF-8\">"   
print "<link href=\"styles.css\" rel=\"stylesheet\">"
print "<script src=\"https://cdn.jsdelivr.net/npm/chart.js\"></script>"
print "</head>"
print "<body>"
}

function html_header(total){
print "<header><h3>Informe descriptivo de los accidentes de bicicletas en Madrid (Año 2021)</h3>"
print "<h4>Número de registros: "total"</h4>"
print "</header>"
}
function html_contenido(total,porc_h, porc_m,edad_media_h,edad_media_m,dis, meses_sexo,meses,count_mes,count_periodo_dia){
print "<div class=\"container\">"
print "<aside >"
print "<h4>Mediciones</h4>"
print "<ul>"
print "<li><a href=\"#hym\">Porcentaje entre hombre y mujeres</a></li>"
print "<li><a href=\"#edad\">Edad media por sexo.</a></li>"
print "<li><a href=\"#dis_acc\">Distritos con más accidentes.</a></li>"
print "<li><a href=\"#sexo_mes\">Concentracion de accidentes según mes y género.</a></li>"
print "<li><a href=\"#dia_tiempo\">Tiempo atmosferico y periodo del día por genero.</a></li>"
print "</ul>" 
print "</aside>"
print "<section class=\"body\">"
print "<p>El Ayuntamiento de Madrid ante la subida del precio del combustible en el año 2022 ha decidido generar un nuevo plan de movilidad urbana definiendo como un objetivo estratégico el fomento del transporte privado, en especial las bicicletas, tanto alquiladas como propias.</p>"
print "<p>Para ello, y usando los datos sobre Accidentes de tráfico en la Ciudad de Madrid registrados por la Policía Municipal y donde está implicada al menos una bicicleta se analiza las <b>factores demográficos y características de los accidentes</b>, de tal forma que los recursos y acciones municipales recogidos en el Plan de movilidad mejoren el estado de la movilidad urbana, reduciendo el número de accidentes y cuyo efecto esperado es que la ciudadanía adquiera más confianza en el uso de la bicicleta en el medio urbano.</p>"
print "<h3><b>Análisis.</b></h3>"
print "<h4 class=\"sub\"><b>Factores demográficos.</b></h4>"
print "<p>Una de las cuestiones importantes a la hora de analizar los accidentes de bicicletas es conocer como se distribuyen nuestros datos. Si observamos los datos en cuanto a la distribución por sexo, vemos que hay un <b><mark>"porc_h"%</mark></b> de hombres frente a un <b style=\" color:#CCFF00\"><mark>"porc_m"%</mark></b> de mujeres. Siendo pues los hombres quienes más accidentes tuvieron en el año 2021.</p>"
print "<div class=\"cont2\" id=\"hym\">"
print "<canvas id=\"myChart\"  ></canvas>"
print "</div>"
print "<p>Otros factor que incide en los accidentes es la edad,ya que nos indica quienes usan más a menudo la bicicleta como medio de transporte, convirtiendo este factor en un elemento cláve para enfocar las acciones municipales, por ejemplo, mediante campañas de sensibilización. Vemos pues que la edad media de hombres se situa en <b style=\" color:#CCFF00\"><mark>"edad_media_h"</mark></b> y las de las mujeres en <b style=\" color:#CCFF00\"><mark>"edad_media_m"</mark></b>, lo que nos indica que cohórte demográfica tiene más accidentes dada la poca diferencia entre hombres y mujeres.</p>"
print "<div class=\"cont2\" id=\"edad\">"
print "<canvas id=\"edad_media\"  ></canvas>"
print "</div>"
print "<h4 class=\"sub\"><b>Características de los accidentes.</b></h4>"
print "<p>Una vez observados los factores demográficos veamos que características tienen los propios accidentes.En primer lugar veamos los distritos donde hubieron más accidentes con bicicletas en 2021.</p>"
print "<div class=\"cont2\" id=\"dis_acc\">"
print "<table class=\"blueTable\">"
print "<caption>Distritos con más accidentes.</caption>"
print "<thead>"
print "<tr>"
print "<th>Distrito</th>"
print "<th>Nº accidentes</th>"
print "<th>% accidentes</th>"
print "</tr>"
print "</thead>"
print "<tbody>"
for (k in dis) {
print "<tr>"
print "<td>"k"</td><td>"dis[k]"</td><td>"sprintf("%.2f",(dis[k]/total)*100)"%</td></tr>"
print "<tr>"
}
print "</tbody>"
print "</table>"
print "</div>"
print "<p>Vemos que existe una concentracion de accidentes en el distrito <b><mark> centro con un 11% de accidentes</mark></b> seguido del distrito <b><mark> moncloa-aravaca con un 9.4%</mark></b>. "


print "<div class=\"cont2\" id=\"sexo_mes\">"
print "<table class=\"blueTable\">"
print "<caption>Concentracion mensual de accidentes por género.</caption>"
print "<thead>"
print " <tr>"
print "<th>Mes</th>"
print "<th>% accidentes al mes</th>"
print "<th>Sexo</th>"
print "<th>nº accidentes</th>"
print "<th>% accidentes</th>"

print "</tr>"
print "</thead>"
print "<tbody>"
for (i in meses_sexo) {
print "<tr>"
print "<td rowspan=\"2\" >"i"</td>"
print "<td rowspan=\"2\" >"sprintf("%.2f",(count_mes[i]/total)*100)"%</td>"
for (j in meses_sexo[i]) { 
print "<td >"j"</td>"
print "<td>"meses_sexo[i][j]"</td>"
print "<td>"sprintf("%.2f",(meses_sexo[i][j]/count_mes[i])*100)"%</td>"
print "  </tr>"
}
}
print "</tbody>"
print "</table>"
print "</div>"

print "<p>Si observamos cual es el mes con mayor número de accidentes, vemos una concentración en los meses de <mark><b>Octubre (11.04%) y Mayo(11.04%)</b></mark>, seguido por los meses de <mark><b>Junio(10.90%) y Marzo(10.24%)</b></mark>.En ambos meses los hombres producen más de la  mitad de los accidentes con bicicletas, asimismos son los hombres quienes mas accidentes produjeron a lo largo de todo el año 2021.</p>"

print "<div class=\"cont2\" id=\"dia_tiempo\">"
print "<table class=\"s3egunda\">"
print "<caption>Influencia del tiempo atmosférico y periodo del día por género.</caption>"
print "<thead>"
print " <tr>"
print "<th>Sexo</th>"
print "<th>Tiempo</th>"
print "<th>Periodo del día</th>"
print"<th>Nº accidentes</th>"

print "</tr>"
print "</thead>"
print "<tbody>"

for (i in count_periodo_dia) {
print "<tr>"
print "<td rowspan=\"15\" >"i"</td>"
    for (j in count_periodo_dia[i]) { 
	print "<td rowspan="length(count_periodo_dia[i][j])">"j"</td>"    
     for (k in count_periodo_dia[i][j]) { 
     	print "<td >"k"</td>"
     	print "<td>"count_periodo_dia[i][j][k]"</td>"
     	print "</tr>"
     }
    }
    
    
}
print "</tbody>"
print "</table>"
print "</div>"
print "<p>Por último, veamos como influye el tiempo atmósferico y el periodo del día en que se producen los accidentes.Vemos que la mayoría de accidentes fueron producidos por <b><mark>Hombres en días despejados y por la tarde</mark></b>, hecho que coincide tambien en las mujeres, aunque estás con<b><mark>1/3</mark></b> menos de veces. También se observa que  la situación atmosferica donde más accidentes hubieron fue en <mark><b>Despejado</mark></b> sin diferencias entre ambos sexos. Podemos destacar que los hombres en los días de <mark><b>LLuvia intensa</mark> no sacan la bicicleta por la madrugada</b>,sin embargo las mujeres en los días de <mark><b>LLuvia intensa</mark> no sacan la bicicleta ni por la madrugada ni por la tarde. </p>"
print "</section>"
print "</div>"

}
function html_foot(porc_h, porc_m,edad_media_h,edad_media_m){
print "<footer>"
print "<h4>Informe elaborado por Enrique Villalobos Torregrosa</h4>"
print "</footer>"
print "<script>"
print "var hombre_mujeres = document.getElementById('myChart');"
print "var chart = new Chart(hombre_mujeres, {"
print "type: 'bar',"
print "data: {"
print "labels: [\"Hombres\", \"Mujeres\"],"
print "datasets: [{"
print "  label: \"Porcentaje\","
print "           backgroundColor: ['rgba(255, 99, 132, 0.2)','rgba(255, 159, 64, 0.2)'],"
print "           borderColor: ['rgba(255, 99, 132, 0.2)','rgba(255, 159, 64, 0.2)'],"
print "          data: ["porc_h","porc_m"]"
print "       },]"
print "    },"
print "   options: {plugins: {"
print "           title: {"
print"              display: true,"
print "              text: 'Porcentaje de hombres y mujeres (Año 2021)'"
print "            },"
print "           legend: {"
print "              display: false,"
print "              tooltips: {"
print "      		\"enabled\": true"
print "    }"
print "}}}"
print"});"
print" var edad_media = document.getElementById('edad_media');"
print "var chart = new Chart(edad_media, {"
print "type: 'bar',"
print "data: {"
print "labels: [\"Hombres\", \"Mujeres\"],"
print "datasets: [{"
print "  label: \"Edad media\","
print "           backgroundColor: ['rgba(255, 99, 132, 0.2)','rgba(255, 159, 64, 0.2)'],"
print "           borderColor: ['rgba(255, 99, 132, 0.2)','rgba(255, 159, 64, 0.2)'],"
print "          data: ["edad_media_h","edad_media_m"],"
print "       },]"
print "    },"
print "   options: {plugins: {"
print "           title: {"
print"              display: true,"
print "              text: 'Edad media de hombres y mujeres (Año 2021)'"
print "            },"
print "           legend: {"
print "              display: false,"
print "              tooltips: {"
print "      		\"enabled\": true"
print "    }"
print "}}}"
print"});"
print "</script>"
print "</body>"  
print "</html>"
}

BEGIN {
  FS = ","
  html_head();
 
}



# fila a fila 
{
  
  if (NR!=1){
     
			# acumula numero de hombres y mujeres
			count_h_m[$7]++
			#edad media
			count[$7]++
			col_sum[$7] += $6
			#distrito donde ocurren más accidentes
			dis[$3]++
			#concentracion de accidentes segun mes y sexo.
			count_mes[$2]++			
			meses_sexo[$2][$7]++;
			#periodo del dia con mas accidentes segun genero
			count_periodo_dia[$7][$4][$12]++
			
  };
 
}

END {

     total_hombres = count_h_m["Hombre"];
     total_mujeres = count_h_m["Mujer"];
     edad_media_h=sprintf("%.2f",col_sum["Hombre"] / count["Hombre"]);
     edad_media_m=sprintf("%.2f",col_sum["Mujer"] / count["Mujer"]);
     total_registros = (NR - 1);
     porc_h = sprintf("%.2f",(count_h_m["Hombre"] / total_registros )*100);
     porc_m = sprintf("%.2f",(count_h_m["Mujer"] / total_registros)*100);
     html_header(total_registros);
     html_contenido(total_registros, porc_h, porc_m,edad_media_h,edad_media_m,dis, meses_sexo,       meses,count_mes,count_periodo_dia);
     html_foot(porc_h, porc_m,edad_media_h,edad_media_m);
    }




