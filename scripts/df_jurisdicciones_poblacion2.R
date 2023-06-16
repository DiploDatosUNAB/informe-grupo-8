
```{r grafico_jurisdicciones_vacunacion}
# aplicaciones segun residencia de cada jurisdiccion.
#ggplot(jurisdicciones_poblacion, aes(n_aplicacion, jurisdiccion)) + 
#  geom_col(aes(res_fix, jurisdiccion, color = "blue")) + 
#  geom_col(aes(nores_fix, jurisdiccion, color = "green"))

# me gustaria hacer un grafico de barras que comparen un jurisdiccion a la vez:
## barra residentes | barra aplicados. 

data_reg %>% 
  group_by(jurisdiccion_aplicacion, jurisdiccion_residencia) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  ggplot(aes(n, jurisdiccion_aplicacion, fill = jurisdiccion_residencia)) + 
  geom_col() +
  guides(fill = "none") +
  theme_classic() +
  labs(title = "Jurisdiccion de residencia y de aplicacion, barras de colores")
#ggsave(paste0("png/jurisdicciones_","residencia_v_aplicacion1" ,".png"))
```
Siguiendo con el consejo de Elio, las barras apiladas no son muy comprensibles, se pueden comparar entre una y otra, pero pocas, en presencia de muchas resulta difícil extraer patrones inteligibles. La siguiente propuesta es no mostrar por jurisdicción en un cruce contra todas las otras, mas sí presentar:
  
  1. los residentes de una jurisdicción en dónde se aplicaron y 
1. los aplicados dentro una jurisdicción de qué origen son.

```{r jur_aplic_resid_porc, fig.show='hold', out.width="50%" }

# 1. los residentes de una jurisdicción en dónde se aplicaron
jurisdicciones_poblacion %>% 
  select(jurisdiccion, res_fix, res_nofix, n_residencia) %>% 
  mutate(porc_fix = res_fix / n_residencia, 
         porc_nofix = res_nofix / n_residencia) %>%
  select(jurisdiccion, porc_fix, porc_nofix) %>% 
  pivot_longer(cols = c(porc_fix, porc_nofix), 
               names_to = "aplicado_destino",
               values_to = "prop_fix") %>% 
  ggplot(aes(prop_fix, jurisdiccion, fill = aplicado_destino)) +
  geom_col() +
  labs(title = "Residentes según jurisdicción de aplicación (%)")+
  xlab("proporción aplicación") +
  theme_classic()

# 2. los aplicados dentro una jurisdicción de qué origen son.
jurisdicciones_poblacion %>% 
  select(jurisdiccion, res_fix, nores_fix, n_aplicacion) %>% 
  mutate(porc_res = res_fix / n_aplicacion, 
         porc_nores = nores_fix / n_aplicacion) %>%
  select(jurisdiccion, porc_res, porc_nores) %>% 
  pivot_longer(cols = c(porc_res, porc_nores), 
               names_to = "origen_aplicado",
               values_to = "prop_resid") %>% 
  ggplot(aes(prop_resid, jurisdiccion, fill = origen_aplicado)) +
  geom_col() +
  labs(title = "Aplicados según jurisdicción de residencia (%)")+
  xlab("proporción residencia") +
  theme_classic()

```
se puede observar que residentes de la provincia de Buenos Aires se aplicaron en otras jurisdcciones mas que otros ciudadanos.

Parece interesante, contrastar esta fuga de bonaerenses contra, cuantas otras personas se fugan de su jurisdiccion y donde tuvieron acogida.
```{r jurisdiccion_distribucion_residentes, message=FALSE}
data_reg %>% 
  group_by(jurisdiccion_residencia, jurisdiccion_aplicacion) %>% 
  summarise(n = n()) %>% 
  mutate(prop = n/sum(n) * 100) %>% 
  arrange(jurisdiccion_residencia) %>% 
  ggplot(aes(jurisdiccion_residencia, jurisdiccion_aplicacion, size = n)) + 
  geom_point(aes(color = jurisdiccion_residencia))
# Guardo
ggsave(paste0("png/jurisdicciones_","residencia_v_aplicacion2" ,".png"))
```
