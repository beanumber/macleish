#' Weather data from Macleish Field Station
#'
#' @description data from Macleish from 2010 to present. 
#'
#' @details the description
#'
#' @format A data frame with several hundred thousand row and 9 variables:
#' \describe{
#'   \item{These are values that are found in both Whately and Orchard data tables.}
#'   \item{All variables are averaged unless otherwise noted.}
#'   \item{when}{timestamp for each measurment set.}
#'   \item{record}{Starting from the first measurements recorded from the year, goes up by 1 every 10 minutes.}
#'   \item{WSpd_mps}{Wind speed, in  meters per second}
#'   \item{Wdir_deg}{Wind direction, in degrees}
#'   \item{Temp_C_Avg}{average temperature, in Celsius}
#'   \item{Press_mb_Avg}{Atmospheric pressure, in millibars}
#'   \item{RH_per_Avg}{How much water there is in the air, in millimeters}
#'   \item{Rain_mm_Tot}{Total rainfall, in millimeters}
#'   \item{Solar radiation is measured in two different ways}
#'   \item{SlrW_Avg}{Amount of radiation coming from the sun, in Watts/meters^2. Solar measurement for Whatley}
#'   \item{PAR stands for Photosynthetic Active Radiation}
#'   \item{"PAR_Den_Avg"}{Measures solar radiation. One of two solar measurements for Orchard}
#'   \item{"PAR_Tot_Avg"}{Measures total solar radiation. One of two solar measurements for Orchard}
#'   
#' }
#' @source These data are recorded at \url{http://www.smith.edu/ceeds/macleish.php} 
"whately"
"orchard"