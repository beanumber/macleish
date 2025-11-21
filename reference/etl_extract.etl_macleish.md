# Extract weather data

Retrieve data from the Macleish Field Station weather monitors

## Usage

``` r
# S3 method for class 'etl_macleish'
etl_extract(obj, ...)

# S3 method for class 'etl_macleish'
etl_transform(obj, ...)

etl_transform_help(obj, ...)
```

## Arguments

- obj:

  an [etl](https://rdrr.io/pkg/etl/man/etl.html) object

- ...:

  arguments passed to methods

## Examples

``` r
macleish <- etl("macleish")
#> No database was specified so I created one for you at:
#> /tmp/RtmpJBhHCq/file1cce6712d37f.sqlite3
str(macleish)
#> List of 2
#>  $ con  :Formal class 'SQLiteConnection' [package "RSQLite"] with 8 slots
#>   .. ..@ ptr                :<externalptr> 
#>   .. ..@ dbname             : chr "/tmp/RtmpJBhHCq/file1cce6712d37f.sqlite3"
#>   .. ..@ loadable.extensions: logi TRUE
#>   .. ..@ flags              : int 70
#>   .. ..@ vfs                : chr ""
#>   .. ..@ ref                :<environment: 0x55bd6bbe7f60> 
#>   .. ..@ bigint             : chr "integer64"
#>   .. ..@ extended_types     : logi FALSE
#>  $ disco: NULL
#>  - attr(*, "class")= chr [1:6] "etl_macleish" "etl" "src_SQLiteConnection" "src_dbi" ...
#>  - attr(*, "pkg")= chr "macleish"
#>  - attr(*, "dir")= chr "/tmp/RtmpJBhHCq"
#>  - attr(*, "raw_dir")= chr "/tmp/RtmpJBhHCq/raw"
#>  - attr(*, "load_dir")= chr "/tmp/RtmpJBhHCq/load"

if (FALSE) { # \dontrun{
macleish |>
  etl_extract() |>
  etl_transform() |>
  etl_load()
whately <- macleish |>
  tbl("whately") 
orchard <- macleish |>
  tbl("orchard") 
  
whately |>
  summarize(N = n(), avg_temp = mean(temperature))
orchard |>
  summarize(N = n(), avg_temp = mean(temperature))
  
# check data types
whately |>
  glimpse()

# if using SQLite, datetimes will get converted to integers
whately <- whately |>
  mutate(when_datetime = datetime(when, 'unixepoch'))
whately |>
  glimpse()

# show the most recent data -- should be within the past hour
whately |>
  collect() |>
  tail()

# show that no time-shifting is happening
if (require(ggplot2)) {
macleish |>
  tbl("whately") |>
  collect() |>
  mutate(when = lubridate::ymd_hms(when)) |>
  filter(lubridate::year(when) == 2012 & month(when) == 12 & day(when) == 20) |>
  ggplot(aes(x = when, y = temperature)) + geom_line()
}
} # }
```
