# rhub
library(tidyverse)
devtools::check_rhub(
  email = "ben.baumer@gmail.com", 
  interactive = FALSE,
  platforms = rhub::platforms() %>%
    filter(!is.na(`cran-name`)) %>%
    pull(name),
  env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = "always")
)
