globalVariables("site")

#' Retrieve images from Phenocam
#' @description Phenocam contains over 70,000 images taken from MacLeish.
#' Photos have been taken every 30 minutes since February 2017.
#' @param when a string to be converted into a date-time
#' @param ... currently ignored
#' @export
#' @references \url{https://phenocam.sr.unh.edu/webcam/sites/macleish/}
#' @examples 
#' phenocam_image_url()
#' phenocam_image_url("2021-12-25 12:05:05")

phenocam_image_url <- function(when = NULL, ...) {
  if (is.null(when)) {
    url <- "https://phenocam.sr.unh.edu/data/latest/macleish.jpg"
  } else if (datetime <- as.POSIXct(when)) {
    url_stem <- "https://phenocam.sr.unh.edu/data/archive/macleish/"
    url_slug <- format(datetime, "%Y/%m/macleish_%Y_%m_%d_%H%M%S.jpg")
    url <- paste0(url_stem, url_slug)
  } else {
    stop("Could not convert argument to Datetime")
  }
  return(url)
}

#' @rdname phenocam_image_url
#' @export
#' @param x a Date
#' @examples 
#' \dontrun{
#' phenocam_read_day_urls()
#' }

phenocam_read_day_urls <- function(x = Sys.Date()) {
  the_date <- as.Date(x)
  url <- paste0(
    "https://phenocam.sr.unh.edu/webcam/browse/macleish/",
    format(the_date, "%Y/%m/%d/")
  )
  url |>
    # need authentication to make this work!!
    xml2::read_html() |>
    rvest::html_elements("td") |>
    rvest::html_elements("img") |>
    rvest::html_attr("src")
}


#' @rdname phenocam_image_url
#' @export
#' @examples 
#' \dontrun{
#' phenocam_read_month_urls()
#' }

phenocam_read_month_urls <- function(x = Sys.Date()) {
  the_date <- as.Date(x)
  url <- paste0(
    "https://phenocam.sr.unh.edu/webcam/browse/macleish/",
    format(the_date, "%Y/%m/")
  )
  url |>
    xml2::read_html() |>
    rvest::html_elements("td") |>
    rvest::html_elements("img") |>
    rvest::html_attr("src") |>
    stringr::str_subset("macleish")
}


#' MacLeish Phenocam site info
#' @rdname phenocam_image_url
#' @export
#' @examples 
#' \dontrun{
#' phenocam_info()
#' }

phenocam_info <- function() {
  phenocamr::list_sites() |>
    dplyr::filter(site == "macleish")
}

#' Download Phenocam time series data
#' @rdname phenocam_image_url
#' @param ... arguments passed to \code{\link[phenocamr]{download_phenocam}}
#' @seealso \code{\link[phenocamr]{download_phenocam}}
#' @examples 
#' \dontrun{
#' phenocam_download()
#' df <- read_phenocam(file.path(tempdir(),"macleish_DB_1000_3day.csv"))
#' print(str(df))
#' }

phenocam_download <- function(...) {
  phenocamr::download_phenocam(site = "macleish", ...)
}
