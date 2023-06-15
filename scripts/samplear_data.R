#source("scripts/samplear_data.R")

# Mi sample persona es la muestra de personas que se extrae. 
# Esto va implicar que estas son las personas que tendran inclusion en el analisis y 
# que son quienes daran valores a las tablas, graficos, etc. 
# Adicionalmente estas personas y sus registros de vacunacion seran incluidos 
# en los analisis temporales de la ultima parte.

# Cuando se realiza SAMPLE recordar si el experimento es con REPOSICION o SIN.
set.seed(8)

data_reg <- data_registros_unicos[sample(1:nrow(data_registros_unicos), 
                                        mi_sample_registros, 
                                        replace = FALSE), ]

print(paste("Reporte, samplear_data.R: esta muestra aleatoria samplea", 
            scales::comma(nrow(data_reg)), 
            "registros."))

rm(mi_sample_registros, data_registros_unicos)

# FIN #

## TEORIA DE SAMPLE: OJO CON LA REPOSICION DE LOS INDICES DEL DOMINIO!!!!!!!!
### FALSE ES SIN REPOSICION! LO QUE YO NECESITABA:
df_sample_false <- data.frame(A=c(sample(1:20, 20, replace = FALSE)))
df_sample_false %>% group_by(A) %>% summarise(n = n()) %>% arrange(desc(n))

df_sample_true  <- data.frame(A=c(sample(1:20, 1000, replace = TRUE)))
df_sample_true %>% group_by(A) %>% summarise(n = n()) %>% arrange(desc(n))

rm(df_sample_true, df_sample_false)

