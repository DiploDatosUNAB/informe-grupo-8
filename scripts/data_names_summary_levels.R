
# Descripción de variables de interés

# Presentacion de las variables, a título informativo estos son los nombres. 
colnames(data_per)

# A continuación se seleccionan algunas variables para brindar mayores detalles de las mismas.

# vector logico que itera en las columnas de mi data frame.
columnas_ch <- sapply(data_per, is.character)
columnas_num <- sapply(data_per, is.numeric)
columnas_date <- sapply(data_per, is.Date)

# utilizo el vector logico para traer un nuevo vector con los nombres que dan TRUE en el anterior
columnas_ch <- names(data_per)[columnas_ch]
columnas_num <- names(data_per)[columnas_num]
columnas_date <- names(data_per)[columnas_date]

cat("\n")
print("Character")
print(paste0("variable ", columnas_ch, ": character"))
cat("\n")
print("Numeric")
print(paste0("variable ", columnas_num, ": es numerica"))
cat("\n")
print("Date")
print(paste0("variable ", columnas_date, ": es fecha"))
cat("\n")

varlist_ch <- columnas_ch[-c(4, 5, 6, 8, 9, 10, 14)] 
varlist_num <- columnas_ch[-c(1, 2)] 
varlist_date <- columnas_date[1]

varlist_ch <- matrix(varlist_ch, ncol = 1) ## reemplaza en el environment los "values" por "data".
columnas_ch <- matrix(columnas_ch, ncol = 1)

## Dominio de las variables (valores únicos)

# Se presentan a continuación los valores posibles que registran algunas de las variables, algo a lo que también haremos referencia como su dominio.

#varlist <- c("sexo","grupo_etario","condicion_aplicacion","vacuna", "nombre_dosis_generica", "orden_dosis")

for (vardin in varlist_ch){
  var_output <- data_reg[[vardin]]
  cat("\n")
  print(paste0("Niveles de la variable: ", vardin, ""))
  print(levels(factor(var_output)))
  cat("\n")
  #distinct(data, var_output)
}
rm(var_output, vardin)

#summary(data) # comento summary porque al no tratarse de una base muy numerica no me sirve de mucho este resumen.

#Breve descripción del tipo de datos disponibles en NOMIVAC. La gran mayoría son character, excepcion de fecha y orden dosis, así como  variables id_codigos asociadas a otras descripcion_codigos.
