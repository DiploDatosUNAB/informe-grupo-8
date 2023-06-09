# usage en el .Rmd: source("scripts/importar-datos.R", local = TRUE, echo = TRUE)

# Filtrar observaciones para reducir el tiempo computacional de procesamiento.

# Cargo la librería de lectura de datos.
library(readr)

# Especifico el path de mi archivo CSV
file_path <<- "datos/datos_nomivac_covid19.csv"

# Importo unicamente las X filas que quiero de ese archivo
data_registro <- readr::read_csv(file_path, n_max = mi_muestra_registros, show_col_types = FALSE)

# OBJETIVO PARA MAS ADELANTE
# data <- read_csv(file_path, show_col_types = FALSE, col_select = c(id_persona_dw)) 
# Intente realizar un read_csv de toda la base, unicamente la variable o columna ID. 
# El objetivo es realizar un sample de esos individuos y guardar como objeto: data_personas. 
# Luego deseaba realizar un one to many join. 
# Que me importe en otra base data_registros, todos los registros unicamente de esos individuos de la lista data_personas. 
# Lo que no llegue a preveer era que no podria hacer un join sin tener que cargar la base completa previamente. 
# Podria hacerlo para la siguiente entrega y de paso buscar como exportar el archivo csv de salida de las mismas bases data_per/reg para que siempre se utilice las mismas sin necesidad de volver a procesar el total de datos.

print(paste("Reporte parcial: Se cargan:", scales::comma(mi_muestra_registros), "sobservaciones."))
#Reporte parcial: Se cargan `r nrow(data)` observaciones. 

rm(file_path, mi_muestra_registros)
