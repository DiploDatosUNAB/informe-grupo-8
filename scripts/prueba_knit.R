# prueba de knit

data %>% 
  group_by(sexo) %>% 
  summarise(promedio_dosis = mean(orden_dosis))
