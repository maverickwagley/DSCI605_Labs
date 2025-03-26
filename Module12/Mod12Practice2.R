#####
# Mod12Practice2.R
#####

#####
# Libraries
#####
library(tidyverse)
library(raster)
library(sf)
library(ggspatial)
library(ggnewscale)
library(ggsn)
library(viridis)
#####

#####
# Program
#####

#Set WD
setwd("~/School/DS605/DSCI605_Labs/Module12")

#Read Spatial Objects
point_df = read_csv("data/HARV_PlotLocations.csv")
polygon_sf = st_read("data/HarClip_UTMZ18.shp")
CHM_HARV = raster("data/HARV_chmCrop.tif")
CHM_HARV_df = as.data.frame(CHM_HARV, xy = TRUE)

#Plot with ggplot
ggplot(point_df)+  ###the points in a data frame format
  geom_raster(data = CHM_HARV_df, aes(x = x, y = y, fill = HARV_chmCrop)) +  ## the raster in a data frame format
  geom_point(aes(easting, northing, color = "red"), size = 2) + 
  geom_sf(data= polygon_sf)+  ### the polygon in a sp/sf format
  ggtitle("NEON Harvard Forest Field Site Canopy Height Model") +
  theme_bw()

#Polish Map
ggplot(point_df) +
  
  #Raster Image
  geom_raster(data = CHM_HARV_df, aes(x = x, y = y, fill = HARV_chmCrop)) +  ## the raster in a data frame format
  #Legend
  guides(fill=guide_legend("Canopy Height")) +
  #Color System
  scale_fill_viridis(option = "D") +
  #Plot Points, set color inside aesthetic
  geom_point(aes(easting, northing, color = "A"), size = 3) + 
  scale_color_manual(values=c("A" = "red"),labels = c("Samples"),name="") +
  
  new_scale_color()+
  #Plot Polygons set color inside aesthetic
  geom_sf(data= polygon_sf, alpha = 0, aes(color="B"), show.legend = "polygon")+  ### the polygon in a sp/sf format
  scale_color_manual(values=c("B" = "blue"),labels = c("Area of Interest"),name="") +
  #Scale Bar
  annotation_scale(location="bl", width_hint=0.5) +
  #North Arrow
  annotation_north_arrow(location = "bl", which_north = "true",
                         pad_x = unit(0, "in"), pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  #Set Legend Position
  theme(legend.position = "bottom") +
  #Set font size for all texts
  theme(text = element_text(size=20)) +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("NEON Harvard Forest Field Site Canopy Height Model")

#Save
#ggsave("map_NEON.png",width=12,height=10,dpi=300,unit='in')
