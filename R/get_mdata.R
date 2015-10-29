#' get_mdata
#' 
#' @description blah
#' 
#' @export
#' @examples 
#' 
#' macleish <- get_mdata()

get_mdata <- function () {
  x <- read.csv("https://scidb.smith.edu/~macleish/WhatelyMet_Met_10min.dat", skip = 1)
  metadata <- head(x, 2)
  out <- x[-(1:2),]
  return(out)
}