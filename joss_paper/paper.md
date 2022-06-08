---
title: 'MacLeish: An R package for monitoring environmental conditions in Whately, Massachusetts'
date: "2022-06-08"
authors:
  - name: Benjamin S. Baumer
    orcid: 0000-0002-3279-0516
    affiliation: 1
  - name: Dominique Kelly
    orcid: 0000-0001-7186-9385
    affiliation: 1
  - name: Albert Y. Kim
    orcid: 0000-0001-7824-306X
    affiliation: 1
affiliations: 
 - name: Smith College, Northampton, Massachusetts, USA  
   index: 1
bibliography: [pkgs.bib, refs.bib]
biblio-style: apa
tags:
  - R
  - forest
  - farmland
  - weather
  - spatial analysis 
output:
  rticles::joss_article:
    keep_md: yes
    number_sections: yes
editor_options: 
  chunk_output_type: console
---



# Summary

The Ada & Archibald MacLeish Field Station is a parcel of land in Whately, MA owned and operated by Smith College. 
The `macleish` R package provides spatial, meteorological, and photographic data for monitoring environmental conditions at the site. 
Numerous faculty use the MacLeish Field Station for research purposes. 

The `macleish` package includes multiple layers of spatial data, functions to access historical and live weather readings, data from ongoing forest ecology research, and functions to access photographs taken by a PhenoCam (Phenology Camera) Network digital camera mounted on the 25-meter WhatelyMet tower.
The camera captures a photograph of the forest canopy every 30 minutes.

By making these data accessible in an R package with a simple interface, we hope the `macleish` R package will foster interdisciplinary collaboration within the Smith College community. 

# About the MacLeish Field Station 

From the [Smith College website]([Ada and Archibald MacLeish Field Station](https://www.smith.edu/about-smith/sustainable-smith/macleish)):

> The Ada and Archibald MacLeish Field Station, a uniquely liberal arts field station, is a 250-acre patchwork of forest and pasture land in nearby Whately that provides opportunities for all members of the Smith community (students, faculty, staff, and alum) to pursue artistic inquiry, environmental research, outdoor education and low-impact recreation.  Students are integral to the field station: they help steward the land, design programs for their peers and participate in making key decisions in the operation of the field station. The Bechtel Environmental classroom provides meeting and dry laboratory space for MacLeish users. 



\begin{figure}

{\centering \includegraphics[width=0.5\linewidth]{macleish_trail_map} 

}

\caption{Map of MacLeish Field Station, Whately, Massachusetts, USA.}\label{fig:macleish}
\end{figure}
Figure \ref{fig:macleish} shows a trail map illustrating the MacLeish property.
@Moise:2021 provides an interactive history of the property. 

# Statement of Need 

The MacLeish Field Station is rife with scientific inquiry, as the Smith College community explores the diverse ecosystem of plants and animals. 
While numerous research papers, including 
@guswa2012effect, 
@guswa2012canopy,
@zukswert2014forest, 
@visser2015speeding, 
@bassar2016changes, 
@Wetzel:2017,
@ignace2018decline, 
@jackson2018potential
make use of the MacLeish property, the data supporting these research efforts is not centralized or easily accessible to the public.
The `macleish` package offers easy, public access to:

1. spatial data on building, landmarks, streams, trails, and other features of the MacLeish Field Station property 
1. real-time and historical meteorological measurements
1. carefully collected data on tree diameters of different species infected by the Hemlock Woolly adelgid 
1. photographic images of the tree canopy over time 
  
These data are already used in data science textbooks [@baumer2021mdsr] and new research efforts in progress. 

# Features

To use the CRAN version of the `macleish` package, first run `install.packages(macleish)` to install the package, then load it:


```r
library(macleish)
```

## Spatial data

Spatial data from the MacLeish Field Station are available through the `macleish_layers` data object, which leverages the `sf` package [@R-sf]. 
The following layers are available: 


```r
names(macleish_layers)
##  [1] "landmarks"         "forests"           "streams"          
##  [4] "challenge_courses" "buildings"         "wetlands"         
##  [7] "boundary"          "research"          "soil"             
## [10] "trails"            "camp_sites"        "elevation"
```

Any `sf` objects can be placed on an interactive map created by the `leaflet` package [@R-leaflet].
Figure \ref{fig:leafletmap} situates the MacLeish property in Whately, to the east of the Northampton Reservoir and to the west of the Mt. Esther Wildlife Management Area, pinpoints the OrchardMet and WhatelyMet weather stations, and depicts other geographical features such as streams and trails. 
Figure \ref{fig:leafletmap} displays a static image of the resulting interactive map. 


```r
library(leaflet)
map <- leaflet() |>
  addTiles() |>
  addPolygons(
    data = macleish_layers[["boundary"]],
    weight = 1, fillOpacity = 0.1
  ) |>
  addPolygons(
    data = macleish_layers[["buildings"]],
    weight = 1, popup = ~name
  ) |>
  addPolylines(
    data = macleish_layers[["trails"]],
    weight = 1, color = "brown",
    popup = ~name
  ) |>
  addPolylines(
    data = macleish_layers[["streams"]],
    weight = 2
  ) |>
  addMarkers(
    data = filter(macleish_layers[["landmarks"]], grepl("Met", Label)),
    popup = ~Label
  ) |>
  setView(-72.67918, 42.44921, zoom = 14)
```


```r
map
```


\begin{figure}

{\centering \includegraphics[width=0.5\linewidth]{leaflet} 

}

\caption{Screenshot from an interactive `leaflet` map of the MacLeish Field Station.}\label{fig:leafletmap}
\end{figure}

## Research data

Two tree plot datasets are available: `tree_diameter1` and `tree_diameter2`. 
The time frame differs between `tree_diameter1` (2010--2015) and `tree_diameter2` (2009--2016), and `tree_diameter2` lacks data on position of individual trees. 
The datasets present change in tree diameter over a set of years for two plots dominated by the parasites Hemlock Woolly Adelgid.
Tables \ref{tab:tree-diameter-1} and \ref{tab:tree-diameter-2} show samples from these datasets. 


```r
tree_diameter1
```
\begin{table}[!h]

\caption{\label{tab:tree-diameter-1}Sample of the first six rows of the first tree diameter dataset. \label{tab:tree1}}
\centering
\begin{tabular}[t]{rlllrrl}
\toprule
tag & species & position & semester & year & diameter & notes\\
\midrule
2001 & Sweet Birch & subcanopy & Fall & 2015 & NA & Alive in 2009, dead in 2010\\
2001 & Sweet Birch & subcanopy & Fall & 2014 & NA & Alive in 2009, dead in 2010\\
2001 & Sweet Birch & subcanopy & Fall & 2013 & NA & Alive in 2009, dead in 2010\\
2001 & Sweet Birch & subcanopy & Fall & 2012 & NA & Alive in 2009, dead in 2010\\
2001 & Sweet Birch & subcanopy & Fall & 2011 & NA & Alive in 2009, dead in 2010\\
2001 & Sweet Birch & subcanopy & Fall & 2010 & NA & Alive in 2009, dead in 2010\\
\bottomrule
\end{tabular}
\end{table}


```r
tree_diameter2
```
\begin{table}[!h]

\caption{\label{tab:tree-diameter-2}Sample of the first six rows of the second tree diameter dataset. \label{tab:tree2}}
\centering
\begin{tabular}[t]{rllrrl}
\toprule
tag & species & semester & year & diameter & notes\\
\midrule
2171 & Eastern Hemlock & Fall & 2016 & 28.2 & NA\\
2171 & Eastern Hemlock & Fall & 2012 & 27.4 & NA\\
2171 & Eastern Hemlock & Fall & 2011 & 27.2 & NA\\
2171 & Eastern Hemlock & Fall & 2010 & 27.1 & NA\\
2171 & Eastern Hemlock & Fall & 2009 & 27.0 & NA\\
2172 & Sweet Birch & Fall & 2016 & 24.5 & NA\\
\bottomrule
\end{tabular}
\end{table}

For example, using the `tree_diameter1` dataset, the boxplot in Figure \ref{fig:tree-diam} demonstrates the distribution of diameter for different species of trees at different positions from 2010--2015.

\begin{figure}

{\centering \includegraphics[width=1\linewidth]{paper_files/figure-latex/tree-diam-1} 

}

\caption{Boxplot of tree diameter depending on species and position between 2010--2015.}\label{fig:tree-diam}
\end{figure}

By viewing an individual species, the distribution of diameter varies based on the position of the species. For instance, the median diameter of emergent Eastern Hemlock trees is the greatest, despite having the smallest overall range. However, the overall range of the diameter of the canopy is the greatest. 


## Weather data

Weather data from 2015 is available through the `whately_2015` and `orchard_2015` data objects. 
These data were recorded every 10 minutes every day from 2015-01-01 to 2015-31-12, and include measurements like temperature, wind speed, and relative humidity.


```r
head(whately_2015)
## # A tibble: 6 x 8
##   when                temperature wind_speed wind_dir rel_humidity
##   <dttm>                    <dbl>      <dbl>    <dbl>        <dbl>
## 1 2015-01-01 00:00:00       -9.32       1.40     225.         54.6
## 2 2015-01-01 00:10:00       -9.46       1.51     248.         55.4
## 3 2015-01-01 00:20:00       -9.44       1.62     258.         56.2
## 4 2015-01-01 00:30:00       -9.3        1.14     244.         56.4
## 5 2015-01-01 00:40:00       -9.32       1.22     238.         56.9
## 6 2015-01-01 00:50:00       -9.34       1.09     242.         57.2
## # ... with 3 more variables: pressure <int>, solar_radiation <dbl>,
## #   rainfall <dbl>
```

Furthermore, live and historical (to present from 2012-01-03 for WhatelyMet and from 2014-06-27 for OrchardMet) weather data from both MacLeish Field Station weather monitors is available for download through functionality provided by the `etl` package [@R-etl; @baumer2019grammar].

## Photographic data

The PhenoCam Network is an ecosystem phenology camera network that provides automated, near-surface remote sensing of canopy phenology across the northeastern United States and Canada. 
One such high-resolution digital camera sits atop the WhatelyMet tower, takes pictures of the canopy every 30 minutes, and then uploads them to the PhenoCam server. 
The PhenoCam Network permits analysis of archived images, providing an objective means by which canopy phenology can be monitored and quantified at relatively low cost and with minimal expenses.

Figure \ref{fig:phenocam} displays two examples of images retrieved from the PhenoCam Network by the `phenocam_image_url()` function, which leverages functionality provided by the `phenocamr` package [@R-phenocamr].




\begin{figure}

{\centering \includegraphics[width=0.49\linewidth]{macleish_xmas} \includegraphics[width=0.49\linewidth]{macleish_latest} 

}

\caption{Images of the MacLeish Field Station retrieved from the PhenoCam Network by the \texttt{phenocam\_image\_url()} function. The image on the left was taken in June 2022, while the image on the right was taken in December 2021. }\label{fig:phenocam}
\end{figure}

# Acknowledgements

We acknowledge contributions from Jesse Bellemare, Paul Wetzel, Reid Bertone-Johnson, and Jon Caris. 


# References
