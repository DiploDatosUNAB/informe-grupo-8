### Variable `sexo`
```{r sexo_general, include=TRUE}
# sexo
ls_genvar_estdesc$sexo %>% 
  knitr::kable(caption = "Variable sexo: Estadísticas descriptivas")
```
1. La población que mas rebició vacunas en valor absoluto es: `r ls_genvar_texto[["sexo"]]["sexo"]` con `r max(ls_genvar_estdesc[["sexo"]]["total_dosis"])` dosis aplicadas sobre este grupo.
1. La población que mas rebició vacunas en valor relatico es: `r ls_genvar_texto[["sexo"]]["sexo.1"]` con `r max(ls_genvar_estdesc[["sexo"]]["mean_dosis"])` dosis promedio aplicadas sobre este grupo.

```{r sexo_grafico_estandar, fig.show='hold', out.width = "50%"}

ls_genvar_estdesc$sexo %>% 
  ggplot(mapping = aes(sexo, total_dosis)) +
  geom_col() +
  labs(title = "Cantidad de dosis totales destinadas a cada agrupamiento")

ggsave(paste0("png/grafico_estandar_","sexo", "_","total_dosis", ".png"))

ls_genvar_estdesc$sexo %>% 
  ggplot(mapping = aes(sexo, mean_dosis)) +
  geom_col() +
  labs(title = "Cantidad de dosis totales destinadas a cada agrupamiento")

ggsave(paste0("png/grafico_estandar_",sexo, "_","mean_dosis", ".png"))
```
