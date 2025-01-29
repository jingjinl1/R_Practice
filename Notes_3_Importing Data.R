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