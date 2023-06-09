
# Mi sample persona es la muestra de personas que se extrae. Esto va implicar que estas son las personas que tendran inclusion en el analisis y que son quienes daran valores a las tablas, graficos, etc. Adicionalmente estas personas y sus registros de vacunacion seran incluidos en los analisis temporales de la ultima parte.
data_per <- data_per[sample(1:nrow(data_per), mi_sample_registros, replace = TRUE), 1:18]

# Re escribo la base data_reg para solo conservar estos individuos.
data_sample <- data_per[,1]
data_reg_2 <- inner_join(data_sample, data_reg, by = "id_persona_dw")

assign("data_reg", data_reg_2, envir = .GlobalEnv)

rm(mi_sample_registros, data_sample, data_reg_2)
