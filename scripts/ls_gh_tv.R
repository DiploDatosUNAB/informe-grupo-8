## agrupar. LUEGO DE AGRUPAR CONDICIONES DE SALUD HABRIA QUE REALIZAR EL 100% de barras apiladas y comparar entre estos periodos.

# etiqueta meses.
x_range_mes <- seq(1:12)
x_range_mes_lab <- c("ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sept", "oct", "nov", "dic")

## Dosis x día de la semana
##```{r gh_ls_timvar_dia, message=FALSE}
## Grafico dosis x dia
ls_tv_sumdosis[["dia"]] %>% 
  ggplot(aes(x = dia, y = suma_dosis)) +
  geom_col(fill = "lightcoral") +
  labs(title = "Dosis aplicadas para cada día") +
  xlab(label = "Días") +
  ylab(label = "Dosis") +
  theme_classic() ## 
ggsave(paste0("png/ls_timvar_","dia", ".png"))
#fin

## Dosis x año
##```{r gh_ls_timvar_anio, message=FALSE}
# Luego de explorar posibles graficos, me resulta interesante que se vea el año que mas peso tiene en las vacunaciones, y partir de lo general ir a lo particular, de lo macro a lo micro. Vamos a hacer zoom en cada periodo temporal y explicar como parece que se comporta la campaña de vacunacion y la poblacion.

## Grafico dosis x anio
ls_tv_sumdosis[["anio"]] %>% 
  ggplot(aes(x = anio, y = suma_dosis)) +
  geom_col(fill = "steelblue") +
  labs(title = "Dosis aplicadas para cada año") +
  xlab(label = "Año") +
  ylab(label = "Dosis") +
  theme_classic() ## 
#ggsave(paste0("png/ls_timvar_","anio", ".png"))
## Es enorme la diferencia entre la vacunacion del anio con mas peso, el 2022, comparado con los otros 2 años disponibles.
ls_tv_sumdosis[["anio"]]
#fin

## Dosis x mes del año con mas vacunación
##```{r gh_ls_timvar_meses_2022, message=FALSE}
# Nos adentramos entonces en el anio con mayor vacunacion para ver como se ejecuto a lo largo de los meses.

## Grafico dosis x mes del año 2022, fill = día
aplicaciones_diarias %>%
  filter(anio == 2022) %>% 
  group_by(mes, dia) %>% 
  summarise(suma_dosis = sum(dosis)) %>% 
  mutate(participacion = suma_dosis / sum(suma_dosis) * 100) %>% 
  ggplot(aes(x = mes, y = suma_dosis, fill = dia)) +
  geom_col() +
  scale_x_continuous(breaks = x_range_mes, 
                     labels = x_range_mes_lab) +
  labs(title = "Dosis aplicadas para cada mes del 2022") +
  xlab(label = "Mes") +
  ylab(label = "Dosis") +
  theme(legend.position = "right") +
  theme_classic() ## 
ggsave(paste0("png/ls_timvar_","meses_2022", ".png"))

# Se vuelve a observar que los dias de semana son los mas registrados para aplicacion de nuevas dosis. Esta observación ya estaba presente en el gráfico anterior en que se presentaban las dosis entregadas cada día de la semana para todo el período registrado.
#fin

## Dosis x cada año_mes
##```{r gh_ls_timvar_anio_mes, message=FALSE, fig.show='hold', out.width = "50%"}

## Para observar con mayor precision descompongo el grafico anterior en meses de todo el periodo, de esta forma obtengo una mayor granulometria que permite ver comportamiento intermensual.
# Grafico dosis x anio_mes
ls_tv_sumdosis[["anio_mes"]] %>% 
  ggplot(aes(x = anio_mes, y = suma_dosis)) +
  geom_col() +
  labs(title = "Dosis aplicadas para cada mes") +
  xlab(label = "Mes") +
  ylab(label = "Dosis") +
  theme_classic() ## 
#ggsave(paste0("png/ls_timvar_","anio_mes", ".png"))

## Aun con mas granulometria, para observar comportamiento intersemanal. 
# Grafico dosis x anio_semana
ls_tv_sumdosis[["anio_semana"]] %>% 
  ggplot(aes(x = anio_semana, y = suma_dosis)) +
  geom_col() +
  labs(title = "Dosis aplicadas para cada semana") +
  xlab(label = "Mes") +
  ylab(label = "Dosis") +
  theme_classic() ## 
#ggsave(paste0("png/ls_timvar_","anio_semana", ".png"))
#fin

#ANIOS
##```{r hp_1_aplic_prioriza, fig.show='hold', message=FALSE, out.width = "30%"}

# 2021
data_reg %>% 
  filter(anio==2021) %>% 
  group_by(mes, condicion_aplicacion) %>% 
  summarise(dosis = n()) %>%
  ggplot(aes( x = mes, y = dosis, fill = condicion_aplicacion)) +
  geom_col() +
  theme_classic() +
  scale_x_continuous(breaks = x_range_mes,
                     labels = x_range_mes_lab)

# 2022
data_reg %>% 
  filter(anio == 2022) %>% 
  group_by(mes, condicion_aplicacion) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(mes, n, fill = condicion_aplicacion)) + 
  geom_col() +
  theme_classic() +
  scale_x_continuous(breaks = x_range_mes,
                     labels = x_range_mes_lab)

# 2023
data_reg %>% 
  filter(anio == 2023) %>% 
  group_by(mes, condicion_aplicacion) %>% 
  summarise(n = n()) %>% 
  ggplot(aes(mes, n, fill = condicion_aplicacion)) + 
  geom_col() +
  theme_classic() +
  scale_x_continuous(breaks = x_range_mes,
                     labels = x_range_mes_lab)


#fin

# FIN #

