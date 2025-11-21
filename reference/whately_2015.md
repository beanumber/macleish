# Weather data from Macleish Field Stations

Weather data collected at the Macleish Field Station in Whately, MA
during 2015.

## Usage

``` r
whately_2015

orchard_2015
```

## Format

For both, a data frame
([`dplyr::tbl_df()`](https://dplyr.tidyverse.org/reference/tbl_df.html))
with roughly 52,560 rows and 8 or 9 variables.

The following variables are values that are found in either the
`whately_2015` or `orchard_2015` data tables.

All variables are averaged over the 10 minute interval unless otherwise
noted.

- when:

  Timestamp for each measurement set in Eastern Standard Time.

- temperature:

  average temperature, in Celsius

- wind_speed:

  Wind speed, in meters per second

- wind_dir:

  Wind direction, in degrees

- rel_humidity:

  How much water there is in the air, in millimeters

- pressure:

  Atmospheric pressure, in millibars

- rainfall:

  Total rainfall, in millimeters

- solar_radiation:

  Amount of radiation coming from the sun, in Watts/meters^2. Solar
  measurement for Whately

- par_density:

  Photosynthetically Active Radiation (sunlight between 400 and 700 nm),
  in average density of Watts/meters^2. One of two solar measurements
  for Orchard

- par_total:

  Photosynthetically Active Radiation (sunlight between 400 and 700 nm),
  in average total over measurement period of Watts/meters^2. One of two
  solar measurements for Orchard

An object of class `tbl_df` (inherits from `tbl`, `data.frame`) with
52547 rows and 9 columns.

## Source

These data are recorded at
<https://www.smith.edu/about-smith/sustainable-smith/ceeds>

## Details

The Macleish Field Station is a remote outpost owned by Smith College
and used for field research. There are two weather stations on the
premises. One is called `WhatelyMet` and the other is `OrchardMet`.

The `WhatelyMet` station is located at (42.448470, -72.680553) and the
`OrchardMet` station is at (42.449653, -72.680315).

`WhatelyMet` is located at the end of Poplar Hill Road in Whately,
Massachusetts, USA. The meteorological instruments of `WhatelyMet`
(except the rain gauge) are mounted at the top of a tower 25.3 m tall,
well above the surrounding forest canopy. The tower is located on a
local ridge at an elevation 250.75m above sea level.

`OrchardMet` is located about 250 m north of the first tower in an open
field next to an apple orchard. Full canopy trees (~20 m tall) are
within 30 m of this station. This station has a standard instrument
configuration with temperature, relative humidity, solar radiation, and
barometric pressure measured between 1.5 and 2.0 m above the ground.
Wind speed and direction are measured on a 10 m tall tower and
precipitation is measured on the ground. Ground temperature is measured
at 15 and 30 cm below the ground surface 2 m south of the tower. The
tower is located 258.1 m above sea level. Data collection at OrchardMet
began on June 27th, 2014.

The variables shown above are weather data collected at `WhatelyMet` and
`OrchardMet` during 2015. Solar radiation is measured in two different
ways: see `SlrW_Avg`or the `PAR` variables for Photosynthetic Active
Radiation.

Note that a loose wire resulted in erroneous temperature reading at
OrchardMet in late November, 2015.

## Examples

``` r
if (FALSE) { # \dontrun{
#' # loose wire anomalies
if (require(dplyr) & require(ggplot2) & require(lubridate)) {
 orchard_2015 |>
 filter(month(when) == 11) |>
   ggplot(aes(x = when, y = temperature)) +
   geom_line() + geom_smooth()
}
} # }
```
