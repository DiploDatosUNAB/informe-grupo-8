
# Creo listas donde guardar tablas y "metadata"
ls_genvar_estdesc <- list()
ls_genvar_texto <- list()
varstat <- "dosis"
#fecha_limite <- "2022-12-30"
#filter(fecha_aplicacion <= fecha_limite)

varlist <- c("sexo", "grupo_etario", "condicion_aplicacion", "jurisdiccion_aplicacion", "vacuna")

# Realizar el procesamiento para cada variable (se llama variables dinamica a la iterada)
for (var in varlist) {
  desctabla <- data %>%
    group_by(id_persona) %>%
    filter(fecha_aplicacion == max(fecha_aplicacion)) %>%
    group_by(.data[[var]]) %>%
    summarise(min_dosis = min(orden_dosis),
              mean_dosis = mean(orden_dosis),
              max_dosis = max(orden_dosis),
              poblacion = length(orden_dosis),
              total_dosis = mean_dosis * poblacion) %>%
    mutate(participacion = poblacion / sum(poblacion) * 100) %>% 
    arrange(.data[[var]])
  
  ## Almacenar el resultado en la lista  
  ls_genvar_estdesc[[var]] <- desctabla
  
  ## fecha de corte
  fecha_corte <- max(data$fecha_aplicacion)
  print(paste0("La fecha de corte limite para la elaboracion de esta tabla es: ", fecha_corte))
  
  ## mas_abs: el grupo que en valor absoluto recibió más vacunas
  mas_abs <- desctabla %>% 
    filter(total_dosis == max(total_dosis)) %>% 
    select(.data[[var]])
  print(paste0("La población que mas rebició vacunas en valor absoluto es: ", mas_abs))
  
  ## mas_rel: el grupo que en promedio recibió más vacunas
  mas_rel <- desctabla %>% 
    filter(mean_dosis == max(mean_dosis)) %>% 
    select(.data[[var]])
  print(paste0("La población que mas rebició vacunas en valor absoluto es: ", mas_rel))
  
  ls_genvar_texto[[var]] <- c(fecha_corte, mas_abs, mas_rel)
  
  #Visualizar resultados:
  #print(paste0("Esta base con fecha de corte hasta ", fecha_i, " y agrupación por ", var, " la población ", mas_abs, " recibió ", varstat, " mas vacunas en valor absoluto y ", mas_rel, " en promedio."))
  
}

# Acceder a las tablas de resultados descriptivos de cada variable
for (var in varlist) {
  print("")
  print(paste("Resultados para", var, ":"))
  print(ls_genvar_estdesc[[var]])
  #print(ls_genvar_texto[[var]])
}

rm(list = c("fecha_i", "fecha_corte", "fecha_limite", "mas_abs", "mas_rel", "var", "desctabla", "varlist", "varstat"))

#ls_genvar_estdesc
