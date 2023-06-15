ls_prop_sexo_dosis <- list() 

# Obtener cantidad de personas por cantidad de dosis aplicadas y por sexo:
ls_prop_sexo_dosis[["sexo_dosis"]] <- data_per %>% 
  group_by(sexo, orden_dosis) %>% 
  summarise(n = n()) %>% 
  mutate(proporcion = n / sum(n) * 100) 

#ls_prop_sexo_dosis[["sexo_dosis"]] %>% 
#  ggplot(aes(sexo, orden_dosis, fill = orden_dosis)) +
#  geom_col() + 
#  theme_classic() +
#  labs(title = "Proporcion de personas por cantidad de dosis de vacunas separados por sexo")
#ggsave(paste0("png/prop_","sexo_dosis", ".png"))

# Armar la tabla en formato wide
ls_prop_sexo_dosis[["sexo_dosis_w"]] <- data_per %>%
  group_by(sexo, orden_dosis) %>% 
  summarise(n = n()) %>% 
  pivot_wider(names_from = sexo, 
              values_from = n, 
              values_fill = 0)

#ls_prop_sexo_dosis[["sexo_dosis_w"]] %>% 
#  knitr::kable(caption = "Nivel de inmunización por sexo", 
#               col.names = c("Nivel", "Femenino", "Masculino", "S.I."))

# Armar una tabla como antes, solo para M y con prop
ls_prop_sexo_dosis[["sexo_masc_dosis"]] <- data_per %>% 
  filter(sexo == "M") %>% 
  group_by(orden_dosis) %>% 
  summarise(M_pob = n()) %>% 
  mutate(M_nrel = M_pob/sum(M_pob) * 100,
         Freq_rel_acum_M = (cumsum(M_pob) / sum(M_pob) * 100)) %>% 
  arrange((orden_dosis))

# Armar una tabla como antes, solo para F y con prop
ls_prop_sexo_dosis[["sexo_feme_dosis"]] <- data_per %>% 
  filter(sexo == "F") %>% 
  group_by(orden_dosis) %>%
  summarise(F_pob = n()) %>%
  mutate(F_nrel = F_pob/sum(F_pob) * 100,
         Freq_rel_acum_F = (cumsum(F_pob) / sum(F_pob) * 100)) %>% 
  arrange((orden_dosis)) 

# Full outer join: combinacion externa es cuando algun codigo identificador no esta disponible en la otra base. 
# En este caso debe agregarse el parametro all = TRUE para que aquellos sin coincidencia en el merge no se eliminen.
ls_prop_sexo_dosis[["sexos_dosis"]] <- merge(ls_prop_sexo_dosis[["sexo_masc_dosis"]],
                                             ls_prop_sexo_dosis[["sexo_feme_dosis"]], 
                                             by = "orden_dosis", all = TRUE) %>% 
  arrange(orden_dosis)
