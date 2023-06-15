# funcion grafico estandar para aplicar a diferentes columnas de un data frame.
## en particular los df ya fueron creados y guardados en una lista.
### esta funcion se aplicaría a varias variables. 

grafico_estandar <- function(lista, elemento, variable){
  
  if(variable == "total_dosis"){
      k_este_grafico <- lista[[elemento]] %>%
      ggplot(aes(.data[[elemento]], .data[[variable]])) +
      geom_col(fill="chocolate") +
      theme_classic() +
      labs(title = paste("Estadístico", variable, "por grupo"))

    } else if (variable == "mean_dosis") {
      k_este_grafico <- lista[[elemento]] %>%
        ggplot(aes(.data[[elemento]], .data[[variable]])) +
        geom_col(fill="steelblue") +
        theme_classic() +
        labs(title = paste("Estadístico", variable, "por grupo"))
    
    } else {
      k_este_grafico <- lista[[elemento]] %>%
        ggplot(aes(.data[[elemento]], .data[[variable]])) +
        geom_col(fill="orange") +
        theme_classic() +
        labs(title = paste("Estadístico", variable, "por grupo"))
      
    }

  return(k_este_grafico)
}

## Colores
##Mas colores: http://sape.inf.usi.ch/quick-reference/ggplot2/colour
##lightcoral
