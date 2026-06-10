#### Welcome! Use this code to crop your species and climate data down to your basemap area, and project into an equal area projection
#Walk through the code slowly, making sure you understand
#Wherever you see an EDIT ME - your input is required. 

#Firstly, make sure you have these packages installed. 
#Run    install.packages("PACKAGENAME")     if not
#Then load
library(terra)
library(tidyterra)
library(tidyverse)
library(tidysdm) #You're very likely to need to install this one

#### 1. Read in Data ####

##1a. Read in Species Data and turn into a spatial points file
#**EDIT ME** - Adjust this file path so it matches your species occurrence data. Note that the file paths are relative to this folder
SpeciesOcc <- read.csv("RawData/....csv")

#These lines clean the data, and tell R that it is a spatial points file. They also tell it the current projection (EPSG 4326 is that projection that means 'normal lats and longs')
names(SpeciesOcc) <- c("Species", "Lon", "Lat")
SpeciesOcc <- vect(SpeciesOcc, geom=c("Lon", "Lat"))
crs(SpeciesOcc) <- "EPSG:4326"

##1b. Read in Base Map Data
#**EDIT ME** - Change the below line to the file path to your basemap (if you created your basemap in R, skip this step, just make sure yours is loaded and called 'BaseMap')
#We don't need any more code here, as the 'shapefile' already tells R everything it needs to know about the data and its projection
BaseMap <- vect("RawData/BaseMap/....shp") 

## 1c. Read in Climate Files
PastClim <- rast(list.files("RawData/PastClimate/", full.names=TRUE, pattern="*.grd$"))
FutureClim <- rast(list.files("RawData/FutureClimate/", full.names=TRUE, pattern="*.grd$"))

#### CHECK POINT ####
#Have those files read in correctly? Let's check
plot(BaseMap)
points(SpeciesOcc)

#R should have plotted your BaseMap, with points correctly overlaid. Not showing correctly? That means something's gone wrong - check your file paths, column names, and base map!

#Now let's check the climate data
plot(PastClim)
#R should plot a world map with different colours, this is one of the climate rasters. 

#Check future too
plot(FutureClim)

#### 2. Project everything into an equal area projection ####
#As discussed in the lecture ('Types of Spatial Data') - maps need to be in an equal area projection. 

#**YOU NEED TO CHOOSE THE RIGHT PROJECTION FOR YOUR AREA**:
#Choose from the following options, whichever is close-enough to right for your basemap (if you're in the middle east, go for Africa, if Russia, go for Asia):
#Europe: "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=32100006"
#North America: "ESRI:102008"
#South America: "+proj=laea +lat_0=-15 +lon_0=-60 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +type=crs"
#Africa (and middle east): "ESRI:102022"
#Oceania (and far south east Asia): "ESRI:102028"
#Asia (and Russia): "ESRI:102012"

#**EDIT ME** Copy your chosen projection into the quotations below, to project your species data, basemap and climate data to the right one

SpeciesOccProj <- project(SpeciesOcc, "...")
BaseMapProj <- project(BaseMap, "...")
PastClimProj <- project(PastClimCrop, "...", res=25000)
FutureClimProj <- project(FutureClimCrop, "...", res=25000)

#### CHECK POINT ####

#Did that projecting work okay? Make sure these maps look sensible
plot(BaseMapProj) #This should be your basemap, looking normal
points(SpeciesOccProj) #Points should appear on top

plot(PastClimProj) #Climate rasters should look similarly normal
plot(FutureClimProj)

#### 3. Cut Climate Maps to Size ####

#These two lines crop the global climate layers down to just the area the basemap covers
PastClimCrop <- crop(PastClimProj, BaseMap, mask=TRUE)
FutureClimCrop <- crop(FutureClimProj, BaseMap, mask=TRUE)

#### CHECK POINT ####
#Did that cropping work? Have a look and see if the climate data is covering just your basemap area now:
plot(PastClimCrop)
plot(FutureClimCrop)


#### 4. Thin species points to one per grid cell ####
#**EDIT ME** This function needs to know the projection, so copy the one from above again into the dots after 'crs'
SpeciesOccProjThin <- vect(thin_by_cell(as.data.frame(SpeciesOccProj, geom="xy"), PastClimProj[[1]]), geom=c("x", "y"), crs="...")

#### Save all the files ####
writeRaster(PastClimProj, paste0("ModelReadyData/PastClimateProjected/", names(PastClimProj), ".grd"), NAflag = -9999, overwrite=TRUE)
writeRaster(FutureClimProj, paste0("ModelReadyData/FutureClimateProjected/", names(PastClimProj), ".grd"), NAflag = -9999, overwrite=TRUE)
writeVector(BaseMapProj, "ModelReadyData/BaseMapProjected/BaseMapProjected.shp")
write.csv(as.data.frame(SpeciesOccProjThin, geom="xy"), "ModelReadyData/SpeciesOccurrencesProjected.csv", row.names=FALSE)
