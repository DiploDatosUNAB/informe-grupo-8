grafico_estandar <- function(data, x, y, label = x) {
  
  ls_genvar_estdesc$x %>% 
  ggplot(mapping = aes(x, y)) +
  geom_col()
  
  ggsave(paste0("png/label","y", ".png"))

}
