# MassGIS
# 
#' Retrieve elevation layers from MassGIS
#' @importFrom rgdal readOGR
#' @importFrom sp spTransform CRS
#' @importFrom rgeos gIntersection
#' @importFrom utils unzip
#' @details This function will download shapefiles from MassGIS, unzip them, 
#' transform the projection to EPSG:4326, compute their intersection with the
#' boundary of the MacLeish property, and return the resulting 
#' \code{\link[sp]{SpatialLines-class}} object. 
#' @export
#' @examples 
#' 
#' \dontrun{
#' # have to download the shapefiles...cound take a while...
#' elevation <- macleish_elevation()
#' if (require(sp)) {
#'   plot(elevation)
#' }
#' }

macleish_elevation <- function() {
  dir <- tempdir()
  url <- "http://wsgw.mass.gov/data/gispub/shape/state/contours250k.zip"
  lcl_zip <- file.path(dir, basename(url))
  download.file(url, destfile = lcl_zip)
  lcl_shp <- file.path(dir, "contours250k")
  utils::unzip(lcl_zip, exdir = lcl_shp)
  # list.files(dir)
  elevation <- rgdal::readOGR(lcl_shp) %>%
    sp::spTransform(sp::CRS("+init=epsg:4326"))
  mac_elevation <- rgeos::gIntersection(macleish_layers[["boundary"]], elevation)
}
