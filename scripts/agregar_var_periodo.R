
# variable periodo para hipótesis 1.
 
data_reg$periodo <- ifelse(data_reg$fecha_aplicacion <= as.Date("2021-12-31"), "primero",
 ifelse(data_reg$fecha_aplicacion >= as.Date("2022-01-01") & data_reg$fecha_aplicacion <= as.Date("2022-06-30"), "segundo",
 ifelse(data_reg$fecha_aplicacion >= as.Date("2022-07-01"), "tercero", "Inf")))

