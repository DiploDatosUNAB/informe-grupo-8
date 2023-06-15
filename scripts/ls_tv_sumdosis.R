# Armo una lista con agrupaciones por cantidad de aplicaciones por espacio temporal

ls_tv_sumdosis = list()

sumdosis_varlist <- names(aplicaciones_diarias)[-c(1,2)]

for (unidad_tiempo in sumdosis_varlist){
  
  ls_tv_sumdosis[[unidad_tiempo]] <- aplicaciones_diarias %>% 
    group_by_at(vars(one_of({{unidad_tiempo}}))) %>% 
    select(dosis, {{unidad_tiempo}}) %>% 
    summarise(suma_dosis = sum(dosis)) %>%
    mutate(part_dosis = suma_dosis / sum(suma_dosis) * 100) %>% 
    arrange({{unidad_tiempo}})
}

rm(sumdosis_varlist, unidad_tiempo)
