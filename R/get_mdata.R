#' get_whately
#' 
#' @description Retrieve data from the Macleish Field Station weather monitors
#' 
#' @import dplyr
#' @importFrom RCurl getURL
#' @export
#' @examples 
#' 
#' whately <- get_whately()
#' if (require(lattice)) {
#'  xyplot(Temp_C_Avg ~ when, data = whately, type = c("l", "smooth"))
#' }

get_whately <- function () {
  dat <- getURL("https://scidb.smith.edu/~macleish/WhatelyMet_Met_10min.dat")
  x <- read.csv(textConnection(dat), skip = 1, stringsAsFactors = FALSE)
  metadata <- head(x, 2)
  out <- x[-(1:2),]
  out <- out %>%
    rename_(record = ~RECORD) %>%
    rename_(when = ~TIMESTAMP) %>%
    mutate_(when = ~strptime(when, "%y-%m-%d %H:%M:%S")) %>%
    mutate_(record = ~as.numeric(record)) %>%
    mutate_(Temp_C_Avg = ~as.numeric(Temp_C_Avg)) %>%
    mutate_(WSpd_mps = ~as.numeric(WSpd_mps)) %>%
    mutate_(Wdir_deg = ~as.numeric(Wdir_deg)) %>%
    mutate_(RH_per_Avg = ~as.numeric(RH_per_Avg)) %>%
    mutate_(Press_mb_Avg = ~as.numeric(Press_mb_Avg)) %>%
    mutate_(SlrW_Avg = ~as.numeric(SlrW_Avg)) %>%
    mutate_(Rain_mm_Tot = ~as.numeric(Rain_mm_Tot))
  return(out)
}

#' get_orchard
#' 
#' @description Retrieve data from the Macleish Field Station weather monitors
#' 
#' @import dplyr
#' @importFrom RCurl getURL
#' @export
#' @examples 
#' 
#' orchard <- get_orchard()
#' if (require(lattice)) {
#'  xyplot(Temp_C_Avg ~ when, data = orchard, type = c("l", "smooth"))
#' }

get_orchard <- function () {
  dat <- getURL("https://scidb.smith.edu/~macleish/OrchardMet_Met_10min.dat")
  x <- read.csv(textConnection(dat), skip = 1, stringsAsFactors = FALSE)
  metadata <- head(x, 2)
  out <- x[-(1:2),]
  out <- out %>%
    rename_(record = ~RECORD) %>%
    rename_(when = ~TIMESTAMP) %>%
    mutate_(when = ~as.Date(when)) %>%
    mutate_(record = ~as.numeric(record)) %>%
    mutate_(Temp_C_Avg = ~as.numeric(Temp_C_Avg)) %>%
    mutate_(WSpd_mps = ~as.numeric(WSpd_mps)) %>%
    mutate_(Wdir_deg = ~as.numeric(Wdir_deg)) %>%
    mutate_(RH_per_Avg = ~as.numeric(RH_per_Avg)) %>%
    mutate_(Press_mb_Avg = ~as.numeric(Press_mb_Avg)) %>%
    mutate_(PAR_Den_Avg = ~as.numeric(PAR_Den_Avg)) %>%
    mutate_(PAR_Tot_Avg = ~as.numeric(PAR_Tot_Avg)) %>%
    mutate_(Rain_mm_Tot = ~as.numeric(Rain_mm_Tot))
  return(out)
}