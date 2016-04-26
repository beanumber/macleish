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
#'   summarize(N = n(), avg_temp = mean(Temp_C_Avg))
#' orchard %>%
#'   summarize(N = n(), avg_temp = mean(Temp_C_Avg))
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
#' }

etl_extract.etl_macleish <- function(obj, ...) {
  url <- "https://scidb.smith.edu/~macleish/"
  files <- c("WhatelyMet_Met_10min.dat", "OrchardMet_Met_10min.dat")
  src <- paste0(url, files)
  lcl <- paste0(attr(obj, "raw_dir"), "/", files)
  mapply(download.file, src, lcl)
  invisible(obj)
}

#' @rdname etl_extract.etl_macleish
#' @import dplyr
#' @importFrom lubridate ymd_hms
#' @export


etl_transform.etl_macleish <- function(obj, ...) {
  # Whately
  lcl <- paste0(attr(obj, "raw_dir"), "/WhatelyMet_Met_10min.dat")
  x <- read.csv(lcl, skip = 1, stringsAsFactors = FALSE)
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
    mutate_(Rain_mm_Tot = ~as.numeric(Rain_mm_Tot)) %>%
    unique()
  write.csv(out, file = paste0(attr(obj, "load_dir"), "/whately.csv"), row.names = FALSE)
  # Orchard
  lcl <- paste0(attr(obj, "raw_dir"), "/OrchardMet_Met_10min.dat")
  x <- read.csv(lcl, skip = 1, stringsAsFactors = FALSE)
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
    mutate_(PAR_Den_Avg = ~as.numeric(PAR_Den_Avg)) %>%
    mutate_(PAR_Tot_Avg = ~as.numeric(PAR_Tot_Avg)) %>%
    mutate_(Rain_mm_Tot = ~as.numeric(Rain_mm_Tot)) %>%
    unique()
  write.csv(out, file = paste0(attr(obj, "load_dir"), "/orchard.csv"), row.names = FALSE)
  invisible(obj)
}

#' @rdname etl_extract.etl_macleish
#' @importFrom DBI dbWriteTable
#' @importFrom readr read_csv cols col_double
#' @export

etl_load.etl_macleish <- function(obj, ...) {
  # Whately
  data <- readr::read_csv(paste0(attr(obj, "load_dir"), "/whately.csv"), 
                          col_types = readr::cols(Rain_mm_Tot = readr::col_double()))
  # write the table to the DB
  message("Writing whately data to the database...")
  if (DBI::dbWriteTable(obj$con, "whately", as.data.frame(data), 
                        overwrite = TRUE, row.names = FALSE, ...)) {
    message("Data was successfully written to database.")
    message(DBI::dbListTables(obj$con))
  }
  # Orchard
  data <- readr::read_csv(paste0(attr(obj, "load_dir"), "/orchard.csv"), 
                   col_types = readr::cols(Rain_mm_Tot = readr::col_double()))
  # write the table to the DB
  message("Writing orchard data to the database...")
  if (DBI::dbWriteTable(obj$con, "orchard", as.data.frame(data), 
                        overwrite = TRUE, row.names = FALSE, ...)) {
    message("Data was successfully written to database.")
    message(DBI::dbListTables(obj$con))
  }
  invisible(obj)
}