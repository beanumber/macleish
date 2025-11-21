# Retrieve images from Phenocam

Phenocam contains over 70,000 images taken from MacLeish. Photos have
been taken every 30 minutes since February 2017.

## Usage

``` r
phenocam_image_url(when = NULL, ...)

phenocam_read_day_urls(x = Sys.Date())

phenocam_read_monthly_midday_urls(x = Sys.Date())

phenocam_image_url_midday(x = Sys.Date())

phenocam_info()

phenocam_download(...)
```

## Arguments

- when:

  a string to be converted into a date-time

- ...:

  arguments passed to
  [`download_phenocam`](https://rdrr.io/pkg/phenocamr/man/download_phenocam.html)

- x:

  a Date

## References

<https://phenocam.nau.edu/webcam/sites/macleish/>

## See also

[`download_phenocam`](https://rdrr.io/pkg/phenocamr/man/download_phenocam.html)

## Examples

``` r
phenocam_image_url()
#> [1] "https://phenocam.nau.edu/data/latest/macleish.jpg"
phenocam_image_url("2021-12-25 12:05:05")
#> [1] "https://phenocam.nau.edu/data/archive/macleish/2021/12/macleish_2021_12_25_120505.jpg"
if (FALSE) { # \dontrun{
phenocam_read_day_urls()
} # }
if (FALSE) { # \dontrun{
phenocam_read_monthly_midday_urls()
} # }
if (FALSE) { # \dontrun{
phenocam_image_url_midday(Sys.Date() - 3)
phenocam_image_url_midday(Sys.Date() - 365)
} # }
if (FALSE) { # \dontrun{
phenocam_info()
} # }
if (FALSE) { # \dontrun{
phenocam_download()
df <- read_phenocam(file.path(tempdir(),"macleish_DB_1000_3day.csv"))
print(str(df))
} # }
```
