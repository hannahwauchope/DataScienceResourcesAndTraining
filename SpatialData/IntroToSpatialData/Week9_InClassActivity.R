#### A worksheet for understanding spatial data in R ####
## Created for Data Science For Ecologists and Environmental Scientists at The University of Edinburgh
## Created by Hannah Wauchope, Nov 2023

#### Load Packages, Define Projections ####

#Install packages we haven't used in class yet (don't think we've used plyr?)
install.packages(c("terra", "plyr", "rgbif", "geodata", "tidyterra"))

#Load packages
library(terra)
library(plyr)
library(dplyr)
library(ggplot2)
library(rgbif)
library(geodata)
library(tidyterra)

#Define projections
WGSCRS <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

#### Part 1 - Getting Our Sloth Data ####

## Exercise 2 (for this exercise only, code is provided)
PaleThroatedSloth <- name_backbone("Bradypus tridactylus")

PaleThroatedSloth <- occ_data(name_backbone("Bradypus tridactylus")$usageKey, hasGeospatialIssue=FALSE, limit=1000)$data
PygmySloth <- occ_data(name_backbone("Bradypus pygmaeus")$usageKey, hasGeospatialIssue=FALSE, limit=1000)$data
ManedSloth <- occ_data(name_backbone("Bradypus torquatus")$usageKey, hasGeospatialIssue=FALSE, limit=1000)$data

Sloths <- bind_rows(PaleThroatedSloth, PygmySloth, ManedSloth) %>%
  select(species, decimalLatitude, decimalLongitude) %>%
  filter(!is.na(decimalLatitude), !is.na(decimalLongitude))

## Exercise 3
SlothPts <- vect(Sloths, geom=c("decimalLongitude", "decimalLatitude"), crs=WGSCRS)
plot(SlothPts)

#### Part 2 - Get Some Climate Data ####

## Exercise 4

## Exercise 5

#### Part 3 - Cropping and Projecting Data ####

## Exercise 6

## Exercise 7

## Exercise 8

## Exercise 9

#### Part 4 - Extracting data ####

## Exercise 10

## Exercise 11

#### Part 5 - Working with Polygon Vectors ####

## Exercise 12

## Exercise 13

## Exercise 14

#### Part 6 - Extracting data from polygons ####

## Exercise 15

## Exercise 16

## Exercise 17

#### Part 7 - Plotting spatial objects ####

## Exercise 18

#### OPTIONAL CHALLENGE ####

SurWDPA <- vect("WDPA/SurWDPA.shp")
