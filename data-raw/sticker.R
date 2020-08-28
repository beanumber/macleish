library(hexSticker)
library(magick)

library(macleish)
library(ggplot2)
library(sf)

p <- ggplot(macleish_layers[["boundary"]]) +
  geom_sf(fill = "#94946C") +
  theme_void()

p %>%
  sticker(
    package = "macleish", p_color = "#5F6B65", h_color = "#5F6B65", h_fill = "#FFFFFF",
    p_y = 1.53,
    filename = here::here("data-raw", "hex_macleish.png"),
    p_size = 24, s_x = 1, s_y = .75, s_width = 1.3, s_height = 1.3
  )


