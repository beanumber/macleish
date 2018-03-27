# Creates the macleish_layers list

library(rgdal)
dsn <- path.expand("data-raw/macleish/")
list.files(dsn)
ogrListLayers(dsn)
ogrInfo(dsn, layer = "trails")

# layers <- c("Key Landmarks", "VegType_2009_20101112", "Streams", 
            # "ChallengeCourse_Elements", "Reservoir", 
            # "Buildings", "Wetlands",
            # "Slope2016", "SCHOOLS_PT", "2016_MacLeish_Boundary",
            # "Research_Poly", "Rhodes_soil", "Trails_20160328")

layers <- c("landmarks", "forests", "streams",
  "challenge_courses", 
  "buildings", "wetlands",
#  "slopes", 
  "boundary", 
  "research", "soil", "trails")


library(sf)
macleish_layers <- lapply(layers, st_read, dsn = dsn)
names(macleish_layers) <- layers

# names(macleish_layers) <- c("landmarks", "forests", "streams",
#                             "challenge_courses", "reservoir", 
#                             "buildings", "wetlands",
#                             "slopes", "schools", "boundary", 
#                             "research", "soil", "trails")

# check to make sure they are all projected the same
sapply(macleish_layers, st_crs)

# fix the projection string
# proj4string(macleish_layers[[10]]) <- proj4string(macleish_layers[[1]])

# macleish_layers <- lapply(macleish_layers, spTransform, CRSobj = CRS("+init=epsg:4326"))

save(macleish_layers, file = "data/macleish_layers.rda", compress = "xz")
