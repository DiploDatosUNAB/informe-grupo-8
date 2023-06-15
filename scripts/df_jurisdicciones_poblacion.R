# Variables espaciales análisis


# {rjurisdicciones_cruce}
## tabla cruce de migraciones residencia ~ lugar de aplicación. A modo exploratorio.

#jurisdicciones_cruce <- table(data_reg$jurisdiccion_residencia, data_reg$jurisdiccion_aplicacion)
#jurisdicciones_cruce_id <- table(data_reg$jurisdiccion_residencia_id, data_reg$jurisdiccion_aplicacion_id)
#jurisdicciones_cruce_id
#rm(jurisdicciones_cruce, jurisdicciones_cruce_id)

# {r jurisdicciones_poblacion}

## Armar una tabla con la caracterización de la población del registro respecto 
## a la cantidad de personas según al lugar de residencia y lugar de la ultima aplicación.

### Primero una tabla con la cantidad de residentes de cada jurisdicción:
pob_resid <- data_reg %>% 
  group_by(jurisdiccion_residencia) %>% 
  summarise(n = n()) 

### Segundo una tabla con la cantidad de aplicaciones de cada jurisdiccion:
pob_aplic <- data_reg %>% 
  group_by(jurisdiccion_aplicacion) %>% 
  summarise(n = n()) 

### Tercero la union de ambas tablas con join_by ya que usan nombres 
### diferentes de identificación y sufijo porque ambos usan el mismo estadístico n.
jurisdicciones_poblacion <- 
  full_join(pob_resid, pob_aplic, 
  join_by(jurisdiccion_residencia == jurisdiccion_aplicacion), 
  suffix = c("_residencia", "_aplicacion")) 

### Cuarto aplico la diferencia entre residentes y vacunados.
jurisdicciones_poblacion <- 
  jurisdicciones_poblacion %>% 
  mutate(vac_extra = n_aplicacion - n_residencia) %>% 
  arrange(jurisdiccion_residencia) %>% 
  rename(jurisdiccion = jurisdiccion_residencia)

### Quinto, elimino df temporales
rm(pob_resid, pob_aplic)

# {r jurisdicciones_poblacion_detail}
## La tabla anterior aporta escasa información entonces vamos por el detalle extra:

### primero, cantidad de personas *residentes* de cada jurisdicción que se aplican en *la misma* jurisdicción.
jresidentes <- data_reg %>% 
  filter(jurisdiccion_residencia == jurisdiccion_aplicacion) %>% 
  group_by(jurisdiccion_residencia) %>% 
  summarise(res_fix = n()) %>% 
  arrange(jurisdiccion_residencia) %>% 
  rename(jurisdiccion = jurisdiccion_residencia)

### segundo, cantidad de personas *aplicadas* en cada jurisdicción que residen en otra jurisdicción.
jnoresidentes <- data_reg %>% 
  filter(jurisdiccion_residencia != jurisdiccion_aplicacion) %>% 
  group_by(jurisdiccion_aplicacion) %>% 
  summarise(nores_fix = n()) %>% 
  arrange(jurisdiccion_aplicacion) %>% 
  rename(jurisdiccion = jurisdiccion_aplicacion)

### tercero, cantidad de personas *residentes* de cada jurisdiccion que se aplican en *otra* jurisdiccion.
jno_residentes <- data_reg %>% 
  filter(jurisdiccion_residencia != jurisdiccion_aplicacion) %>% 
  group_by(jurisdiccion_residencia) %>% 
  summarise(res_nofix = n()) %>% 
  arrange(jurisdiccion_residencia) %>% 
  rename(jurisdiccion = jurisdiccion_residencia)


# {r jurisdicciones_poblacion_join_extent}

## vacunados por jurisdiccion:
### jresidentes ## aplicados en la jurisdicción de residencia, FIX = vacunados
### jnoresidentes ## aplicados en esta jurisdicción que no es la de su residencia, FIX = vacunados
### jno_residentes ## aplicados en otra jurisdicción que no es la de residencia, noFIX = no vacunados

## extiendo el df para toda la información asociada a estas variables
jurisdicciones_poblacion <- jurisdicciones_poblacion %>% 
  full_join(jresidentes, by = "jurisdiccion") %>% 
  full_join(jnoresidentes, by = "jurisdiccion") %>% 
  full_join(jno_residentes, by = "jurisdiccion")

## libero espacio
rm(jresidentes, jnoresidentes, jno_residentes)

## Reemplazo los NA por ceros
jurisdicciones_poblacion <- jurisdicciones_poblacion %>%
  replace_na(list(res_fix = 0, nores_fix = 0, res_nofix = 0))

# reordeno, mejor lectura
col_order <- c("jurisdiccion", "n_residencia", "res_fix", "res_nofix", "n_aplicacion", "nores_fix", "vac_extra") 
k_jurisdicciones_poblacion <- jurisdicciones_poblacion %>% 
  select(all_of(col_order)) %>% 
  knitr::kable(col.names = c("Jurisdiccion", "Residentes", "Residentes vacunados in situ", "Residentes vacunados out situ", "Poblacion vacunada in situ", "No residentes vacunados in situ", "Saldo de vacunados neto"))
# alternativa de reorden
#jurisdicciones_poblacion <- jurisdicciones_poblacion[, col_order]

print(paste("Producto de df_jurisdicciones_poblacion: k_jurisdicciones_poblacion"))

rm(col_order, jurisdicciones_poblacion)
