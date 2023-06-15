grafico_estandar <- function(data, x, y) {
  
  ls_genvar_estdesc$x %>% 
  ggplot(mapping = aes(x, y)) +
  geom_col()
  
  ggsave(paste0("png/grafico_estandar_","y", "-", "x", ".png"))

}
