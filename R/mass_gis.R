# MassGIS
# 
#' Retrieve elevation layers from MassGIS
#' @param layer MassGIS layer name to import
#' @importFrom sf st_transform st_read
#' @importFrom utils unzip download.file
#' @details This function will download shapefiles from MassGIS, unzip them, 
#' transform the projection to EPSG:4326, compute their intersection with the
#' boundary of the MacLeish property, and return the resulting 
#' [sf::sf()] object. 
#' @source https://www.mass.gov/info-details/massgis-data-layers
#' @export
#' @examples 
#' 
#' \dontrun{
#' # have to download the shapefiles...could take a while...
#' elevation <- mass_gis()
#' macleish_elevation <- macleish_intersect(elevation)
#' if (require(sf)) {
#'   plot(macleish_elevation)
#' }
#' 
#' dcr_trails <- mass_gis("dcrtrails")
#' 
#' }

mass_gis <- function(layer = "contours250k") {
  dir <- tempdir()
  url <- paste0("http://download.massgis.digital.mass.gov/shapefiles/state/", layer, ".zip")
  lcl_zip <- file.path(dir, basename(url))
  utils::download.file(url, destfile = lcl_zip)
  lcl_shp <- file.path(dir, layer)
  utils::unzip(lcl_zip, exdir = lcl_shp)
  # list.files(dir)
  sf::st_read(lcl_shp) |>
    sf::st_transform(4326)
}

#' @param x an [sf::sf()] object
#' @export
#' @importFrom sf st_intersection
#' @rdname mass_gis
#' @details Intersect a spatial layer with the MacLeish boundary layer

macleish_intersect <- function(x) {
  sf::st_intersection(macleish::macleish_layers[["boundary"]], x)
}
