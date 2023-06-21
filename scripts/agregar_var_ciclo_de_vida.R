## Agregar variable ciclo de vida:

## para este análisis
#data_reg <- data_reg %>% 
#  subset(cond_grupo == "No vulnerable") 

data_reg <- data_reg %>% 
  mutate(edad_proxy = as.numeric(substr(grupo_etario, 
                                        nchar(grupo_etario) - 2,
                                        nchar(grupo_etario))),
         
         ciclo_de_vida = ifelse(edad_proxy <= 29 & edad_proxy >= 18, "joven",
                                ifelse(edad_proxy <= 17, "menor", "adulto")))
