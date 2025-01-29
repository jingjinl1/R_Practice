#Notes for 3.Importing Data
#Created: 29/01/2025
#Created by: JJ

# LOAD PACKAGES ################################
#The datasets package is install by default but not loaded
library(datasets)           # Load example datasets
?datasets                   # Get help on package
library(help = "datasets")  # Get list of datasets

#List of datasets in package with p_data()
p_data(datasets)
#Tidyverse is a collection of packages, not datasets
p_data(tidyverse)  # Output: no data sets found


#Process XML data from website#############################
# Load packages
pacman::p_load(pacman, tidyverse, XML2R) # XML2R: for working with XML data

# Import XML data from web (must be online)
df <- "http://ergast.com/api/f1/1954/results/1.xml" %>%
  XML2Obs() %>%
  collapse_obs() %>%
  print()

df <- tibble(                             
  Race = df$`MRData//RaceTable//Race//RaceName`[, "XML_value"], # Get race name
  FirstName = df$`MRData//RaceTable//Race//ResultsList//Result//Driver//GivenName`[, "XML_value"], # Get first name
  LastName = df$`MRData//RaceTable//Race//ResultsList//Result//Driver//FamilyName`[, "XML_value"], # Get last name
  Team = df$`MRData//RaceTable//Race//ResultsList//Result//Constructor//Name`[, "XML_value"]  # Get team name
) %>% 
  print() 
# See variable (node) names and IDs
df %>%
  names() %>%
  print()


#extract the XML_value from each named element before converting the list to a tibble
df <- tibble(                             
  Race = df$`MRData//RaceTable//Race//RaceName`[, "XML_value"], # Get race name
  FirstName = df$`MRData//RaceTable//Race//ResultsList//Result//Driver//GivenName`[, "XML_value"], # Get first name
  LastName = df$`MRData//RaceTable//Race//ResultsList//Result//Driver//FamilyName`[, "XML_value"], # Get last name
  Team = df$`MRData//RaceTable//Race//ResultsList//Result//Constructor//Name`[, "XML_value"]  # Get team name
) %>% 
  print()  

# FILTER & PRINT DATA ######################################

# Select just the Grand Prix races.
df %<>% 
  filter(str_detect(Race,"Prix")) %>%
  print()