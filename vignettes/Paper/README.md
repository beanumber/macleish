# Saving a PDF of Paper.Rmd

For some reason to have the `Paper.pdf` actually save to this folder you need to Knit it by running

```
library(here)
rmarkdown::render(input = here("vignettes/Paper/Paper.Rmd"), output_file = here("vignettes/Paper/Paper"))
```