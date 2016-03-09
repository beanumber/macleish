#' Extract weather data
#' 
#' 
#' @export
#' @examples 
#' 
#' macleish <- etl("macleish")
#' str(macleish)
#' 
#' macleish %>%
#'   etl_extract() %>%
#'   etl_transform() %>%
#'   etl_load()
#' whately <- macleish %>%
#'   tbl("whately") 
#'   
#' whately %>%
#'   summarize(N = n(), avg_temp = mean(Temp_C_Avg))

etl_extract.etl_macleish <- function(obj, ...) {
  url <- "https://scidb.smith.edu/~macleish/WhatelyMet_Met_10min.dat"
  download.file(url, paste0(attr(obj, "raw_dir"), "/WhatelyMet_Met_10min.dat"))
  invisible(obj)
}

#' @rdname etl_extract.etl_macleish
#' @importFrom lubridate ymd_hms
#' @export


etl_transform.etl_macleish <- function(obj, ...) {
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
    mutate_(Rain_mm_Tot = ~as.numeric(Rain_mm_Tot))
  write.csv(out, file = paste0(attr(obj, "load_dir"), "/whately.csv"), row.names = FALSE)
  invisible(obj)
}

#' @rdname etl_extract.etl_macleish
#' @importFrom DBI dbWriteTable
#' @export

etl_load.etl_macleish <- function(obj, ...) {
  data <- read.csv(paste0(attr(obj, "load_dir"), "/whately.csv"))
  # write the table to the DB
  message("Writing whately data to the database...")
  if (DBI::dbWriteTable(obj$con, "whately", data, overwrite = TRUE, row.names = FALSE, ...)) {
    message("Data was successfully written to database.")
    message(DBI::dbListTables(obj$con))
  }
  invisible(obj)
}