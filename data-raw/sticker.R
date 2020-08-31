library(hexSticker)
library(magick)

library(macleish)
library(ggplot2)
library(sf)

p <- ggplot(macleish_layers[["boundary"]]) +
  geom_sf(fill = "#94946C") +
  geom_sf(data = macleish_layers[["streams"]], color = "dodgerblue") + 
  geom_sf(data = macleish_layers[["trails"]], color = "#5F6B65") + 
  theme_void() + 
  ylim(c(42.44, 42.46))

macleish_sticker <- p %>%
  sticker(
    package = "macleish", p_color = "#19233A", h_color = "#19233A", h_fill = "#DEA748",
    p_y = 1.53,
    filename = here::here("data-raw", "hex_macleish.png"),
    p_size = 24, s_x = 1, s_y = .75, s_width = 1.3, s_height = 1.3, h_size = 2,
    white_around_sticker = TRUE,
    url = "github.com/beanumber/macleish", u_size = 4
  ) + 
  geom_pkgname(package = "ma", color = "dodgerblue", y = 1.53, size = 24, x = 0.59)

save_sticker(here::here("data-raw", "hex_macleish.png"), macleish_sticker)



