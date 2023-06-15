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

print("")

#esta_variable <- "condicion_aplicacion"
#total_dosis <- "total_dosis"
#mas_abs <- paste0(esta_variable,".1") o "mas_abs"
#mas_rel <- paste0(esta_variable,".2") o "mas_rel"
#mean_dosis <- "mean_dosis"

#1. La población que mas rebició vacunas en valor absoluto es: 
#  `r ls_genvar_texto[[esta_variable]][mas_abs]` con 
#`r scales::comma(max(ls_genvar_estdesc[[esta_variable]][total_dosis]))` 
#dosis aplicadas sobre este grupo.

#1. La población que mas rebició vacunas en valor relativo es: 
#  `r ls_genvar_texto[[esta_variable]][mas_rel]` con 
#`r round(max(ls_genvar_estdesc[[esta_variable]][mean_dosis]),2)`
#dosis promedio aplicadas sobre este grupo.
