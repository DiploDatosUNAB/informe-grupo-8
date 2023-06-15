
# Obtengo algunos df sobre las cantidades y participación de la población objetivo de la vacunación desde diferentes perspectivas como son el `sexo`, `grupo_etario`, `condicion_aplicacion` y otras. Las observaciones anteriores de personas son filtradas por la variable `fecha_aplicacion` para conservar en análisis unicamente un registro, el mas actualizado por sujeto.

# Creo listas donde guardar tablas y "metadata"
ls_ed_df <- list()
ls_ed_txt <- list()
varstat <- "dosis"
#fecha_limite <- "2022-12-30"
#filter(fecha_aplicacion <= fecha_limite) 

# Realizar el procesamiento para cada variable (se llama variables dinamica a la iterada)
for (var in varlist_char) {
  desctabla <- data_per %>%
    group_by(.data[[var]]) %>%
    summarise(min_dosis = min(orden_dosis),
              mean_dosis = mean(orden_dosis),
              max_dosis = max(orden_dosis),
              poblacion = length(orden_dosis),
              total_dosis = mean_dosis * poblacion) %>%
    mutate(participacion = poblacion / sum(poblacion) * 100) %>% 
    arrange(.data[[var]]) %>% 
    select(.data[[var]], min_dosis, mean_dosis, max_dosis, total_dosis, poblacion, participacion)
  
  ## Almacenar el resultado en la lista  
  ls_ed_df[[var]] <- desctabla
  
  ## fecha de corte
  #fecha_corte <- max(data_per$fecha_aplicacion)
  #print(paste0("La fecha de corte limite para la elaboracion de esta tabla es: ", fecha_corte))
  
  ## mas_abs: el grupo que en valor absoluto recibió más vacunas
  mas_abs <- desctabla %>% 
    filter(total_dosis == max(total_dosis)) %>% 
    select(.data[[var]])
  
  ## mas_rel: el grupo que en promedio recibió más vacunas
  mas_rel <- desctabla %>% 
    filter(mean_dosis == max(mean_dosis)) %>% 
    select(.data[[var]])
  
  ## Almacenar el resultado en la lista  
  textabla <- data.frame(abs = mas_abs[1,1], rel = mas_rel[1,1])
  ls_ed_txt[[var]] <- textabla
  
  #print(".")
  #print(".")
  #print(var)
  #print(paste0("La población que mas rebició vacunas en valor absoluto es: ", mas_abs))
  #print(paste0("La población que mas rebició vacunas en valor relativo es: ", mas_rel))
  
  
  
  #Visualizar resultados:
  #print(paste0("Esta base con fecha de corte hasta ", fecha_i, " y agrupación por ", var, " la población ", mas_abs, " recibió ", varstat, " mas vacunas en valor absoluto y ", mas_rel, " en promedio."))
  
}


rm(list = c("mas_abs", "mas_rel", "var", "desctabla", "textabla", "varstat"))

#--------------------------------------------------------------------------------------------------------------------

