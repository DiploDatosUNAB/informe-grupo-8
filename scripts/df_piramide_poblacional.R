
# piramide poblacional por sexo y grupo_etario
df_piramide_poblacional <- data_per %>% 
  group_by(sexo, grupo_etario) %>% 
  summarise(n = n()) %>% 
  subset(sexo != "S.I.") # quito uno de los valores de sexo.

ls_k[["df_pira_pobla"]] <- df_piramide_poblacional

# invierto el signo de poblacion para los masculinos // funcion ifelse es igual a si() en excel.
df_piramide_poblacional$n <- ifelse(df_piramide_poblacional$sexo == "M", 
                                    -df_piramide_poblacional$n, 
                                    df_piramide_poblacional$n)

# mejorar el resultado
n_range <- range(df_piramide_poblacional$n)

# valores de x sin negativos
intervalo <- round(max(abs(n_range[1]), 
                       abs(n_range[2])) / 10,
                   0)

n_range_seq <- seq(n_range[1], 
                   n_range[2],
                   by = intervalo)

# pretty nos ayuda a armar valores de referencia redondeados
pop_range_breaks <- pretty(n_range,
                           n = 7)

# centrar el eje x con el cero --- pendiente
pop_range_breaks <- pretty(seq(-max(pop_range_breaks), 
                               max(pop_range_breaks), 
                               by = 100), 
                           n = 7)

# Gran grafico piramide poblacional de Gizha.
ls_k[["gh_pira_pobla"]] <- df_piramide_poblacional %>% 
  ggplot(aes(x = n, y = grupo_etario, fill = sexo)) +
  geom_col() +
  scale_x_continuous(breaks = pop_range_breaks,
                     labels = scales::comma(abs(pop_range_breaks))) +
  labs(title = "Piramide poblacional por <<sexo>> y <<grupo_etario>>") +
  xlab(label = "Poblacion - Sexo") +
  ylab(label = "Grupo etario") +
  geom_text(aes(label = abs(n)), vjust = 1, hjust = 0.5) +
  theme(legend.position = "right") + ## ubicar la leyenda
  theme_classic() ## 
#ggsave(paste0("png/piramide_poblacional_","sexo_grupo_etario", ".png"))


rm(intervalo, n_range, n_range_seq, pop_range_breaks, df_piramide_poblacional)
 
print("Producto de df_piramide_poblacional: ls_k[[df_pira_pobla]] y ls_k[[gh_pira_pobla]]")
