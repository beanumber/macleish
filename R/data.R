#' Weather data from Macleish Field Stations
#'
#' @description Weather data collected at the Macleish Field Station in Whately, 
#' MA during 2015.
#'
#' @details The Macleish Field Station is a remote outpost owned by Smith
#' College and used for field research. There are two weather stations on the 
#' premises. One is called \code{Whately} and the other is \code{Orchard}.
#' 
#' Solar radiation is measured in two different ways: see \code{SlrW_Avg}
#' or the \code{PAR} variables for Photosynthetic Active Radiation.
#' 
#' @docType data
#' @format A data frame with 52,566 rows and 9 variables.
#' 
#' The following variables are values that are found in both Whately and Orchard data tables.
#' 
#' All variables are averaged over the 10 minute inverval unless otherwise noted.
#' \describe{
#'   \item{when}{timestamp for each measurment set.}
#'   \item{record}{Starting from the first measurements recorded from the year, goes up by 1 every 10 minutes.}
#'   \item{WSpd_mps}{Wind speed, in  meters per second}
#'   \item{Wdir_deg}{Wind direction, in degrees}
#'   \item{Temp_C_Avg}{average temperature, in Celsius}
#'   \item{Press_mb_Avg}{Atmospheric pressure, in millibars}
#'   \item{RH_per_Avg}{How much water there is in the air, in millimeters}
#'   \item{Rain_mm_Tot}{Total rainfall, in millimeters}
#'   \item{SlrW_Avg}{Amount of radiation coming from the sun, in Watts/meters^2. Solar measurement for Whatley}
#'   \item{PAR_Den_Avg}{Measures solar radiation. One of two solar measurements for Orchard}
#'   \item{PAR_Tot_Avg}{Measures total solar radiation. One of two solar measurements for Orchard}
#'   
#' }
#' @source These data are recorded at \url{http://www.smith.edu/ceeds/macleish_monitoring.php} 
"whately_2015"

#' @rdname whately_2015
"orchard_2015"

#' MacLeish spatial data
#' 
#' @description Shapefiles from the MacLeish Field Station. The field station
#' itself is located at \code{lat = 42.449167}, \code{lon = -72.679389}. These
#' data contains information about various man-made and natural structures
#' surrounding the field station. 
#' 
#' @details Each of the \code{\link[sp]{Spatial}} objects are projected in 
#' \code{epsg:4326} for easy integration with \code{\link[ggmap]{ggmap}} or
#' \code{\link[leaflet]{leaflet}} objects. 
#' 
#' @docType data
#' @format A \code{list} of \code{\link[sp]{Spatial}} objects, each providing a different layer.
#' 
#' \describe{
#'  \item{landmarks}{Landmarks}
#'  \item{forests}{Type of dominant tree in individual forests, as 
#'  noted by Jesse Bellemare}
#'  \item{streams}{local streams}
#'  \item{challenge_courses}{Challenge courses on the property}
#'  \item{reservoir}{a reservoir}
#'  \item{buildings}{Buildings at MacLeish}
#'  \item{wetlands}{Wetland areas}
#'  \item{trails}{Hiking trails}
#'  \item{slopes}{steep slopes}
#'  \item{schools}{Schools in Massachusetts}
#'  \item{boundary}{the property boundary}
#'  \item{research}{research plots}
#'  \item{soil}{soil deposits used by Amy Rhodes}
#' }
#' 
#' @examples 
#' names(macleish_layers)
#' summary(macleish_layers[["buildings"]])
#' 
#' if (require(sp)) {
#'  plot(macleish_layers[["buildings"]])
#' }
#' 
"macleish_layers"