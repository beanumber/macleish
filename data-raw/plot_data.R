library(readxl)
library(tidyverse)
library(janitor)
library(lubridate)
library(stringr)
library(usethis)
library(devtools)
library(dplyr)

#Uploading data into R
tree_diameter1 <- read_excel("data-raw/MacLeish Data_Plot MC-01.xlsx")
tree_diameter2 <- read_excel("data-raw/MacLeish Data_Plot MC-02.xlsx")

#Plot Data 1
#Creating year and height column 
tree_diameter1 <- tree_diameter1 %>%
  pivot_longer(c(`Fall'15`, `Fall'14`,`Fall'13`,`Fall'12`,`Fall'11`,`Fall'10`), names_to = "Year", values_to = "Diameter(cm)")

#Separating fall and year into new columns 
tree_diameter1 <- tree_diameter1 %>%
  separate(Year, c("Semester", "Year"), sep = 4)

#Changing abbreviated year into full year 
tree_diameter1$Year[tree_diameter1$Year == "'15"] <- "2015"
tree_diameter1$Year[tree_diameter1$Year == "'14"] <- "2014"
tree_diameter1$Year[tree_diameter1$Year == "'13"] <- "2013"
tree_diameter1$Year[tree_diameter1$Year == "'12"] <- "2012"
tree_diameter1$Year[tree_diameter1$Year == "'11"] <- "2011"
tree_diameter1$Year[tree_diameter1$Year == "'10"] <- "2010"

#Changing value "DEAD" to NA for diameter
#Tree diameter didn't increase or decrease over time 
tree_diameter1$`Diameter(cm)`[tree_diameter1$`Diameter(cm)` == "DEAD"] <- "NA"

View(tree_diameter1)

#Plot Data 2

#Creating year and height column 
tree_diameter2 <- tree_diameter2 %>%
  pivot_longer(c(`FALL 2016`, `Fall'12`,`Fall'11`,`Fall'10`,`Fall'09`), names_to = "Year", values_to = "Diameter(cm)")

#Separating fall and year into new columns 
tree_diameter2 <- tree_diameter2 %>%
  separate(Year, c("Semester", "Year"), sep = 4)

#Changing abbreviated year into full year 
tree_diameter2$Year[tree_diameter2$Year == "'09"] <- "2009"
tree_diameter2$Year[tree_diameter2$Year == "'10"] <- "2010"
tree_diameter2$Year[tree_diameter2$Year == "'11"] <- "2011"
tree_diameter2$Year[tree_diameter2$Year == "'12"] <- "2012"

#Changing fall to lowercase
tree_diameter2$Semester[tree_diameter2$Semester == "FALL"] <- "Fall"

#Changing value "DEAD" to NA for height 
tree_diameter2$`Diameter(cm)`[tree_diameter2$`Diameter(cm)` == "DEAD"] <- "NA"

View(tree_diameter2)

usethis::use_data(tree_diameter1, overwrite = TRUE)
usethis::use_data(tree_diameter2, overwrite = TRUE)

#Run this in console for documentation functionality 
devtools::document()

#Documentation complete:
#Use tree_diameter1 and ?tree_diameter1 to see plot data01 documentation
#Use tree_diameter2 and ?tree_diameter2 to see plot data02 documentation
