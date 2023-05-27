# Remover el Informe.Rmd los chunks que:
# Para varias variables categoricas se repite muchas veces el mismo codigo para obtener tablas estadisticas. 

# Esas tablas cuentan con :
## group_by() agrupamiento por persona: solo una observacion por ´id_persona´
## filter() filtrado por fecha: se toma el ultimo dato disponible de esa persona a ´fecha_input´
## group_by() agrupamiento por variable categorica: se conforman los grupos de la tabla, por ejemplo: ´sexo´ o ´vacuna´
## summarise() de cada grupo se obtiene min_dosis, mean_dosis, max_dosis, poblacion, n_dosis, participacion sobre total.

## Adicionalmente se obtiene para extraer al texto principal del Informe.Rmd:
### la fecha de corte introducida ´fecha_i´, 
### el grupo que mas vacunas recibio en valor absoluto ´mas_abs´,
### el grupo que mas vacunas recibio en promedio ´mas_rel´.

# Ya que se repite el mismo proceso para las variables: 
# varlist <- c("sexo", "grupo_etario", "condicion_aplicacion", "vacuna", "jurisdiccion_aplicacion", "jurisdiccion_residencia", "depto_aplicacion", "depto_residencia")
# atexto[[var]] <- c(fecha_i, mas_abs, mas_rel)
# resulta procedente dejarlo por separado en la forma de una funcion que se describa como

# data es el data frame,
# fecha de corte, es hasta que fecha se realiza el filtro
# varstat es la variable sobre la que se practica el summarise
# vardin es la variable sobre la cual se forman los grupos de tabla

obtener_estadisticos <- function(input_data, fecha_corte, vardin, varstat){
  
  # obtener_estadisticos(data, fecha_corte = max(data$fecha_aplicacion), vardin = sexo, varstat = orden_dosis)
  input_data
  fecha_corte 
  vardin 
  varstat 

  # desctabla: tabla de estadisticos agrupados por ´vardin´
  desctabla <- input_data %>%
    group_by(id_persona) %>%
    filter(fecha_aplicacion <= fecha_corte) %>% 
    filter(fecha_aplicacion == max(fecha_aplicacion)) %>%
    group_by(vardin) %>%
    summarise(min_dosis = min(varstat),
              mean_dosis = mean(varstat),
              max_dosis = max(varstat),
              poblacion = length(varstat),
              n_dosis = mean_dosis * poblacion) %>%
    mutate(participacion = poblacion / sum(poblacion) * 100) %>% 
    arrange(vardin)
  
  ## desclist absorbe desctablas, guarda el resultado en la lista  
  desclist[[vardin]] <- desctabla
  
  # atexto: datos para reemplazar en el texto del Rmd
  
  ## fecha de corte
  fecha_i <- fecha_corte
  
  ## mas_abs: el grupo que en valor absoluto recibió más vacunas
  mas_abs <- desctabla %>% 
    filter(n_dosis == max(n_dosis)) %>% 
    select(vardin)
  
  ## mas_rel: el grupo que en promedio recibió más vacunas
  mas_rel <- desctabla %>% 
    filter(mean_dosis == max(mean_dosis)) %>% 
    select(vardin)
  
  ## atexto absorbe fecha_corte y grupo_i con mas mean_varstat y mas N_poblacion
  atexto[[var]] <- c(fecha_i, mas_abs, mas_rel)
  }
