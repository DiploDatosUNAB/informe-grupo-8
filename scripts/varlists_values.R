
# Obtener los nombres de las columnas de tipo character
varlist_raw <- names(data_per)[sapply(data_per, is.character)]

# Obtener las variables a excluir que terminan en "*id" y las últimas 4 variables
# varlist_no <- c(grep("id$", varlist_raw, value = TRUE), tail(varlist_raw, 4))
varlist_no <- c(tail(varlist_raw, 4))

# Definir las columnas char que pasan por loop de estadisticas descriptivas
varlist_char <- setdiff(varlist_raw, varlist_no)

# Definir las columnas de fecha que se desean incluir en varlist_date
varlist_date <- c("fecha_aplicacion", "dia", "semana", "mes",  "anio", "anio_mes", "anio_semana", "anio_dia")

# Obtener las columnas de fecha que están presentes en el dataframe
varlist_date <- intersect(names(data_reg), varlist_date)

rm(varlist_raw, varlist_no)

# FIN #



# Herramientas para uso de listas tipo pmacro en STATA:

##sapply(data_per, is.character) ## vector logico TRUE / FALSE. sapply aplica a todo el primer argumento, la funcion puesta en el segundo.

##intersect(varlist1, varlist2)

##union(varlist1, "otra_variable")

##union(varlist1, varlist2)

##setdiff(varlist1, varlist_a_sustraer)


