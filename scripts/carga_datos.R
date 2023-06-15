
# Introducción al uso de datos de la base NOMIVAC.

# Importar datos -> Muestra
## Se importan los datos en un dataframe de nombre `data`. 
## Se limita la cantidad máxima de filas a importar en la variable `mi_muestra_registros`.

# Defino mi muestra de registros || `mi_muestra_registros` <- 2000
#source("scripts/importar-datos.R")

# Seleccion del sample "cohorte"
## data 1 persona: 1 fila, el último registro `data_per`. Esta representa una *"foto"* estática o estado de situación de vacunación del individuo hasta un momento dado.
## data 1 persona: 1 =< filas (registros de vacunación) `data_reg`.
## Se realiza un **sample** de la muestra de datos importada y filtrada al environment 
## para reducir el tiempo computacional del procesamiento del informe. `mi_sample_registros`
## Defino mi sample registros || `mi_sample_registros` <- 1000
#source("scripts/data_sample.R")

# Exploración de los datos
## Esta sección contiene una breve descripción de los datos cargados.
#* Estructura de los datos
#* Intervalo de fechas del registro
#* Rango y magnitud de la base
#* Descripcion de variables de interés
#* Nombre y tipo de variables
#* Dominio de las variables (valores únicos)

# Estructura de los datos
#* Intervalo de fechas del registro (primero y último de la muestra aleatoria):
## La primer observacion se registró el: **`r min(data_reg$fecha_aplicacion)`** 
## y la última se registró el: **`r max(data_reg$fecha_aplicacion)`**.
## Rango y magnitud de la base (cantidad de observaciones y variables)
## Se presentan las dimensiones de la base `data_per` y `data_reg`:
## Cantidad de filas u observaciones (individuos) consideradas en `data_per` (n) es de: `r nrow(data_per)`.
## Cantidad de filas u observaciones (registros) consideradas en `data_reg` (n) es de: `r nrow(data_reg)`.
## Cantidad de columnas_variables (m) en ambas bases es: `r mean(ncol(data_reg), ncol(data_per))`.
## Dimensiones `data_per`, n | m: `r dim(data_per)`, un dataframe de "cantidad de celdas" `r nrow(data_per)*ncol(data_per)`.
## Dimensiones `data_reg`, n | m: `r dim(data_reg)`, un dataframe de "cantidad de celdas" `r nrow(data_reg)*ncol(data_reg)`. 

# Descripción de variables
#* Los nombres de las variables son las siguientes: `r colnames(data_per)`
#* El tipo de variables se describe a continuación mediante a la segmentación de columnas por `character`, `numeric`, `Date`.
#* Adicionalmente el rango, es decir, el dominio de la variable se presenta para las variables `character` solamente para algunas.
#source("scripts/data_names_summary_levels.R")

rm(columnas_ch, varlist_ch, columnas_date, varlist_date, columnas_num, varlist_num)
