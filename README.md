# Bienvenido a la guía de facilidades de comprensión de los datos registrados y disponibles en el NOMIVAC de DATOS ABIERTOS DE LA REPUBLICA ARGENTINA.

# Introducción

:::{.alert .alert-info}
Intro breve
:::

## ¿Qué datos son?

- Los datos contienen información de las aplicaciones de vacunas contra el COVID19.

- A nivel individual, cada fila corresponde a una nueva aplicacion de vacuna.

- Cada nuevo registro acompaña datos que caracterizan el quién (persona), cuándo (fecha), dónde (se aplica) y qué (vacuna).

- El registro se mantiene actualizado diariamente. Nos sirve para evaluar el operativo de vacunación y adherencia de la población a los esquemas y plataformas.

Para enternder un poco mas sobre los esquemas de vacunación y refuerzos para las diferentes poblaciones objetivo, visitar la pagina sobre la [vacunación contra el COVID19.](https://www.argentina.gob.ar/coronavirus/vacuna)

Existe un dataset adicional en relacion a éste que registra los precios en dólares pagados por cada dosis por parte del Ministerio de Salud de la Nación. Esta tabla esta un poco desactualizada pero sirve a los efectos de cotizar los bienes distribuidos por precio de adquisición. [**Link**](http://datos.salud.gob.ar/dataset/precio-unitario-de-vacunas-covid-19-adquiridas-por-el-ministerio-de-salud-de-la-nacion)

## ¿De dónde provienen estos datos? ¿Quién los tomó?

Los datos son descargados del [sitio de datos abiertos de la nación argentina](https://datos.gob.ar/dataset/salud-vacunas-contra-covid-19-dosis-aplicadas-republica-argentina---registro-desagregado){.alert-link}

Esta base de datos es propiedad del **Ministerio de Salud de la Nación, Dirección de Control de Enfermedades Inmunoprevenibles (DiCEI)** quien mantiene actualizado y online el dataset.

Por otro lado, el registro está a cargo del **Programa Nacional de Control de Enfermedades Inmunoprevenibles (ProNaCEI)**, creado por [Resolución Ministerial 776/2010](https://bancos.salud.gob.ar/sites/default/files/2018-10/0000000494cnt-2013-10_resolucion-ministerial-259.pdf), cuyo propósito es disminuir la mortalidad a causa de dichas enfermedades, mediante la vacunación sostenida de los niños y adultos según vacuna y población objeto definida.

## ¿En qué período se tomaron?

Los datos corresponden al período que comprende la creación del registro NOMIVAC del COVID19 hasta la actualidad. En particular el registro más antiguo data del **`r fecha_0`** y el último registro del **`r fecha_T`**.

Sin perjuicio de ello, el registro se creó el *23/03/2021* dando apertura a su publicación libre en **datos abiertos*"** a partir de esa fecha. [NOMIVAC - Registro Federal de Vacunación Nominalizado](https://sisa.msal.gov.ar/sisadoc/docs/050203/nomivac_home.jsp)

Según la [pagina web](https://datos.gob.ar/dataset/salud-vacunas-contra-covid-19-dosis-aplicadas-republica-argentina---registro-desagregado/archivo/salud_e4515c25-e1fd-4f02-b1c1-5453c36eada6) en donde se encuentra disponible la base de datos, la frecuencia de actualizacion es a diario.

## Estos datos

Para cada observación / aplicación de vacuna, disponemos de las siguientes variables:

  - **id_persona_dw:** Personas aunque desnominalizadas con asignación de un código único por persona. **Sujeto quien**.
  - **sexo y grupo_etario:** Categóricas como **dicotomicas** del sexo y **rangos** por grupo etario. **Caracterizaciónes.**
  - **condicion_aplicacion:** Describe la población objetivo mediante un score de prioridad **ordinal** segun edad y factores de riesgo.
  - **fecha_aplicacion:** Información temporal del **cuando** se aplica. **yyyy-mm-dd.**
  - **jurisdiccion_residencia:** Información de departamento y jurisdicción **donde** reside. **Georref.**
  - **jurisdiccion_aplicacion:** Información de departamente y jurisdicción **donde** se aplica. **Georref.**
  - **vacuna:** lleva el nombre de la marca de la vacuna **que** recibe.
  - **lote_vacuna:** identifica el lote de vacunas.
  - **orden_dosis:** es la **cantidad** de dosis recibidas por esa persona.
  - **nombre_dosis_generica:** es una clasificacion **estado de avance** con el esquema de su plataforma.
  - ... adicionalmente a estos datos existen otras variables númericas que acompañan a las últimas manteniendo correspondencia entre **Códigos Ids** y **valores-definición.**

Al importar la base una pequeña descripción de la misma declara que mis variables son: chr(14), dbl(3) y una date(1).

## Uso de datos adecuado

**Tener en cuenta:** La base registra cada aplicacion por lo tanto repite en diferentes filas a las mismas personas. En caso de no ajustar la fecha del registro para cada persona se corre el riesgo de contabilizar mas de una vez a cada sujeto considerando posteriormente para calculos de media, etc. registros pasados de la misma persona (lo cual generaria resultados equivocados)

Si importamos la base completa resulta mas evidente este registro multiple, quedaría en evidencia que existen varias obervaciones por persona, una fila por cada aplicación. Ya que importamos solo un recorte de los datos para trabajas preliminares para no colapsar la memoria del ordenador no queda tan claro de principio pero es sencillo con toda la base (aprox.115millones) no cuadra ni de cerca con la cantidad de habitantes (aprox.45millones).

**Como utilizar la base de forma correcta:** para cada id_persona deberia analizarse en estas descriptivas solamente el último registro alcanzado y aclarar bien definidamente que se considera un intervalo temporal de los registros totales que comienza en t(0) y termina en t(T). Es decir, es necesario filtrar filas para que solo me queden los datos de la última "foto" del estado de situación hasta el momento t(T) de cada persona. "no se como operar eso... por ahora".

... ahora ya lo aprendí. Primero debo agrupar por personas luego filtrar conservando la ultima fecha disponible del registro (T) para cada persona, así obtengo el estado de situacion para esa persona en t(T). También puedo filtrar hasta determinado momento del tiempo (i) y luego aplicar el agrupamiento por persona y volver a filtrar por último registro para obtener el estado de situación para esa persona en t(i).

## Links de descarga de datos

En la carpeta scripts se encuentan 2 archivos de nombre "descarga-datos.R" y "unip-datos.R". Correr estos archivos en éste orden para obtener los datos necesarios para utilizar el programa principal. El primero descarga los datos en "/datos" y luego es segundo descomprime el archivo descargado tambien en "/datos".

## Desarrollo del código

El codigo principal se encuentra en "/main" con el nombre "Informe.Rmd".
Adicionalmente es llamado por este, uno de nombre "scripts/normalizacion-variables-valores.R" que realiza una homogeneizacion de valores de variables que se detalla abajo

**id_persona_dw:** -> rename a `id_persona`.

**sexo (agrupacion):** `sexo` tiene dom{"F","M","S.I.","X"} donde X y S.I. (se asume sin especificar) resultan indistintos para análisis por ende restringimos el dominio => dom{"F","M","S.I."}. -> Se agrupo `sexo` = "X" con `sexo` = "S.I.".

**grupo_etario (normalización):** Se hallaron diferentes formas de ingresar datos sobre las edades y resulta conveniente tenerlos mejor organizados bajo un esquema alfabetico del tipo 0-9/A-Z. A continuación se modifican datos de grupo_etario. -> Se han normalizado los strings para mejor ordenamiento alfabetico del `grupo_etario`.

**condicion_aplicacion (edición):** Se consideran incorrectos algunos valores del dominio de la variable `condicion_aplicacion` ya que repite informacion reservada para informarse a traves de la variable de `grupo_etario`. Esta situación también genera una desagregación importante en subgrupos de personas **con y sín factores de riesgo**, desagrupados por edad. Se remueve la información de `grupo_etario` contenida dentro de la variable `condicion_aplicacion` para que se agrupen un poco más en función del concepto. -> Se han editado las categorías para simplificar su análisis.

## FINAL
