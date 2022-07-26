# Práctica de Scraping 
### Enrique Villalobos Torregrosa [ kike_mto@hotmail.com ]
## ¿Qué hace?
Realiza un proceso de scripting mediante el cual  consulta las estadisticas de accidentes de Bicicleta ocurridos en Madrid en el año 2021 ( https://datos.madrid.es/egob/catalogo/300110-22-accidentes-bicicleta.csv) , limpia los datos, selecciona los datos y realiza los cálculos de los siguientes estadísticos.
- Porcentaje entre hombre y mujeres
- Edad media por sexo.
- Distritos con más accidentes.
- Concentracion de accidentes según mes y género.
- Tiempo atmosferico y periodo del día por genero.

## ¿Cómo funciona?
El proceso comienza ejecutando el archivo run.sh desde una terminal el cual generará un documento HTML en el mismo directorio donde se ejecutó. El documento index.html contiene los resultados del informe.

Instrucciones.

```sh
mkdir proyecto
cd proyecto
git clone https://github.com/loritobad/Proyecto-Scraping.git
./run.sh
```




