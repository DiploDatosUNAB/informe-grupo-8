# Version actual: quita duplicados

#source("scripts/filtrar_data_repetida.R")

# Encontrar observaciones completamente unicas en el dataframe
df_uni <- data_registro[!duplicated(data_registro), ]

# Obtener las filas NO repetidas según las variables "id_persona_dw" y "fecha_aplicacion"

## Critero de repetido perfecto (filas identicas - todas las variables)
## se repite la misma persona vacunandose el mismo dia mas de una vez:
df_uni_igual_persona_fecha <- data_registro[duplicated(data_registro[c("id_persona_dw", "fecha_aplicacion")]), ]

## Criterio de repetido imperfecto (filas casi iguales - se consideran 2 variables: fecha y persona)
## no se repite la misma persona con mas de una vacuna el mismo día:
df_uni_disti_persona_fecha <- data_registro[!duplicated(data_registro[c("id_persona_dw", "fecha_aplicacion")]), ]
data_registros_unicos <- df_uni_disti_persona_fecha

print(paste("Reporte, filtrar_data_repetida.R: esta muestra tiene", 
            scales::comma(nrow(data_registros_unicos)), 
            "registros únicos."))

rm(data_registro, df_uni_disti_persona_fecha, df_uni, df_uni_igual_persona_fecha)

# FIN #

## Encontrar observaciones completamente iguales en el dataframe
#df_rep <- data_registro[duplicated(data_registro) | duplicated(data_registro, fromLast = TRUE), ]

## Filtrar las observaciones únicas y completamente iguales
#df_rep_uni <- fila_repetida[!duplicated(fila_repetida), ]

# se obtiene la cantidad de individuos en la carga de datos.
#individuos <- data_registro[!duplicated(data_registro$id_persona_dw), ]
## los individuos son unicos


#fila_repetida_persona_fecha <- data_registro[duplicated(data_registro[c("id_persona_dw", "fecha_aplicacion")]) | duplicated(data_registro[c("id_persona_dw", "fecha_aplicacion")], fromLast = TRUE), ]


# existen filas duplicadas para fecha y persona con leve diferencia en alguna variable
# por ejemplo en condicion_aplicacion, vacuna, nombre_generica, existen diferencias 
# id: "14078443925"en data_registro

## debo decidir que hacer con datos de la misma persona para el mismo día. Podria elegir conservar la aplicacion que registre mas 


## Mostrar las observaciones únicas y completamente iguales

### FINALMENTE NO HABIA DUPLICADOS?

### version 2023-06-14

# limpieza de registros extraños, duplicados o multiples

# al tiempo de explorar la base se encuentra que cuando se agrupa por individuo y se filtra por ultima fecha de registro disponible:

# al contrario de lo que se espera, se obtiene mas de un registro que cumple la condicion.

# significa que cada persona con mas de un registro para el mismo día se ha aplicado mas de una vacuna. Esto no estaba previsto por la campaña de vacunacion.

# se entiende que es un error de carga de informacion, de registro o de identificacion de la persona. Cualquiera sea el motivo se quitan de la base a analizar.

#---------------------------------------------------------------------------------------------------------------------------------

# Registros múltiples (descubrimiento_repetidos)

# A continuacion se realizó un join entre la `data_persona` y `data_registro`, y como resultado se obtiene un mensaje de **many to many**. 

# Se esperaba que fuera una base de **one to many** al obtener para la base personas el último registro de vacunación dado por la `fecha_aplicacion`. 

# El resultado motivó a indagar más alcanzando la conclusión que la base tiene algunos errores o duplicados que se quitan a continuación. 

# Abajo una posible solución de quitarlos de análisis.

# se descubrio que varias personas tiene multiples registros en la misma fecha. 

# Habria que inspeccionar mas detalles sobre esas personas y esas fechas de aplicacion en las que coinciden varios registros.

# data_persona = # 9804 total de registros "personas" -> pero no, porque hay registros multiples dentro de la misma fecha: `max(fecha_aplicacion)`.

# data_persona: # 9296 entre unicos y multiples

## Así se obtenia la lista de personas antes. A partir del considerar registros multiples de `id_persona_dw` para la misma `fecha_aplicacion` el criterio se encuentra más abajo.
# data_persona <- data_registro %>% 
#  group_by(id_persona_dw) %>% 
#  filter(fecha_aplicacion == max(fecha_aplicacion))
#  knitr::kable(caption = "Muestra con repitencia de personas", col.names = c("Código ID de persona", "Duplicados"))

# data_persona %>% 
#  group_by(id_persona_dw) %>% 
#  summarise(n = n()) %>%
#  arrange(desc(n)) %>% 
#  head(10) 
# personas con multiples registros en su `max(fecha_aplicacion)`

# data_persona_multiple: 491 registros de personas con multiples.
# data_persona_multiple <- data_persona %>% 
#  group_by(id_persona_dw) %>% 
#  summarise(n = n()) %>%
#  arrange(desc(n)) %>% 
#  filter(n != 1) %>% 
#  select(id_persona_dw)

# data_persona_unica: 8805 registros de personas con unicas.
# data_persona_unica <- data_persona %>% 
#  group_by(id_persona_dw) %>% 
#  summarise(n = n()) %>%
#  arrange(desc(n)) %>% 
#  filter(n == 1) %>% 
#  select(id_persona_dw)
# todos somos unicos. Aca unico significa `id_persona_dw` sin registros multiples para la ultima fecha de vacunacion.

#---------------------------------------------------------------------------------------------------------------------------------

# Join de `data_persona_unica` & `data_registro` 

# Union de `data_persona_unica` con `data_registro` de esas personas y solamente de esas personas.

# Primera base de datos con personas (sin repetirse)
# data_persona_unica %>% 
#  group_by(id_persona_dw) %>% 
#  summarise(n = n()) %>% 
#  arrange(desc(n)) ## chequeado que son `id_persona_dw` unicas

# Segunda base de datos con todos los registros
# data_registro

# Realizar el join uno a muchos
# data_join <- inner_join(data_persona_unica, data_registro, by = "id_persona_dw")
 
#---------------------------------------------------------------------------------------------------------------------------------

# Validacion del inner_join

# compruebo que los valores de la lista de `id_persona` de `data_persona_multiple` no se encuentren comprendidos en los valores de la lista de `id_persona` de `data_join`. 
# La que de ahora en adelante será nuestra base de registros multiples de aquella otra base de personas unicas.

# vector_logico <- data_persona_multiple$id_persona_dw %in% data_join$id_persona_dw

# Comprobar si hay al menos un TRUE

# existe_true <- any(vector_logico)
#if (existe_true) {
#  print("Detener el analisis!!! revisar que los registros de personas con duplicados para su ultima fecha de vacunacion sea filtrada.")
#} else {
#  print("El vector ID de individuos que presentan registros duplicados para la ultima fecha de aplicacion de vacunas ya ha sido sustraido de las bases data_per y data_reg, es seguro continuar el analisis bajo las condiciones enunciadas.")
#}

# Genero la base personas unicas final:
#data_per <- data_join %>% 
#  group_by(id_persona_dw) %>% 
#  filter(fecha_aplicacion == max(fecha_aplicacion))

# Genero la base registros de personas unicas final
#assign("data_reg", data_join, envir = .GlobalEnv)

#data_reg %>% 
#  group_by(id_persona_dw) %>% 
#  summarise(n = n()) %>% 
#  arrange(desc(n)) %>% 
#  head(10) 
#  knitr::kable(caption = "Base registros de vacunacion de la muestra de sujetos-Q", col.names = c("Código ID persona", "Cantidad de registros"))

#data_per %>% 
#  group_by(id_persona_dw) %>% 
#  summarise(n = n()) %>% 
#  arrange(desc(id_persona_dw)) %>% 
#  head(10) 
#  knitr::kable(caption = "Base personas de la muestra de sujetos-Q", col.names = c("Código ID persona", "Cantidad de registros"))

# elimino los demas df creados para comprobacion y busqueda de registros unicos y multiples.
# rm(data_join, data_registro, data_persona, data_persona_multiple, data_persona_unica, vector_logico, existe_true)

