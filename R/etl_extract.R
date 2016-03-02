#' Extract weather data
#' 
#' 
#' @export


etl_extract.etl_macleish <- function (obj, ...) {
  dat <- getURL("https://scidb.smith.edu/~macleish/WhatelyMet_Met_10min.dat")
  x <- read.csv(textConnection(dat), skip = 1, stringsAsFactors = FALSE)
  metadata <- head(x, 2)
  out <- x[-(1:2), -2]
  out <- out %>%
    rename_(when = ~TIMESTAMP) %>%
    mutate_(when = ~ymd_hms(when)) %>%
    mutate_(Temp_C_Avg = ~as.numeric(Temp_C_Avg)) %>%
    mutate_(WSpd_mps = ~as.numeric(WSpd_mps)) %>%
    mutate_(Wdir_deg = ~as.numeric(Wdir_deg)) %>%
    mutate_(RH_per_Avg = ~as.numeric(RH_per_Avg)) %>%
    mutate_(Press_mb_Avg = ~as.numeric(Press_mb_Avg)) %>%
    mutate_(SlrW_Avg = ~as.numeric(SlrW_Avg)) %>%
    mutate_(Rain_mm_Tot = ~as.numeric(Rain_mm_Tot))
  return(out)
}