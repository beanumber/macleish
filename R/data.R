#' Weather data from Macleish Field Stations
#'
#' @description Weather data collected at the Macleish Field Station in Whately, 
#' MA, from 2010 to present. 
#'
#' @details The Macleish Field Station is a remote outpost owned by Smith
#' College and used for field research. There are two weather stations on the 
#' premises. One is called \code{Whately} and the other is \code{Orchard}.
#'
#' @format A data frame with several hundred thousand row and 9 variables:
#' \describe{
#'   \item{when}{timestamp, recorded every 10 minutes}
#'   \item{record}{?}
#'   \item{Temp_C_Avg}{average temperature, in Celsius, over these 10 minutes}
#'   \item{WSpd_mps}{wind speed}
#' }
#' @source These data are recorded at \url{http://www.smith.edu/ceeds/macleish.php}
"whately"

#' @rdname whately
"orchard"