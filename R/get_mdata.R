#' get_mdata
#' 
#' @description Retrieve data from the Macleish Field Station weather monitors
#' 
#' @import dplyr
#' @export
#' @examples 
#' 
#' macleish <- get_mdata()
#' if (require(lattice)) {
#'  xyplot(Temp_C_Avg ~ when, data = macleish, type = c("l", "smooth"))
#' }

get_mdata <- function () {
  x <- read.csv("https://scidb.smith.edu/~macleish/WhatelyMet_Met_10min.dat", skip = 1, stringsAsFactors = FALSE)
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
    mutate_(SlrW_Avg = ~as.numeric(SlrW_Avg)) %>%
    mutate_(Rain_mm_Tot = ~as.numeric(Rain_mm_Tot))
  return(out)
}