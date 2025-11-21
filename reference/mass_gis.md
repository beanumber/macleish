# Retrieve elevation layers from MassGIS

Retrieve elevation layers from MassGIS

## Usage

``` r
mass_gis(layer = "contours250k")

macleish_intersect(x)
```

## Source

https://www.mass.gov/info-details/massgis-data-layers

## Arguments

- layer:

  MassGIS layer name to import

- x:

  an [`sf::sf()`](https://r-spatial.github.io/sf/reference/sf.html)
  object

## Details

This function will download shapefiles from MassGIS, unzip them,
transform the projection to EPSG:4326, compute their intersection with
the boundary of the MacLeish property, and return the resulting
[`sf::sf()`](https://r-spatial.github.io/sf/reference/sf.html) object.

Intersect a spatial layer with the MacLeish boundary layer

## Examples

``` r
if (FALSE) { # \dontrun{
# have to download the shapefiles...could take a while...
elevation <- mass_gis()
macleish_elevation <- macleish_intersect(elevation)
if (require(sf)) {
  plot(macleish_elevation)
}

dcr_trails <- mass_gis("dcrtrails")

} # }
```
