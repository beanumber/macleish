# Creates the macleish_layers list
dsn <- path.expand("data-raw/macleish/")

sf::st_layers(dsn)

layers <- c("landmarks", "forests", "streams",
  "challenge_courses", 
  "buildings", "wetlands",
#   "slopes", 
  "boundary", 
  "research", "soil", "trails")


library(sf)
macleish_layers <- lapply(layers, st_read, dsn = dsn)
names(macleish_layers) <- layers

# check to make sure they are all projected the same
lapply(macleish_layers, st_crs)

camp_sites <- tibble::tribble(
  ~name, ~lat, ~lon, 
  "Group Campsite", 42.450976, -72.678154, 
  "Remote Campsite", 42.458549, -72.679581
) %>%
  st_as_sf(coords = c("lon", "lat")) %>%
  st_set_crs(4326)

macleish_layers[["camp_sites"]] <- camp_sites

# rename forests field
macleish_layers[["forests"]] <- macleish_layers %>%
  purrr::pluck("forests") %>%
  dplyr::rename(type = Sheet1__Na)

# add 30 foot contours
macleish_layers[["elevation"]] <- mass_gis() %>%
  macleish_intersect() %>%
  st_transform(4326)

# fix the projection string
# proj4string(macleish_layers[[10]]) <- proj4string(macleish_layers[[1]])

# macleish_layers <- lapply(macleish_layers, spTransform, CRSobj = CRS("+init=epsg:4326"))

save(macleish_layers, file = "data/macleish_layers.rda", compress = "xz")
