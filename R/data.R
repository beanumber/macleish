#' Weather data from Macleish Field Stations
#'
#' @description Weather data collected at the Macleish Field Station in Whately, 
#' MA during 2015.
#'
#' @details The Macleish Field Station is a remote outpost owned by Smith
#' College and used for field research. There are two weather stations on the 
#' premises. One is called \code{WhatelyMet} and the other is \code{OrchardMet}.
#' 
#' The \code{WhatelyMet} station is located at (42.448470, -72.680553) and
#' the \code{OrchardMet} station is at (42.449653, -72.680315).
#' 
#' \code{WhatelyMet} is located at the end of Poplar Hill Road in Whately, 
#' Massachusetts, USA. The meteorological instruments of \code{WhatelyMet} (except the 
#' rain gauge) are mounted at the top of a tower 25.3 m tall, well above the 
#' surrounding forest canopy. The tower is located on a local ridge at an 
#' elevation 250.75m above sea level.
#' 
#' \code{OrchardMet} is located about 250 m north of the first tower in an open 
#' field next to an apple orchard. Full canopy trees (~20 m tall) are within 
#' 30 m of this station. This station has a standard instrument configuration 
#' with temperature, relative humidity, solar radiation, and barometric 
#' pressure measured between 1.5 and 2.0 m above the ground. Wind speed and 
#' direction are measured on a 10 m tall tower and precipitation is measured 
#' on the ground. Ground temperature is measured at 15 and 30 cm below the 
#' ground surface 2 m south of the tower. The tower is located 258.1 m above 
#' sea level. Data collection at OrchardMet began on June 27th, 2014. 
#' 
#' The variables shown above are weather data collected at \code{WhatelyMet} and 
#' \code{OrchardMet} during 2015. Solar radiation is measured in two different ways: 
#' see \code{SlrW_Avg}or the \code{PAR} variables for Photosynthetic Active Radiation.
#' 
#' Note that a loose wire resulted in erroneous temperature reading at OrchardMet
#' in late November, 2015. 
#' 
#' @docType data
#' @format For both, a data frame (\code{\link[dplyr]{tbl_df}}) with roughly 52,560 rows and 8 or 9 variables.
#' 
#' The following variables are values that are found in either the \code{whately_2015}
#' or \code{orchard_2015} data tables.
#' 
#' All variables are averaged over the 10 minute inverval unless otherwise noted.
#' \describe{
#'   \item{when}{Timestamp for each measurment set.}
#'   \item{Temp_C_Avg}{average temperature, in Celsius}
#'   \item{WSpd_mps}{Wind speed, in meters per second}
#'   \item{Wdir_deg}{Wind direction, in degrees}
#'   \item{RH_per_Avg}{How much water there is in the air, in millimeters}
#'   \item{Press_mb_Avg}{Atmospheric pressure, in millibars}
#'   \item{Rain_mm_Tot}{Total rainfall, in millimeters}
#'   \item{SlrW_Avg}{Amount of radiation coming from the sun, in Watts/meters^2. Solar measurement for Whatley}
#'   \item{PAR_Den_Avg}{Photosynthetically Active Radiation (sunlight between 400 and 700 nm), in average density of Watts/meters^2. One of two solar measurements for Orchard}
#'   \item{PAR_Tot_Avg}{Photosynthetically Active Radiation (sunlight between 400 and 700 nm), in average total over measurement period of Watts/meters^2. One of two solar measurements for Orchard}
#' }
#' @source These data are recorded at \url{http://www.smith.edu/ceeds/macleish_monitoring.php} 
"whately_2015"

#' @rdname whately_2015
#' @examples 
#' 
#' # loose wire anomalies
#' if (require(ggplot2)) {
#'  orchard_2015 %>%
#'  filter(month(when) == 11) %>%
#'    ggplot(aes(x = when, y = Temp_C_Avg)) +
#'    geom_line() + geom_smooth()
#' }
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