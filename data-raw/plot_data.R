library(readxl)
library(tidyverse)
library(janitor)
library(lubridate)
library(stringr)
library(usethis)
library(devtools)
library(dplyr)

# Uploading data into R
tree_diameter1 <- read_excel("data-raw/MacLeish Data_Plot MC-01.xlsx")
tree_diameter2 <- read_excel("data-raw/MacLeish Data_Plot MC-02.xlsx")

# Plot Data 1
# Creating year and height column 
tree_diameter1 <- tree_diameter1 %>%
  pivot_longer(c(`Fall'15`, `Fall'14`,`Fall'13`,`Fall'12`,`Fall'11`,`Fall'10`), names_to = "year", values_to = "diameter")

# Separating fall and year into new columns 
tree_diameter1 <- tree_diameter1 %>%
  separate(year, c("semester", "year"), sep = 4)

# Changing abbreviated year into full year 
tree_diameter1$year[tree_diameter1$year == "'15"] <- "2015"
tree_diameter1$year[tree_diameter1$year == "'14"] <- "2014"
tree_diameter1$year[tree_diameter1$year == "'13"] <- "2013"
tree_diameter1$year[tree_diameter1$year == "'12"] <- "2012"
tree_diameter1$year[tree_diameter1$year == "'11"] <- "2011"
tree_diameter1$year[tree_diameter1$year == "'10"] <- "2010"

# Changing value "DEAD" to NA for diameter
# Tree diameter didn't increase or decrease over time 
tree_diameter1$`diameter`[tree_diameter1$`diameter` == "DEAD"] <- "NA"

# Changing variable names to lowercase and removing numerical units 
tree_diameter1 <- tree_diameter1 %>%
  rename(notes = `Notes:`, module = `Module#`, tag = `Tag#`) %>% 
  rename_with(tolower)

# Plot Data 2

# Creating year and height column 
tree_diameter2 <- tree_diameter2 %>%
  pivot_longer(c(`FALL 2016`, `Fall'12`,`Fall'11`,`Fall'10`,`Fall'09`), names_to = "year", values_to = "diameter")

# Separating fall and year into new columns 
tree_diameter2 <- tree_diameter2 %>%
  separate(year, c("semester", "year"), sep = 4)

# Changing abbreviated year into full year 
tree_diameter2$year[tree_diameter2$year == "'09"] <- "2009"
tree_diameter2$year[tree_diameter2$year == "'10"] <- "2010"
tree_diameter2$year[tree_diameter2$year == "'11"] <- "2011"
tree_diameter2$year[tree_diameter2$year == "'12"] <- "2012"

# Changing fall to lowercase
tree_diameter2$semester[tree_diameter2$semester == "FALL"] <- "Fall"

# Changing value "DEAD" to NA for height 
tree_diameter2$diameter[tree_diameter2$diameter == "DEAD"] <- "NA"

# Changing variable names to lowercase and removing numerical units
tree_diameter2 <- tree_diameter2 %>%
  rename(notes = `Notes:`, module = `Module#`, tag = `Tag#`) %>% 
  rename_with(tolower)

# Replace species listed as "???" with NA
tree_diameter2$species[tree_diameter2$species == "???"] <- "NA"

usethis::use_data(tree_diameter1, overwrite = TRUE)
usethis::use_data(tree_diameter2, overwrite = TRUE)
