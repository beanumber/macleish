## Test environments

* local OS X install, R 3.6.0
* local Ubuntu 18.04, R 3.6.3
* Ubuntu 16.04.5 (on travis-ci), oldrel, release, devel
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 notes

* checking CRAN incoming feasibility ... NOTE

Possibly mis-spelled words in DESCRIPTION:
  Whately (15:16, 17:41)

Whately is not mis-spelled.

* rhub checks fails due to old versions of external GDAL
  libraries, but the package passes on Travis. 
  
## Reverse dependencies

There are no reverse dependencies.

