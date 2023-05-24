
cd "C:\Users\lskuba\Desktop\Diplomatura Datos\Parte I - Programacion C23\clases\TP1\informe-grupo-8\datos"

// # toda la base son 115.478.293 observaciones

// base computable
// import delimited "C:\Users\lskuba\Downloads\datos-abiertos_argentina\datos_nomivac_covid19\datos_nomivac_covid19.csv", rowrange(1:2000) colrange(1:2) clear


* importar solo id_persona_dw
import delimited "datos_nomivac_covid19.csv", rowrange(1:) colrange(1:1) clear
// ds, has(type string) 
// local strvars "`r(varlist)'"
// display `"`strvars'"' 
// order *, alpha
// order `strvars' 

// egen id_persona = group(id_persona_dw)
,
* variables de toda la base
local variables_base "sexo grupo_etario jurisdiccion_residencia jurisdiccion_residencia_id depto_residencia depto_residencia_id jurisdiccion_aplicacion jurisdiccion_aplicacion_id depto_aplicacion depto_aplicacion_id fecha_aplicacion vacuna cod_dosis_generica nombre_dosis_generica condicion_aplicacion orden_dosis lote_vacuna id_persona_dw"

* alivianamientos o input por partes
egen id_persona = group(id_persona_dw) // para numericas
bysort id_persona: egen id_persona_rep = count(id_persona)

gsort id_persona_rep -orden

,
encode sexo, gen(sexo_e) // para strings
encode grupo_etario, gen(grupo_etario_e)


,
* save de muestra
save "sexo y grupo_etario", replace

index = 1
foreach variable in local variables_base {
	local index = posof `variable' in `variables_base'
	import delimited "C:\Users\lskuba\Downloads\datos-abiertos_argentina\datos_nomivac_covid19\datos_nomivac_covid19.csv", rowrange(1:) colrange(`index':`index') clear
	local newvar "v1[1]"
	encode v1, gen(`newvar')
		
}
