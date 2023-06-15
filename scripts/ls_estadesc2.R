
varlist <- c("orden_dosis", "fecha_aplicacion")

for (esta_variable in varlist) {
  desctabla <- data_per %>% 
    group_by(.data[[esta_variable]]) %>% 
    summarise(n = n()) %>% 
    mutate(prop = n / sum(n)*100)  
  
  # knitr::kable(caption = "Agrupamiento, Registros y Participación")
  
  # almacenar en lista
  ls_ed_df[[esta_variable]] <- desctabla
  
  mas_abs <- desctabla %>% 
    filter(prop == max(prop)) %>% 
    select(.data[[esta_variable]])
  
  textabla <- data.frame(abs = mas_abs)
  
  # almacenar en lista
  ls_ed_txt[[esta_variable]] <- textabla
  
}

rm("desctabla", "textabla", "esta_variable", "varlist", "mas_abs")
