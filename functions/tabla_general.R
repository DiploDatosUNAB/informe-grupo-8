# funcion tabla general para aplicar a diferentes columnas de un data frame.
## en particular los df ya fueron creados y guardados en una lista.
### esta funcion se aplicaría a varias variables. 

tabla_general <- function(lista, elemento, variable) {
  
  k_esta_tabla <- lista[[elemento]] %>% 
  knitr::kable(caption = paste0("Variable ", elemento, " - Estadisticas descriptivas sobre dosis aplicadas al grupo"), 
               col.names = c("Grupo", 
                             "Dosis minima",
                             "Dosis promedio",
                             "Dosis maxima", 
                             "Dosis totales", 
                             "Poblacion", 
                             "Participacion"))
  return(k_esta_tabla)
}
