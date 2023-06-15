
# source("functions/cruzar_vars.R")

# función que genera un cruce de variables.

cruzar_vars <- function(data, x, y) {
  
  desctabla <- data %>% 
    group_by(x, y) %>% 
    summarise(n = n()) %>% 
    mutate(prop = n / sum(n) * 100) %>% 
    arrange(x)
  
  return(desctabla)
}
