library(readxl)

#Uploading data into R
plot_data01 <- read_excel("data-raw/MacLeish Data_Plot MC-01.xlsx")
plot_data02 <- read_excel("data-raw/MacLeish Data_Plot MC-02.xlsx")

usethis::use_data(plot_data01, overwrite = TRUE)
usethis::use_data(plot_data02, overwrite = TRUE)

library(tidyverse)
library(janitor)
library(lubridate)
library(stringr)
library(usethis)
library(devtools)
library(dplyr)

#Plot Data 1
#Creating year and height column 
newplot_data01 <- plot_data01 %>%
  pivot_longer(c(`Fall'15`, `Fall'14`,`Fall'13`,`Fall'12`,`Fall'11`,`Fall'10`), names_to = "Year", values_to = "Diameter(cm)")

#Separating fall and year into new columns 
newplot_data01 <- newplot_data01 %>%
  separate(Year, c("Semester", "Year"), sep = 4)

#Changing abbreviated year into full year 
newplot_data01$Year[newplot_data01$Year == "'15"] <- "2015"
newplot_data01$Year[newplot_data01$Year == "'14"] <- "2014"
newplot_data01$Year[newplot_data01$Year == "'13"] <- "2013"
newplot_data01$Year[newplot_data01$Year == "'12"] <- "2012"
newplot_data01$Year[newplot_data01$Year == "'11"] <- "2011"
newplot_data01$Year[newplot_data01$Year == "'10"] <- "2010"

#Changing value "DEAD" to NA for diameter
#Tree diameter didn't increase or decrease over time 
newplot_data01$`Diameter(cm)`[newplot_data01$`Diameter(cm)` == "DEAD"] <- "NA"

#Shifting the "Notes:" column to the end of the dataset 
newplot_data01 <- newplot_data01 %>%
  relocate("Notes:", .after = "Diameter(cm)")

View(newplot_data01)

plot_data01 <- newplot_data01

usethis::use_data(plot_data01, overwrite = TRUE)


#Plot Data 2
library(readxl)
plot_data02 <- read_excel("data-raw/MacLeish Data_Plot MC-02.xlsx")

#Creating year and height column 
newplot_data02 <- plot_data02 %>%
  pivot_longer(c(`FALL 2016`, `Fall'12`,`Fall'11`,`Fall'10`,`Fall'09`), names_to = "Year", values_to = "Diameter(cm)")

#Separating fall and year into new columns 
newplot_data02 <- newplot_data02 %>%
  separate(Year, c("Semester", "Year"), sep = 4)

#Changing abbreviated year into full year 
newplot_data02$Year[newplot_data02$Year == "'09"] <- "2009"
newplot_data02$Year[newplot_data02$Year == "'12"] <- "2012"
newplot_data02$Year[newplot_data02$Year == "'11"] <- "2011"
newplot_data02$Year[newplot_data02$Year == "'10"] <- "2010"
newplot_data02$Semester[newplot_data02$Semester == "FALL"] <- "Fall"

#Changing value "DEAD" to "0" for height 
newplot_data02$`Diameter(cm)`[newplot_data02$`Diameter(cm)` == "DEAD"] <- "NA"

#Shifting the "Notes:" column to the end of the dataset 
newplot_data02 <- newplot_data02 %>%
  relocate("Notes:", .after = "Diameter(cm)")

View(newplot_data02)

plot_data02 <- newplot_data02

usethis::use_data(plot_data02, overwrite = TRUE)

#Run this in console for documentation functionality 
#When ran together with rest of data, causes R to run without stop? Troubleshoot?
devtools::document()

#Documentation complete:
#Use plot_data01 and ?plot_data01 to see plot data01 documentation
#Use plot_data02 and ?plot_data02 to see plot data02 documentation
