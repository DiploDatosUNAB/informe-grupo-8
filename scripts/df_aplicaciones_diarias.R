
# Obtengo un data frame con aplicaciones por fecha y extiendo con el paquete lubridate para obtener columnas de anio, mes, semana, dia, y combinaciones.

## tabla de aplicaciones diarias:
aplicaciones_diarias <- data_reg %>% 
  group_by(fecha_aplicacion) %>% 
  summarise(dosis = n()) %>% 
  arrange(desc(fecha_aplicacion)) %>% 
  mutate(anio = year(fecha_aplicacion),
         mes = month(fecha_aplicacion),
         semana = sprintf("%02d", week(fecha_aplicacion)),
         dia = wday(fecha_aplicacion, label = TRUE, abbr = FALSE),
         anio_mes = format(fecha_aplicacion, "%Y-%m"),
         anio_semana = paste0(anio,"-",semana),
         anio_dia = paste0(anio,"-",dia))
## variables tiempo con lubridate - anio, mes, semana, dia y combinaciones. Adicionalmente para semana se especifica el formato para que no se elimine el cero delante. El cero delante ya lo deja por default para el mes.

head(aplicaciones_diarias[1:10,1:9])
# Ya tengo una tabla de nombre `r aplicaciones_diarias` que me permite utilizar diferentes enfoques para analizar el fenomeno temporal de la vacunacion. Voy a realizar sumas para cada unidad de tiempo y almacenar los resultados en una lista.

# Con la tabla de `aplicaciones_diarias` creada me puedo fijar rapidamente con unos graficos simples, tendencias en la concurrencia a los vacunatorios e indagar como se distribuyen las vacunas entre los dias de la semana, las semanas, los meses, los años y entre los dias de cada año, las semanas de cada año y los meses de cada año.
