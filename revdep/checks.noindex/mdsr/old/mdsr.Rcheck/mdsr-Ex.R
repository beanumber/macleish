pkgname <- "mdsr"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('mdsr')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("CIACountries")
### * CIACountries

flush(stderr()); flush(stdout())

### Name: CIACountries
### Title: Several variables on countries from the CIA Factbook, 2014.
### Aliases: CIACountries
### Keywords: datasets

### ** Examples

str(CIACountries)




cleanEx()
nameEx("Cherry")
### * Cherry

flush(stderr()); flush(stdout())

### Name: Cherry
### Title: Cherry Blossom runs
### Aliases: Cherry
### Keywords: datasets

### ** Examples

if (require(dplyr)) {
  Cherry %>%
    group_by(name.yob) %>%
    count() %>%
    group_by(n) %>%
    count(name = "appearances")
}



cleanEx()
nameEx("CholeraDeaths")
### * CholeraDeaths

flush(stderr()); flush(stdout())

### Name: CholeraDeaths
### Title: Deaths and Pumps from 1854 London cholera outbreak
### Aliases: CholeraDeaths CholeraPumps
### Keywords: datasets

### ** Examples

if (require(sf)) {
  plot(st_geometry(CholeraDeaths))
}



cleanEx()
nameEx("DataSciencePapers")
### * DataSciencePapers

flush(stderr()); flush(stdout())

### Name: DataSciencePapers
### Title: Data Science Papers from arXiv.org
### Aliases: DataSciencePapers
### Keywords: datasets

### ** Examples


data(DataSciencePapers)
str(DataSciencePapers)




cleanEx()
nameEx("Emails_train")
### * Emails_train

flush(stderr()); flush(stdout())

### Name: Emails_train
### Title: Email Train
### Aliases: Emails_train Emails_test
### Keywords: datasets

### ** Examples

nrow(Emails_train)
nrow(Emails_test)



cleanEx()
nameEx("Headlines_train")
### * Headlines_train

flush(stderr()); flush(stdout())

### Name: Headlines_train
### Title: Headlines_train
### Aliases: Headlines_train Headlines_test
### Keywords: datasets

### ** Examples

nrow(Headlines_train)
nrow(Headlines_test)



cleanEx()
nameEx("MedicareCharges")
### * MedicareCharges

flush(stderr()); flush(stdout())

### Name: MedicareCharges
### Title: Charges to and Payments from Medicare
### Aliases: MedicareCharges
### Keywords: datasets

### ** Examples


data(MedicareCharges)




cleanEx()
nameEx("MedicareProviders")
### * MedicareProviders

flush(stderr()); flush(stdout())

### Name: MedicareProviders
### Title: Medicare Providers
### Aliases: MedicareProviders
### Keywords: datasets

### ** Examples


data(MedicareProviders)




cleanEx()
nameEx("Minneapolis2013")
### * Minneapolis2013

flush(stderr()); flush(stdout())

### Name: Minneapolis2013
### Title: Ballots in the 2013 Mayoral election in Minneapolis
### Aliases: Minneapolis2013
### Keywords: datasets

### ** Examples


data(Minneapolis2013)



cleanEx()
nameEx("NCI60_tiny")
### * NCI60_tiny

flush(stderr()); flush(stdout())

### Name: NCI60_tiny
### Title: Gene expression in cancer
### Aliases: NCI60_tiny Cancer
### Keywords: datasets

### ** Examples


data(NCI60_tiny) 




cleanEx()
nameEx("Violations")
### * Violations

flush(stderr()); flush(stdout())

### Name: Violations
### Title: NYC Restaurant Health Violations
### Aliases: Violations ViolationCodes Cuisines
### Keywords: datasets

### ** Examples

data(Violations)
if (require(dplyr)) {
  Violations %>%
    inner_join(Cuisines, by = "cuisine_code") %>%
    filter(cuisine_description == "American") %>%
    arrange(grade_date) %>%
    head()
 }



cleanEx()
nameEx("etl_NCI60")
### * etl_NCI60

flush(stderr()); flush(stdout())

### Name: etl_NCI60
### Title: Load the NCI60 data from GitHub
### Aliases: etl_NCI60

### ** Examples


## Not run: 
##D NCI60 <- etl_NCI60()
## End(Not run)



cleanEx()
nameEx("macros")
### * macros

flush(stderr()); flush(stdout())

### Name: macros
### Title: Replacements for LaTeX macros
### Aliases: macros func sql_func sql_word argument variable pkg mdsr_data
###   mdsr_person vocab index_entry

### ** Examples

func("mutate")
func("mutate", index = FALSE)
func("left_join")
pkg("dplyr")
mdsr_person("Ben Baumer")
mdsr_person("Ben Baumer", emph = TRUE)
mdsr_person("Richard De Veaux")
mdsr_person("Richard De Veaux", alt = "De Veaux, Richard")
vocab(x = "Big data", .f = tolower)
index_entry(x = "Barack Obama")
index_entry(x = "Barack Obama", index = FALSE)
index_entry(x = "Big data", .f = tolower)
index_entry(x = "Twilight", emph = TRUE)
index_entry(x = "Richard De Veaux", alt = "De Veaux, Richard")
index_entry(x = "left_join")



cleanEx()
nameEx("make_babynames_dist")
### * make_babynames_dist

flush(stderr()); flush(stdout())

### Name: make_babynames_dist
### Title: Wrangle babynames data
### Aliases: make_babynames_dist

### ** Examples


BabynameDist <- make_babynames_dist()
if (require(dplyr)) {
  BabynameDist %>%
    filter(name == "Benjamin")
}



cleanEx()
nameEx("mdsr_table")
### * mdsr_table

flush(stderr()); flush(stdout())

### Name: mdsr_table
### Title: Custom table output
### Aliases: mdsr_table mdsr_sql_explain_table mdsr_sql_keys_table

### ** Examples

mdsr_table(faithful)



cleanEx()
nameEx("ordway_birds")
### * ordway_birds

flush(stderr()); flush(stdout())

### Name: ordway_birds
### Title: Birds captured and released at Ordway, complete and uncleaned
### Aliases: ordway_birds
### Keywords: datasets

### ** Examples


ordway_birds




cleanEx()
nameEx("save_webshot")
### * save_webshot

flush(stderr()); flush(stdout())

### Name: save_webshot
### Title: Embedded webshot of leaflet map
### Aliases: save_webshot

### ** Examples

## Not run: 
##D if (require(leaflet)) {
##D   map <- leaflet() %>%
##D     addTiles() %>%
##D     addMarkers(lng = 174.768, lat = -36.852, popup = "The birthplace of R")
##D   save_webshot(map, tempfile())
##D }
## End(Not run)



cleanEx()
nameEx("skim")
### * skim

flush(stderr()); flush(stdout())

### Name: skim
### Title: Custom skimmer
### Aliases: skim

### ** Examples

skim(faithful)



cleanEx()
nameEx("src_scidb")
### * src_scidb

flush(stderr()); flush(stdout())

### Name: src_scidb
### Title: src_scidb
### Aliases: src_scidb dbConnect_scidb mysql_scidb

### ** Examples


db_air <- src_scidb("airlines")
db_air
db_air <- dbConnect_scidb("airlines")
db_air
if (require(DBI)) {
  dbListTables(db_air)
}

if (require(knitr)) {
  opts_chunk$set(engine.opts = mysql_scidb("airlines"))
}



cleanEx()
nameEx("theme_mdsr")
### * theme_mdsr

flush(stderr()); flush(stdout())

### Name: theme_mdsr
### Title: MDSR themes
### Aliases: theme_mdsr

### ** Examples

if (require(ggplot2)) {
  p <- ggplot(mtcars, aes(x = hp, y = mpg, color = factor(cyl))) + 
    geom_point() + facet_wrap(~ am) + geom_smooth()
  p + theme_grey()
  p + theme_mdsr()
 }



cleanEx()
nameEx("world_cities")
### * world_cities

flush(stderr()); flush(stdout())

### Name: world_cities
### Title: Cities and their populations
### Aliases: world_cities
### Keywords: datasets

### ** Examples


world_cities




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
