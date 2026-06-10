###Welcome!! This is a bit of starter code for if you want to make your figures in R
#I'm assuming you have some knowledge/ability with ggplot. 
#Play around with scale_fill_manual and scale_fill_viridis for raster colour palettes

#Firstly, make sure you have these packages installed. 
#Run    install.packages("PACKAGENAME")     if not
#Then load
library(terra)
library(tidyterra)
library(tidyverse)
library(viridis)

#Here's a place for you to explore making map plots. I've given you starter code to make a map - you can play around to make these prettier!

#Read in all the data
PastClim <- rast(list.files("ModelReadyData/PastClimateProjected/", full.names=TRUE, pattern="*.grd$"))
FutureClim <- rast(list.files("ModelReadyData/FutureClimateProjected/", full.names=TRUE, pattern="*.grd$"))

BaseMap <- vect("ModelReadyData/BaseMapProjected/BaseMapProjected.shp")

SpeciesOcc <- read.csv("ModelReadyData/SpeciesOccurrencesProjected.csv")
SpeciesOcc <- vect(SpeciesOcc, geom=c("x", "y"))
crs(SpeciesOcc) <- "..." #**EDIT ME** Make sure you make this whatever your projection was in the 1_PreparingDataCode file!

#Here's a plot of your map plus species data
(MapPlusSpecies <- ggplot()+
  geom_spatvector(data=BaseMap, colour="grey50")+
  geom_spatvector(data=SpeciesOcc, colour="steelblue", size=0.5)+
  theme_void())

#Here's a plot of raster data (note that because 'PastClim' is a stack, we have to just select the first layer, and name accordingly)
(Climate <- ggplot()+
  geom_spatraster(data=PastClim[[1]])+
  scale_fill_viridis(na.value="white", name=names(PastClim[[1]]))+
  theme_void())

### Once you've run your maxent models, read them in as raster files, and adapt the above code to read in and plot your map output. 

#!!!!!Remember to add "limits=c(0,1)" to your 'scale_fill..." call to make your past and future distribution maps comparable. 

#When you're happy with your plots, use the ggsave function.
#You'll need to play around with width and height till you're happy for your particular map area
#Also adjust the file path, and object being saved to whatever it is you're saving

ggsave("FinalFigures/ClimateTestSave.pdf", Climate)


