
#source("scripts/obtener_registros.R")

## Me quedo con la ultima aplicación de cada persona
data_per <- data_reg %>% 
  group_by(id_persona) %>% 
  filter(fecha_aplicacion == max(fecha_aplicacion))

print(paste("Reporte, obtener_registros.R: esta muestra aleatoria samplea", nrow(data_per), "individuos."))

# assign("data_per", id_keep_merge_per, envir = .GlobalEnv)
