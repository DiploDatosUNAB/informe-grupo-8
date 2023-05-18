# DOWNLOAD - OPTIONS TIMEOUT

#Base desagregada
#https://datos.gob.ar/dataset/salud-vacunas-contra-covid-19-dosis-aplicadas-republica-argentina---registro-desagregado
#https://sisa.msal.gov.ar/datos/descargas/covid-19/files/datos_nomivac_covid19.zip

options(timeout = max(3000, getOption("timeout")))

download.file(url = "http://datos.salud.gob.ar/dataset/22445914-15aa-4169-acbf-5dafff74b592/resource/47d25d2c-57fd-4fc3-b09b-64b12d96563f/download/2022-10-31-vacunas-precios.xlsx",
              
              destfile = "datos/vacunas-precios.xlsx")

download.file(url = "https://sisa.msal.gov.ar/datos/descargas/covid-19/files/datos_nomivac_covid19.zip",
              
              destfile = "datos/datos_nomivac_covid19.zip")

options(timeout = min(120, getOption("timeout")))
