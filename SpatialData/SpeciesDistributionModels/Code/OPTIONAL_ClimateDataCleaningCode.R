### For the Keen Beans! Only refer here if interested.
#This is the code I used to clean the raw data downloaded from Worldclim. The Bioclim variables are named numerically, which can make understanding them confusing. 
#I downloaded the data, then renamed each layer of the raster stackes to the actual bioclim names
#I also added elevation to the climate data layers, so that they're all together in one stack

library(terra)
library(tidyterra)
library(tidyverse)
library(tidysdm)

#Read in the rasters

#First delete the old files to make sure we don't have duplicates when re-running this code
unlink(list.files("/RawData/FutureClimate/", full.names=TRUE))
unlink(list.files("/RawData/PastClimate/", full.names=TRUE))

PastClim <- rast(list.files("/Users/hannahwauchope/Dropbox/Work/Students/Teaching/_ClimateChange/SDMRawData/Past/", full.names=TRUE, pattern="*.tif"))
PastClimNames <- str_split_fixed(names(PastClim), "[_]", 4)[,4]
PastClimNames <- ifelse(nchar(PastClimNames)==1, paste0("0", PastClimNames), PastClimNames)
PastClimNames <- paste0("bio", PastClimNames)
names(PastClim) <- PastClimNames

PastClimNames <- sort(as.numeric(str_split_fixed(names(PastClim), "bio", 2)[,2]))
PastClimNames <- ifelse(nchar(PastClimNames)==1, paste0("0", PastClimNames), PastClimNames)
PastClimNames <- paste0("bio", PastClimNames)
PastClim <- relocate(PastClim, PastClimNames, PastClimNames)

PastClimNames <- recode(PastClimNames,
                        "bio01" = "MeanAnnualTemp", "bio02" = "MeanDiurnalRange",
                        "bio03" = "Isothermality", "bio04" = "TemperatureSeasonality",
                        "bio05" = "MaxTemperatureOfWarmestMonth", "bio06" = "MinTemperatureOfColdestMonth",
                        "bio07" = "TemperatureAnnualRange", "bio08" = "MeanTemperatureOfWettestQuarter",
                        "bio09" = "MeanTemperatureOfDriestQuarter", "bio10" = "MeanTemperatureOfWarmestQuarter",
                        "bio11" = "MeanTemperatureOfColdestQuarter", "bio12" = "AnnualPrecipitation",
                        "bio13" = "PrecipitationOfWettestMonth", "bio14" = "PrecipitationOfDriestMonth",
                        "bio15" = "PrecipitationSeasonality", "bio16" = "PrecipitationOfWettestQuarter",
                        "bio17" = "PrecipitationOfDriestQuarter", "bio18" = "PrecipitationOfWarmestQuarter",
                        "bio19" = "PrecipitationOfColdestQuarter")
names(PastClim) <- PastClimNames
writeRaster(PastClim, paste0("/RawData/PastClimate/", names(PastClim), ".grd"), NAflag = -9999, overwrite=TRUE)

Future <- rast("/Users/hannahwauchope/Dropbox/Work/Students/Teaching/_ClimateChange/SDMRawData/Future/wc2.1_5m_bioc_UKESM1-0-LL_ssp585_2081-2100.tif")
names(Future) <- recode(names(Future),
                        "bio01" = "MeanAnnualTemp", "bio02" = "MeanDiurnalRange",
                        "bio03" = "Isothermality", "bio04" = "TemperatureSeasonality",
                        "bio05" = "MaxTemperatureOfWarmestMonth", "bio06" = "MinTemperatureOfColdestMonth",
                        "bio07" = "TemperatureAnnualRange", "bio08" = "MeanTemperatureOfWettestQuarter",
                        "bio09" = "MeanTemperatureOfDriestQuarter", "bio10" = "MeanTemperatureOfWarmestQuarter",
                        "bio11" = "MeanTemperatureOfColdestQuarter", "bio12" = "AnnualPrecipitation",
                        "bio13" = "PrecipitationOfWettestMonth", "bio14" = "PrecipitationOfDriestMonth",
                        "bio15" = "PrecipitationSeasonality", "bio16" = "PrecipitationOfWettestQuarter",
                        "bio17" = "PrecipitationOfDriestQuarter", "bio18" = "PrecipitationOfWarmestQuarter",
                        "bio19" = "PrecipitationOfColdestQuarter")
writeRaster(Future, paste0("/RawData/FutureClimate/", names(Future), ".grd"), NAflag = -9999, overwrite=TRUE)

Elevation <- rast("/Users/hannahwauchope/Dropbox/Work/Students/Teaching/_ClimateChange/SDMRawData/wc2.1_5m_elev.tif")
names(Elevation) <- "Elevation"
writeRaster(Elevation, "/RawData/FutureClimate/Elevation.grd", NAflag = -9999, overwrite=TRUE)
writeRaster(Elevation, "/RawData/PastClimate/Elevation.grd", NAflag = -9999, overwrite=TRUE)

PastEle <- c(PastClim, Elevation)
plot(PastEle, nc=5, maxnl=20, axes=FALSE, box=TRUE, cex.main=1)

#### Make maps for demonstration
plot(PastClim[[1]], axes=FALSE)

ggplot()+
  geom_spatraster(data=PastClim[[1]])+
  geom_spatvector(data=BaseMap, fill="grey", colour="black")+
  scale_fill_viridis_c(na.value="white")+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))+
  theme_void()+
  theme(panel.border = element_rect(colour="black", fill=NA))

ggplot()+
  geom_spatraster(data=PastClimProj[[1]])+
  #geom_spatvector(data=BaseMap, fill="grey", colour="black")+
  scale_fill_viridis_c(na.value="white")+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))+
  theme_void()+
  theme(panel.border = element_rect(colour="black", fill=NA))


