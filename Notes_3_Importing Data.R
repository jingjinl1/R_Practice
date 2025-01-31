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
#Tidyverse is a collection of packages, not dataset
p_data(tidyverse)  # Output: no data sets found


#Process XML data from website#############################
# Load packages
pacman::p_load(pacman, tidyverse, XML2R) # XML2R: for working with XML data

# Import XML data from web (must be online)
df <- "http://ergast.com/api/f1/1954/results/1.xml" %>%
  XML2Obs() %>%
  collapse_obs() %>%
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

# Filter data, Select just the Grand Prix races.
df %<>% 
  filter(str_detect(Race,"Prix")) %>%
  print()

#Json data#############################
# Load contributed packages with pacman
pacman::p_load(pacman, tidyverse, jsonlite)
#GET data
dat <- "https://api.jolpi.ca/ergast/f1/1954/results/1.json" %>%
  fromJSON()  %>%  # Put data into list
  print()          # See raw data

# See nested JSON stucture
dat %>% toJSON(pretty = T)

# View the structure of the dat object to see that the races
# are in a data.frame object.
str(dat)

# Race name is in: dat$MRData$RaceTable$Races, to process it, you have to make it a data frame first
df <- dat$MRData$RaceTable$Races 
   #%>% as_tibble %>% print() #you can make it as tibble to see the table version of the Races

#In the Races dataframe that was just created, we want race names; In results dataframe (nested), 
#we want "givenName" and "familyName" from nested "Driver" dataframe; and "name" from nested "Constructor" dataframe
#Unnest dataframe and select wanted variables; 
#Use names_repair because some of the nested dataframes have the same variable names
df %<>% 
  unnest_wider(Results) %>% 
  unnest_wider(Driver, names_repair = "unique") %>% 
  unnest_wider(Constructor, names_repair = "unique") %>% 
  select(
    Race      = raceName,    # Get race name
    FirstName = givenName,   # Get first name
    LastName  = familyName,  # Get last name
    Team      = name         # Get team name
  ) %>%
  print()  # Show data
