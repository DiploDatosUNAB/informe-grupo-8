# Variable de agregacion de condicion_aplicacion y grupo_etario = cond_grupo.

## Haciendo uso de `CONDICION_APLICACION`

ca <- "condicion_aplicacion"
data_reg$cond_grupo <- 
  ifelse(data_reg$condicion_aplicacion == "Adulto mayor",             "Vulnerable",
  ifelse(data_reg$condicion_aplicacion == "Embarazo",                 "Vulnerable",
  ifelse(data_reg$condicion_aplicacion == "Factores Riesgo ON",       "Vulnerable",
  ifelse(data_reg$condicion_aplicacion == "Salud",                   "Estratégico", 
  ifelse(data_reg$condicion_aplicacion == "Estratégico",             "Estratégico", 
  ifelse(data_reg$condicion_aplicacion == "Factores Riesgo OFF",   "No vulnerable",
  ifelse(data_reg$condicion_aplicacion == "Otros",                 "No vulnerable", 
  ifelse(data_reg$condicion_aplicacion == "Viaje",                 "No vulnerable",
    "No vulnerable"))))))))

data_reg %>% 
  group_by(cond_grupo, condicion_aplicacion) %>% 
  summarise()

print("Reporte agrupacion por condicion_aplicacion: 8 categorías -> 3 de cond_grupo")


## Haciendo uso de `GRUPO_ETARIO`

data_reg$cond_grupo <- 
  ifelse(data_reg$grupo_etario == "060-069", "Vulnerable",
  ifelse(data_reg$grupo_etario == "070-079", "Vulnerable",
  ifelse(data_reg$grupo_etario == "080-089", "Vulnerable",
  ifelse(data_reg$grupo_etario == "090-099", "Vulnerable",
  ifelse(data_reg$grupo_etario == "100-199", "Vulnerable", 
  ifelse(data_reg$grupo_etario == "S.I."   , "Vulnerable", 
  data_reg$cond_grupo))))))

#print(n = 21, data_reg %>% group_by(cond_grupo, grupo_etario) %>% summarise())

print("Reporte agrupacion por grupo_etario: 12 categorías -> 3 de cond_grupo")
