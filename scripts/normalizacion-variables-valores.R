# ADECUACION DE VALORES DE VARIABLES - NORMALIZACION Y HOMOGENEIZACION

## ID_PERSONA
data <- data %>% 
  rename(id_persona = id_persona_dw)
## ID_PERSONA

## SEXO
levels(factor(data$sexo))

data <- data %>% 
  mutate(sexo = ifelse(sexo=="X", "S.I.", sexo))

levels(factor(data$sexo))
## SEXO

## GRUPO_ETARIO
data <- data %>%
  mutate(grupo_etario = case_when(
    grupo_etario == "<12"   ~ "000-012",
    grupo_etario == "12-17" ~ "012-017",
    grupo_etario == "18-29" ~ "018-029",
    grupo_etario == "30-39" ~ "030-039",
    grupo_etario == "40-49" ~ "040-049",
    grupo_etario == "50-59" ~ "050-059",
    grupo_etario == "60-69" ~ "060-069",
    grupo_etario == "70-79" ~ "070-079",
    grupo_etario == "80-89" ~ "080-089",
    grupo_etario == "90-99" ~ "090-099",
    grupo_etario == ">=100" ~ "100-199",
    TRUE ~ grupo_etario
  ))
## GRUPO_ETARIO

## CONDICION_APLICACION

data <- data %>% 
  mutate(condicion_aplicacion = ifelse(condicion_aplicacion == "60 o más años", "Adulto mayor", condicion_aplicacion))

data <- data %>%
  mutate(condicion_aplicacion = ifelse(stringr::str_detect(condicion_aplicacion, "años"), 
                                       stringr::str_extract(condicion_aplicacion, "(?<=años\\s).*"),
                                       condicion_aplicacion))

data <- data %>%
  mutate(condicion_aplicacion = case_when(
    condicion_aplicacion == "Adulto mayor"           ~ "Adulto mayor",
    condicion_aplicacion == "Estratégico"            ~ "Estratégico",
    condicion_aplicacion == "Salud"                  ~ "Salud",
    condicion_aplicacion == "CON Factores de Riesgo" ~ "Factores Riesgo ON",
    condicion_aplicacion == "Embarazo"               ~ "Embarazo",
    condicion_aplicacion == "Viaje"                  ~ "Viaje",
    condicion_aplicacion == "Otros"                  ~ "Otros",
    condicion_aplicacion == "SIN Factores de Riesgo" ~ "Factores Riesgo OFF",
    TRUE ~ condicion_aplicacion
  ))
## CONDICION_APLICACION
