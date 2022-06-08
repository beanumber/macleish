library(sf)
library(ggplot2)
library(usethis)

# Creates the macleish_layers list
dsn <- path.expand("data-raw/macleish/")
sf::st_layers(dsn)

layers <- c("landmarks", "forests", "streams",
  "challenge_courses", 
  "buildings", "wetlands",
#   "slopes", 
  "boundary", 
  "research", "soil", "trails")

macleish_layers <- lapply(layers, st_read, dsn = dsn)
names(macleish_layers) <- layers


# Add more layers
macleish_layers[["camp_sites"]] <- tibble::tribble(
  ~name, ~lat, ~lon, 
  "Group Campsite", 42.450976, -72.678154, 
  "Remote Campsite", 42.458549, -72.679581
) %>%
  st_as_sf(coords = c("lon", "lat")) %>%
  st_set_crs(4326)

# rename forests field
macleish_layers[["forests"]] <- macleish_layers %>%
  purrr::pluck("forests") %>%
  dplyr::rename(type = Sheet1__Na)

# add 30-foot contours
macleish_layers[["elevation"]] <- macleish::mass_gis() %>%
  macleish::macleish_intersect() %>%
  st_transform(4326)

# set units
macleish_layers[["challenge_courses"]] <- macleish_layers |>
  purrr::pluck("challenge_courses") %>%
  mutate(ele = units::set_units(ele, "m"))
macleish_layers[["wetlands"]] <- macleish_layers |>
  purrr::pluck("wetlands") %>%
  mutate(
    area_acres = units::set_units(AREAACRES, "acre"),
    area_sqmi = units::set_units(AREAACRES, "mi^2")
  ) |>
  select(-contains("AREA", ignore.case = FALSE))
macleish_layers[["boundary"]] <- macleish_layers |>
  purrr::pluck("boundary") %>%
  mutate(
    area = st_area(geometry),
    area = units::set_units(area, "acre"),
  ) |>
  select(area)
macleish_layers[["research"]] <- macleish_layers |>
  purrr::pluck("research") %>%
  mutate(
    area = st_area(geometry),
    area = units::set_units(area, "m^2"),
  ) |>
  select(-contains("Shape", ignore.case = FALSE))

# Set coordinate reference system for entire list
macleish_layers <- lapply(macleish_layers, st_transform, crs = 4326)

# https://stackoverflow.com/questions/61286108/error-in-cpl-transformx-crs-aoi-pipeline-reverse-ogrcreatecoordinatetrans
for(i in 1:length(macleish_layers)){
  st_crs(macleish_layers[[i]]) <- 4326
}


# check to make sure they are all projected the same
lapply(macleish_layers, st_crs)

# Test all layers
names(macleish_layers)
ggplot() +
  geom_sf(data = macleish_layers[["landmarks"]]) +
  geom_sf(data = macleish_layers[["forests"]]) +
  geom_sf(data = macleish_layers[["streams"]]) +
  geom_sf(data = macleish_layers[["challenge_courses"]]) +
  geom_sf(data = macleish_layers[["buildings"]]) +
  geom_sf(data = macleish_layers[["wetlands"]]) +
  geom_sf(data = macleish_layers[["boundary"]]) +
  geom_sf(data = macleish_layers[["research"]]) +
  geom_sf(data = macleish_layers[["soil"]]) +
  geom_sf(data = macleish_layers[["trails"]]) +
  geom_sf(data = macleish_layers[["camp_sites"]]) +
  geom_sf(data = macleish_layers[["elevation"]])


# Save for package
usethis::use_data(macleish_layers, overwrite = TRUE, compress = "xz")

