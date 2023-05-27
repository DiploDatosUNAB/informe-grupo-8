# usage en el .Rmd: source("scripts/importar-datos.R", local = TRUE, echo = TRUE)

# Filtrar observaciones para reducir el tiempo computacional de procesamiento.

# Cargo la librería de lectura de datos.
library(readr)

# Especifico el path de mi archivo CSV
file_path <<- "datos/datos_nomivac_covid19.csv"

# Importo unicamente las X filas que quiero de ese archivo
data <- readr::read_csv(file_path, n_max = 100)

# Al momento en que yo descargue por unica vez la base al 29/04/2023
#data <- read_csv(file_path, n_max = 115605333)

# Toda la base
#data <- read_csv(file_path)

# Visualizo los datos
# head(data)

