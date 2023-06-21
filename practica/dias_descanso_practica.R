# si la base no tuviera errores sobre la cantidad de dosis aplicadas en orden_dosis, se aplicaba para dias de descanso:


# Previa:
ls_descansos = list()
dosis_descansos = 1:7
df_dosis_wide <- data_per["id_persona"]

# Base recortada:
df_dosis <- data_reg %>% 
  select(id_persona, orden_dosis, fecha_aplicacion, vacuna) %>% 
  arrange(orden_dosis, fecha_aplicacion, vacuna, id_persona)

# Paso: tablas para cada dosis por "id_persona"
for (esta_dosis in dosis_descansos) {
  ls_descansos[[paste("df_dosis_",esta_dosis, sep = "")]] <- df_dosis %>%
    filter(orden_dosis == esta_dosis) %>% 
    select(id_persona, fecha_aplicacion) %>% 
    rename(fecha = fecha_aplicacion) %>% 
    rename_with(~paste0("fecha_", esta_dosis), matches("^fecha$")) # jodido
}

# Paso: unir todo en una tabla wide
for (esta_dosis in dosis_descansos) {
  df_dosis_wide <- df_dosis_wide %>% 
    full_join(ls_descansos[[esta_dosis]])
}

ls_descansos[["df_dosis"]] <- df_dosis
rm(df_dosis)

