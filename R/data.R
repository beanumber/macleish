#' Weather data from Macleish Field Stations
#'
#' @description Weather data collected at the Macleish Field Station in Whately, 
#' MA during 2015.
#'
#' @details The Macleish Field Station is a remote outpost owned by Smith
#' College and used for field research. There are two weather stations on the 
#' premises. One is called `WhatelyMet` and the other is `OrchardMet`.
#' 
#' The `WhatelyMet` station is located at (42.448470, -72.680553) and
#' the `OrchardMet` station is at (42.449653, -72.680315).
#' 
#' `WhatelyMet` is located at the end of Poplar Hill Road in Whately, 
#' Massachusetts, USA. The meteorological instruments of `WhatelyMet` (except the 
#' rain gauge) are mounted at the top of a tower 25.3 m tall, well above the 
#' surrounding forest canopy. The tower is located on a local ridge at an 
#' elevation 250.75m above sea level.
#' 
#' `OrchardMet` is located about 250 m north of the first tower in an open 
#' field next to an apple orchard. Full canopy trees (~20 m tall) are within 
#' 30 m of this station. This station has a standard instrument configuration 
#' with temperature, relative humidity, solar radiation, and barometric 
#' pressure measured between 1.5 and 2.0 m above the ground. Wind speed and 
#' direction are measured on a 10 m tall tower and precipitation is measured 
#' on the ground. Ground temperature is measured at 15 and 30 cm below the 
#' ground surface 2 m south of the tower. The tower is located 258.1 m above 
#' sea level. Data collection at OrchardMet began on June 27th, 2014. 
#' 
#' The variables shown above are weather data collected at `WhatelyMet` and 
#' `OrchardMet` during 2015. Solar radiation is measured in two different ways: 
#' see `SlrW_Avg`or the `PAR` variables for Photosynthetic Active Radiation.
#' 
#' Note that a loose wire resulted in erroneous temperature reading at OrchardMet
#' in late November, 2015. 
#' 
#' @docType data
#' @format For both, a data frame ([dplyr::tbl_df()]) with roughly 52,560 rows and 8 or 9 variables.
#' 
#' The following variables are values that are found in either the `whately_2015`
#' or `orchard_2015` data tables.
#' 
#' All variables are averaged over the 10 minute interval unless otherwise noted.
#' \describe{
#'   \item{when}{Timestamp for each measurement set in Eastern Standard Time.}
#'   \item{temperature}{average temperature, in Celsius}
#'   \item{wind_speed}{Wind speed, in meters per second}
#'   \item{wind_dir}{Wind direction, in degrees}
#'   \item{rel_humidity}{How much water there is in the air, in millimeters}
#'   \item{pressure}{Atmospheric pressure, in millibars}
#'   \item{rainfall}{Total rainfall, in millimeters}
#'   \item{solar_radiation}{Amount of radiation coming from the sun, in Watts/meters^2. Solar measurement for Whately}
#'   \item{par_density}{Photosynthetically Active Radiation (sunlight between 400 and 700 nm), in average density of Watts/meters^2. One of two solar measurements for Orchard}
#'   \item{par_total}{Photosynthetically Active Radiation (sunlight between 400 and 700 nm), in average total over measurement period of Watts/meters^2. One of two solar measurements for Orchard}
#' }
#' @source These data are recorded at <https://www.smith.edu/discover-smith/smith-action/sustainable-smith/center-environment-ecological-design-sustainability> 
"whately_2015"

#' @rdname whately_2015
#' @examples 
#' 
#' \dontrun{
#' #' # loose wire anomalies
#' if (require(dplyr) & require(ggplot2) & require(lubridate)) {
#'  orchard_2015 |>
#'  filter(month(when) == 11) |>
#'    ggplot(aes(x = when, y = temperature)) +
#'    geom_line() + geom_smooth()
#' }
#' }
"orchard_2015"

#' MacLeish spatial data
#' 
#' @description Shapefiles from the MacLeish Field Station. The field station
#' itself is located at `lat = 42.449167`, `lon = -72.679389`. These
#' data contain information about various man-made and natural structures
#' surrounding the field station. 
#' 
#' @details Each of the [sf::sf()] objects are projected in 
#' `epsg:4326` for easy integration with Google Maps or
#' [leaflet::leaflet()] objects. 
#' 
#' @docType data
#' @format A `list` of [sf::sf()] objects, each providing a different layer.
#' 
#' \describe{
#'  \item{landmarks}{Landmarks}
#'  \item{forests}{Type of dominant tree in individual forests, as 
#'  noted by Jesse Bellemare}
#'  \item{streams}{local streams}
#'  \item{challenge_courses}{Challenge courses on the property}
#'  \item{buildings}{Buildings at MacLeish}
#'  \item{wetlands}{Wetland areas}
#'  \item{boundary}{the property boundary}
#'  \item{research}{research plots}
#'  \item{soil}{soil deposits used by Amy Rhodes}
#'  \item{trails}{Hiking trails}
#'  \item{camp_sites}{Two camp sites}
#'  \item{elevation}{30 foot elevation contours}
#' }
#' 
#' @examples 
#' names(macleish_layers)
#' macleish_layers[["buildings"]]
#' 
#' if (require(sf)) {
#'  plot(macleish_layers[["buildings"]])
#' }
"macleish_layers"

#' Maple sap collection at MacLeish
#' @docType data
#' @format 
#' \describe{
#'  \item{when}{the date of collection}
#'  \item{sap}{how much sap was collected, in gallons}
#'  \item{Comments}{comments}
#'  \item{People}{who was there?}
#' }
"maple_sap"

#' MacLeish Data Plot 1
#' @description Data on change in tree diameter (in centimeters)
#' for parasitic Hemlock Woolly Adelgid dominated areas on the Western side of MacLeish. 
#' Tree diameter was measured at 1.4 meters high above the ground.
#' @docType data
#' @seealso [tree_diameter2]
#' @format 
#' \describe{
#'  \item{Module}{Module number that represents one of the 10 subplot modules that are 110 m
#'  and 20 x 50 m. There are five 10 x 10 modules along central 50 m axis.}
#'  \item{Tag}{Tag numbers used to identify each tree.} 
#'  \item{Species}{Tree species include Red Maple (Acer rubrum), Sweet Birch (Betula lenta), Paper Birch (Betula papyrifera), American Beech (Fagus grandifolia), 
#'  American witch-hazel (Hamamelis virginiana), Eastern White Pine (Pinus strobus), Northern Red Oak (Quercus rubra), and Eastern Hemlock (Tsuga canadensis).}
#'  \item{Position}{Stage of growth for each individual tree. The emergent position are the tallest trees, followed by canopy, subcanopy, 
#'  and finally, sapling trees, which are the smallest trees.}
#'  \item{Year}{Data collected from 2010-2015 in the fall semesters.}
#'  \item{Notes}{Notes collected on the wellbeing of tree species, including notes on death or poor health.}
#'  \item{Diameter}{Tree diameter measured in centimeters and at 1.4 meters high above the ground.}
#'  \item{People}{Data obtained from Jesse Bellemare and Smith College students from BIO364-365 courses.}
#' }
"tree_diameter1"

#' MacLeish Data Plot 2
#' @description Data on change in tree diameter (in centimeters) 
#' for parasitic Hemlock Woolly Adelgid dominated areas on the Western side of MacLeish. 
#' Tree diameter was measured at 1.4 meters high above the ground.
#' @docType data
#' @seealso [tree_diameter1]
#' @format 
#' \describe{
#'  \item{Module}{Module number that represents one of the 10 subplot modules that are 110 m
#'  and 20 x 50 m. There are five 10 x 10 modules along central 50 m axis.}
#'  \item{Tag}{Tag numbers used to identify each tree.}
#'  \item{Species}{Tree species include Red Maple (Acer rubrum), Sweet Birch (Betula lenta), American Beech (Fagus grandifolia), Eastern White Pine (Pinus strobus), 
#'  Northern Red Oak (Quercus rubra), and Eastern Hemlock (Tsuga canadensis).}
#'  \item{Year}{Data collected from 2009-2012 in the fall semesters.}
#'  \item{Notes}{Notes collected on the wellbeing of tree species, including notes on death or poor health.}
#'  \item{Diameter}{Tree diameter measured in centimeters and at 1.4 meters high above the ground.}
#'  \item{People}{Data obtained from Jesse Bellemare and Smith College students from BIO364-365 courses.}
#' }
"tree_diameter2"
