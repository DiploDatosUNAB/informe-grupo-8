obtener_estadisticos2 <- function(dataframe, variable){
vardin <- variable
  # desctabla: tabla de estadisticos agrupados por ´vardin´
  desctabla <- dataframe %>%
    group_by(id_persona) %>%
    filter(fecha_aplicacion == max(fecha_aplicacion)) %>%
    group_by(vardin) %>%
    summarise(min_dosis = min(orden_dosis),
              mean_dosis = mean(orden_dosis),
              max_dosis = max(orden_dosis),
              poblacion = length(orden_dosis),
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
