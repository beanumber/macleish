

macleish <- etl("macleish") %>%
  etl_extract() %>%
  etl_transform() %>%
  etl_load()

whately_2015 <- macleish %>%
  tbl("whately") %>%
  mutate(the_year = strftime('%Y', when)) %>%
  collect() %>%
  filter(the_year == 2015)

orchard_2015 <- macleish %>%
  tbl("orchard") %>%
  mutate(the_year = strftime('%Y', when)) %>%
  collect() %>%
  filter(the_year == 2015)

save(whately_2015, file = "data/whately_2015.rda", compress = "xz")
save(orchard_2015, file = "data/orchard_2015.rda", compress = "xz")


library(rgdal)
dsn <- path.expand("~/Dropbox/Data for Ben Baumer/")
list.files(dsn)
ogrListLayers(dsn)
ogrInfo(dsn, layer = "Buildings")

layers <- c("Key Landmarks", "VernalPool", "VegType_2009_20101112", "Streams", 
            "ChallengeCourse_Elements", "MacLeishBoundary", "Reservoir", 
            "Property Boundary", "Buildings", "Steep Slopes", "Wetlands")
macleish_layers <- lapply(layers, readOGR, dsn = dsn)

names(macleish_layers) <- c("landmarks", "vernal_pool", "forests", "streams",
                            "challenge_courses", "macleish_boundary", "reservoir", 
                            "property_boundary", "buildings", "slopes", "wetlands")

lapply(macleish_layers, proj4string)

# fix the Steep Slopes projection string
proj4string(macleish_layers[[10]]) <- proj4string(macleish_layers[[1]])

macleish_layers <- lapply(macleish_layers, spTransform, CRSobj = CRS("+init=epsg:4326"))

save(macleish_layers, file = "data/macleish_layers.rda", compress = "xz")
