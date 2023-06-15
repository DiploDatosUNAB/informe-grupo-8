
#source("scripts/data_sample.R")

# Mi sample persona es la muestra de personas que se extrae. 
# Esto va implicar que estas son las personas que tendran inclusion en el analisis y 
# que son quienes daran valores a las tablas, graficos, etc. 
# Adicionalmente estas personas y sus registros de vacunacion seran incluidos 
# en los analisis temporales de la ultima parte.

# AHORA SI VOLVAMOS CON LA PRACTICA 
set.seed(8)

id_keep <- data_per[sample(1:nrow(data_per), mi_sample_registros, replace = FALSE), "id_persona"]
id_keep_merge_reg <- id_keep %>% 
  inner_join(data_reg, by = "id_persona")
id_keep_merge_per <- id_keep %>% 
  inner_join(data_per, by = "id_persona")

assign("data_reg", id_keep_merge_reg, envir = .GlobalEnv)
assign("data_per", id_keep_merge_per, envir = .GlobalEnv)

rm(id_keep, id_keep_merge_per, id_keep_merge_reg)

#data_per <- data_per[sample(1:nrow(data_per), mi_sample_registros, replace = FALSE), ]

# Re escribo la base data_reg para solo conservar estos individuos.
#data_sample <- data_per["id_persona"]
#data_reg_2 <- inner_join(data_sample, data_reg, by = "id_persona")

#assign("data_reg", data_reg_2, envir = .GlobalEnv)

# rm(mi_sample_registros, data_sample, data_reg_2)


## TEORIA DE SAMPLE: OJO CON LA REPOSICION DE LOS INDICES DEL DOMINIO!!!!!!!!
### FALSE ES SIN REPOSICION! LO QUE YO NECESITABA:
df_sample_false <- data.frame(A=c(sample(1:20, 20, replace = FALSE)))
df_sample_false %>% group_by(A) %>% summarise(n = n()) %>% arrange(desc(n))

df_sample_true  <- data.frame(A=c(sample(1:20, 1000, replace = TRUE)))
df_sample_true %>% group_by(A) %>% summarise(n = n()) %>% arrange(desc(n))

rm(df_sample_true, df_sample_false)
