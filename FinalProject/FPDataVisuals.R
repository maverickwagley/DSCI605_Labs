#FPDataVisuals
#



#
########################Initialize Data#######################
# Load Libraries
library(tidyverse)
library(raster)          #raster()
library(sf)              #st_read()
library(ggspatial)       #annotation_scale,annotation_north_arrow
library(ggnewscale)      #new_scale_color() 
library(ggsn)            #scalebar()
library(shiny)           #Shiny app
library(plotly)          #plot_ly()
library(gridExtra)       #grid.arrange()
library(colorspace)
# Setup Data
setwd("~/FinalProject")
newDS = readRDS("CS_Erate_CrateCombined1.Rds")
newDF = as.data.frame(newDS)
#newDF
########################Initialize Data#######################
#



#
########################Time Series Data#######################
timeline = newDF %>%
  filter(NAME=="Indiana" | NAME=="Illinois" | NAME=="Michigan"| NAME=="Ohio" )

View(timeline)

ggplot(timeline, aes(x=Year, y=Unemplyrate,color=NAME)) +
  geom_point() + 
  geom_line() 
########################Time Series Data#######################
#



#
########################Spatial Map#######################
# A spatial map of the contiguous US in 2014
geoDF = newDF %>%
  filter(Year == "2014")

#Set Color Palette
mapPal = colorspace::diverge_hcl(20, palette = "Blue-Red")

#Plot
ggplot() +
  #States Shape
  geom_sf(data=geoDF$geometry,aes(fill=as.factor(floor(geoDF$Unemplyrate))))+
  #Scale Color With Palette
  scale_fill_manual(values = mapPal)+
  #Labels
  xlab("Longitude") + ylab("Latitude") +
  #Title
  ggtitle("Unemployment Rate Map over Contiguous US")
########################Spatial Map#######################
#



#
########################Scatter Plot#######################
# Scatter Plot of 2014's Unemploy/Crime Rates
sctr = newDF %>%
  # Get Just 2014
  filter(Year == "2014") %>%
  # Set X and Y Values
  ggplot(aes(x=Crimerate,y=Unemplyrate)) +
  # Add Data Points colored by Region
  geom_point(alpha=0.5,aes(color=REGION)) +
  #Set Title Text
  ggtitle("Unemployment Rate and Crime Rate in 2014") +
  #Set X and Y Label Text
  xlab("Crime Rate per 100 People") +
  ylab("Unemployment Rate per 100 People")+
  #Hide Legend Title
  theme(legend.title=element_blank())
#Draw Plot
sctr
########################Scatter Plot#######################
#