# Hipotesis

:::{.alert .alert-info}
Finalmente, esta sección contiene al menos 3 hipótesis o preguntas que puedan ser respondidas a partir de los datos. Éstas tienen que ser más o menos interesantes y no cosas que se hayan respondido con la exploración anterior.

Traten de que sean hipótesis o preguntas que relacionen 2 o más variables. Por ejemplo, “¿Cuál es el mes con más turistas en una región?” no es una pregunta intersante, pero “Existe una relación entre la cantidad de visitas y la cantidad de hoteles en una región” es una hipótesis más jugosa que apunta a la relación entre varias variables y a un fenómeno subyacente que puede tener implicancia y aplicaciones.
:::

Debido a la disponibilidad gradual de dosis de vacunas al comienzo de la pandemia resulta necesario establecer una priorización y ordenamiento de la poblacion objetivo a inmunizar en las primeras rondas con la finalidad de salvaguardar aquellos mas susceptibles, vulnerables y expuestos. Para maximizar el cuidado de la gente se cree que mayores de edad, personas con comorbilidades y personal estrategico fueron los priorizados del sistema.

1. Por esta razón se indagará en las etapas tempranas de vacunacion la incidencia de la poblacion objetivo sobre el total y comparar esos valores con los registrados al finalizar la emergencia mundial cuando la vacuna alcanzo la suficiencia en disponibilidad irrestricta. (Se indagará sobre las etapas tempranas de vacunacion si las mismas fueron dirigidas a quien se esperaría como poblacion diana bajo la premisa anterior y en qué proporciones.)

1. Como segundo criterio ordenador de la estrategia de vacunacion se priorizo las personas que habitan grandes ciudades por la poca distancia que se mantiene y en condiciones de alta densidad demografica. Se puede analizar por departamentos provinciales.

1. Se cree que la poblacion diana obtuvo su segunda dosis en menor tiempo que las otras poblaciones. Ademas se intentara exhibir la frecuencia y distancia temporal que se observa entre una dosis y otra (descanso entre dosis que tiene en promedio cada poblacion objetivo mediante la fecha de aplicacion de cada registro para cada persona).

1. Las personas que habitualmente residen grandes ciudades durante el ASPO podría haberse mudado a la periferia por las caracteristicas coyunturales de menor tasa de contagio u trabajo remoto y han sido vacunadas en departamentos que no corresponden a su residencia habitual. Se analiza los focos de aplicaciones para 3 intervalos temporales, inicial - nudo - final, para entreveer si existe movilizacion de habitantes entre las provinvias muy marcado por la ASPO.

1. La distribucion geografica de vacunas se concentró sobre todo en poblaciones con alta densidad demografica y se retardo en alcanzar esas proporciones en las provincias del interior por disponer de mayor espacio para mantener la distancia social.

1. Los mas jovenes registraron menor adherencia a los esquemas de vacunacion que los adultos para todo el periodo en que la disponibilidad es de vacunacion libre sin requisito de etapas. 


## Otras exploraciones posibles
:::{.alert .alert-info}
1. vac_inicia "vacunados con esquema iniciado"
1. vac_completa "vacunados con esquema completo"
1. vac_adiciona "vacunados con dosis adicional"
1. vac_refuerzo "vacunados con un refuerzo"
1. vac_refuerzo2 "vacunados con dos refuerzos"
1. vac_refuerzo3 "vacunados con tres refuerzos"
1. group_by(sexo)
1. group_by(grupo_etario)
1. group_by(condicion_salud)
1. group_by(vacuna)
1. group_by(sexo, grupo_etario)
1. group_by(sexo, grupo_etario, condicion_salud)
1. ver la cantidad de dosis promedio por grupo etario
1. group_by(jurisdiccion_aplicacion/residencia)
1. group_by(fecha_aplicacion)
1. confrontar jurisdiccion_residencia con jurisdiccion_apliacion y sumar los casos [nx3]. eje x residencia eje y aplicacion y ver si existe algun punto muy diferente. Puntos de mayor y menor tamaño (jitter).

Buscar tambien informacion de poblacion por provincia, grupo_etario, sexo para 2023 y asi ver la tasa de cobertura de inmunizacion de personas con 1 o 2 o 3 o mas aplicaciones.
:::
