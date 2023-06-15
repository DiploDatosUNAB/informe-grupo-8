# Finalmente creo que es mejor agrandar la base original con las variables de tiempo.
data_reg <- data_reg %>% 
  mutate(anio = year(fecha_aplicacion),
         mes = month(fecha_aplicacion),
         semana = sprintf("%02d", week(fecha_aplicacion)),
         dia = wday(fecha_aplicacion, label = TRUE, abbr = FALSE),
         anio_mes = format(fecha_aplicacion, "%Y-%m"),
         anio_semana = paste0(anio,"-",semana),
         anio_dia = paste0(anio,"-",dia))
