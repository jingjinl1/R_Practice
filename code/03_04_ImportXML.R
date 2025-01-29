# Title:    Importing XML data
# File:     03_04_ImportXML.R
# Project:  R_EssT_1; R Essential Training, Part 1:
#           Wrangling and Visualizing Data

# INSTALL AND LOAD PACKAGES ################################
# Load packages
pacman::p_load(pacman, tidyverse, XML2R) # XML2R: for working with XML data

# GET Web DATA & RESTRUCTURE ###################################

# Import XML data from web (must be online)
df <- "http://ergast.com/api/f1/1954/results/1.xml" %>%
  XML2Obs() %>%
  collapse_obs() %>%
  print()

# See variable (node) names and IDs
df %>%
  names() %>%
  print()

# EXTRACT & COMBINE DATA ###################################
#extract the XML_value from each named element before converting the list to a tibble
df <- tibble(                             
    Race = df$`MRData//RaceTable//Race//RaceName`[, "XML_value"], # Get race name
    FirstName = df$`MRData//RaceTable//Race//ResultsList//Result//Driver//GivenName`, # Get first name
    LastName = df$`MRData//RaceTable//Race//ResultsList//Result//Driver//FamilyName`[, "XML_value"], # Get last name
    Team = df$`MRData//RaceTable//Race//ResultsList//Result//Constructor//Name`[, "XML_value"]  # Get team name
  ) %>% 
  print()  

# FILTER & PRINT DATA ######################################

# Select just the Grand Prix races.
df %<>% 
  filter(str_detect(Race,"Prix")) %>%
  print()

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
p_unload(all)  # Remove all add-ons

# Clear plots
graphics.off()  # Clears plots, closes all graphics devices

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
