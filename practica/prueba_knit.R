# prueba de knit

data_per %>% 
  group_by(sexo) %>% 
  summarise(promedio_dosis = mean(orden_dosis))
