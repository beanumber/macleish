## Test environments

* local macOS install, R 4.0.2
* win-builder (release, devel, oldrelease)
* GitHub Actions
    + ubuntu-16.04: latest
    + windows: latest
    + macOS: latest, devel
* Rhub: 
    + Debian Linux, R-devel, clang, ISO-8859-15 locale
    + Debian Linux, R-devel, GCC
    + Debian Linux, R-patched, GCC
    + Debian Linux, R-release, GCC
    + Fedora Linux, R-devel, clang, gfortran
    + Fedora Linux, R-devel, GCC
    + macOS 10.13.6 High Sierra, R-release, CRAN's setup
    + Windows Server 2008 R2 SP1, R-devel, 32/64 bit
    + Windows Server 2008 R2 SP1, R-oldrel, 32/64 bit
    + Windows Server 2008 R2 SP1, R-release, 32/64 bit


## R CMD check results


## CRAN Package Check Results for Package macleish

Existing problems at https://cran.rstudio.com//web/checks/check_results_macleish.html:

* r-release-macos-arm64 WARNING: None of the release macos test environments yield this warning
* r-devel-windows-x86_64-gcc10-UCRT ERROR: None of the r-devel windows test environments yield this error


## Reverse dependencies

Reverse dependencies checked usinged revdepcheck::revdep_check()

