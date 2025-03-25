#####
# Mod12Practice.R
# Spacial Data
#####

#Packages
#Vector: rgdal::radOGR() or sf::st_read()
# Alt Package: sp
#Raster: rgdal:: radGDAL() or raster::raster()
# Alt Package: terra
library(tidyverse)
library(raster)
library(sf)
#
library(ggspatial)       #annotation_scale,annotation_north_arrow
library(ggnewscale)      #new_scale_color() 
library(ggsn) 
library(viridis)


#setwd("~/School/DS605/DSCI605_Labs/Module12")
point_df = read_csv("data/HARV_PlotLocations.csv")
polygon_sf = st_read("data/HarClip_UTMZ18.shp")
CHM_HARV = raster("data/HARV_chmCrop.tif")
CHM_HARV_df = as.data.frame(CHM_HARV, xy = TRUE)

#####Basic spatial mapping

ggplot(point_df)+  ###the points in a data frame format
  geom_raster(data = CHM_HARV_df, aes(x = x, y = y, fill = HARV_chmCrop)) +  ## the raster in a data frame format
  geom_point(aes(easting, northing, color = "red"), size = 2) + 
  geom_sf(data= polygon_sf)+  ### the polygon in a sp/sf format
  ggtitle("NEON Harvard Forest Field Site Canopy Height Model") +
  theme_bw()

