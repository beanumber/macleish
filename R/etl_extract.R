#' Extract weather data
#' 
#' @description Retrieve data from the Macleish Field Station weather monitors
#' @inheritParams etl::etl_extract
#' @import etl
#' @export
#' @examples 
#' 
#' macleish <- etl("macleish")
#' str(macleish)
#' 
#' \dontrun{
#' macleish %>%
#'   etl_extract() %>%
#'   etl_transform() %>%
#'   etl_load()
#' whately <- macleish %>%
#'   tbl("whately") 
#' orchard <- macleish %>%
#'   tbl("orchard") 
#'   
#' whately %>%
#'   summarize(N = n(), avg_temp = mean(temperature))
#' orchard %>%
#'   summarize(N = n(), avg_temp = mean(temperature))
#'   
#' # check data types
#' whately %>%
#'   glimpse()
#' 
#' # if using SQLite, datetimes will get converted to integers
#' whately <- whately %>%
#'   mutate(when_datetime = datetime(when, 'unixepoch'))
#' whately %>%
#'   glimpse()
#' 
#' # show the most recent data -- should be within the past hour
#' whately %>%
#'   collect() %>%
#'   tail()
#' 
#' # show that no time-shifting is happening
#' if (require(ggplot2)) {
#' macleish %>%
#'   tbl("whately") %>%
#'   collect() %>%
#'   mutate(when = lubridate::ymd_hms(when)) %>%
#'   filter(lubridate::year(when) == 2012 & month(when) == 12 & day(when) == 20) %>%
#'   ggplot(aes(x = when, y = temperature)) + geom_line()
#' }
#' }

etl_extract.etl_macleish <- function(obj, ...) {
  url <- "https://scidb.smith.edu/~macleish/"
  files <- c("WhatelyMet_Met_10min.dat", "OrchardMet_Met_10min.dat")
  src <- paste0(url, files)
  etl::smart_download(obj, src)
  invisible(obj)
}

#' @rdname etl_extract.etl_macleish
#' @import dplyr
#' @importFrom lubridate ymd_hms
#' @importFrom readr read_csv write_csv
#' @importFrom utils head
#' @export


etl_transform.etl_macleish <- function(obj, ...) {
  # Whately
  lcl <- paste0(attr(obj, "raw_dir"), "/WhatelyMet_Met_10min.dat")
  x <- readr::read_csv(lcl, skip = 1)
  metadata <- head(x, 2)
  out <- x[-(1:2), -2]
  out <- out %>%
    rename_(when = ~TIMESTAMP) %>%
    mutate_(when = ~ymd_hms(when), 
            Temp_C_Avg = ~as.numeric(Temp_C_Avg)) %>%
    rename_(temperature = ~Temp_C_Avg) %>%
    mutate_(WSpd_mps = ~as.numeric(WSpd_mps)) %>%
    rename_(wind_speed = ~WSpd_mps) %>%
    mutate_(Wdir_deg = ~as.numeric(Wdir_deg)) %>%
    rename_(wind_dir = ~Wdir_deg) %>%
    mutate_(RH_per_Avg = ~as.numeric(RH_per_Avg)) %>%
    rename_(rel_humidity = ~RH_per_Avg) %>%
    mutate_(Press_mb_Avg = ~as.numeric(Press_mb_Avg)) %>%
    rename_(pressure = ~Press_mb_Avg) %>%
    mutate_(SlrW_Avg = ~as.numeric(SlrW_Avg)) %>%
    rename_(solar_radiation = ~SlrW_Avg) %>%
    mutate_(Rain_mm_Tot = ~as.numeric(Rain_mm_Tot)) %>%
    rename_(rainfall = ~Rain_mm_Tot) %>%
    unique()
  # time-shifting correction, see:
  # https://github.com/beanumber/macleish/issues/8
  out <- out %>%
    mutate_(num = ~seq(1:nrow(out)), 
            when = ~ifelse(num <= 50682, when - lubridate::dhours(5), when), 
            when = ~as.POSIXct(when, tz = "EST", origin = "1970-01-01 00:00:00")) %>%
    select_(~-num)
  readr::write_csv(out, path = paste0(attr(obj, "load_dir"), "/whately.csv"))
  
  # Orchard
  lcl <- paste0(attr(obj, "raw_dir"), "/OrchardMet_Met_10min.dat")
  x <- readr::read_csv(lcl, skip = 1)
  metadata <- head(x, 2)
  out <- x[-(1:2), -2]
  out <- out %>%
    rename_(when = ~TIMESTAMP) %>%
    mutate_(when = ~ymd_hms(when), 
            Temp_C_Avg = ~as.numeric(Temp_C_Avg)) %>%
    rename_(temperature = ~Temp_C_Avg) %>%
    mutate_(WSpd_mps = ~as.numeric(WSpd_mps)) %>%
    rename_(wind_speed = ~WSpd_mps) %>%
    mutate_(Wdir_deg = ~as.numeric(Wdir_deg)) %>%
    rename_(wind_dir = ~Wdir_deg) %>%
    mutate_(RH_per_Avg = ~as.numeric(RH_per_Avg)) %>%
    rename_(rel_humidity = ~RH_per_Avg) %>%
    mutate_(Press_mb_Avg = ~as.numeric(Press_mb_Avg)) %>%
    rename_(pressure = ~Press_mb_Avg) %>%
    mutate_(PAR_Den_Avg = ~as.numeric(PAR_Den_Avg)) %>%
    rename_(par_density = ~PAR_Den_Avg) %>%
    mutate_(PAR_Tot_Avg = ~as.numeric(PAR_Tot_Avg)) %>%
    rename_(par_total = ~PAR_Tot_Avg) %>%
    mutate_(Rain_mm_Tot = ~as.numeric(Rain_mm_Tot)) %>%
    rename_(rainfall = ~Rain_mm_Tot) %>%
    unique()
  # time-shifting correction, see:
  # https://github.com/beanumber/macleish/issues/8
  out <- out %>%
    mutate_(num = ~seq(1:nrow(out)), 
            when = ~ifelse( num >= 18482, when + lubridate::dhours(1), when), 
            when = ~ifelse( num >= 70892, when + lubridate::dminutes(50), when), 
            when = ~as.POSIXct(when, tz = "EST", origin = "1970-01-01 00:00:00")) %>%
    select_(~-num)
  readr::write_csv(out, path = paste0(attr(obj, "load_dir"), "/orchard.csv"))
  invisible(obj)
}
