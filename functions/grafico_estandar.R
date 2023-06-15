# funcion grafico estandar para aplicar a diferentes columnas de un data frame.
## en particular los df ya fueron creados y guardados en una lista.
### esta funcion se aplicaría a varias variables. 

grafico_estandar <- function(lista, elemento, variable){
  
  k_este_grafico <- lista[[elemento]] %>%
    ggplot(aes(.data[[elemento]], .data[[variable]])) +
    geom_col()
  
  return(k_este_grafico)
}
