
#source("scripts/obtener_registros.R")

## Me quedo con la ultima aplicacion de cada persona
data_per <- data_reg %>% 
  group_by(id_persona) %>% 
  filter(fecha_aplicacion == max(fecha_aplicacion))
