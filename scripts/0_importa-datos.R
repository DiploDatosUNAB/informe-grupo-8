# Filtrar observaciones para reducir el tiempo computacional de procesado de los datos.

# Cargo la librería de lectura de datos.
library(readr)

# Especifico el path de mi archivo CSV
file_path <<- "datos/datos_nomivac_covid19.csv"

# Importo unicamente las X filas que quiero de ese archivo
data <- read_csv(file_path, n_max = 1000)

# Visualizo los datos
# head(data)

