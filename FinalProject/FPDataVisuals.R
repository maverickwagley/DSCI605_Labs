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
#Filter Data for Just the Desired States
timeline = newDF %>%
  filter(NAME=="Indiana" | NAME=="Illinois" | NAME=="Michigan"| NAME=="Ohio" ) %>%
  #Add Day and Month Columns for Date Object Column
  mutate(Day = 1) %>%
  mutate(Month = 1) %>%
  #Add Column for Date Object
  mutate(Date=as.Date(format(as.Date(paste(Day, Month, Year, sep = '.'),"%d.%m.%Y"),"%Y-%m-%d")))

#Plot Stacked Line Graphs of Time Series
ggplot(timeline, aes(x=Date, y=Unemplyrate,color=NAME)) +
  #Plot Points
  geom_point() + 
  #Plot Lines Between Points
  geom_line() +
  #Update Date Labels
  scale_x_date(date_labels = "%Y",date_breaks = "1 year")+
  #Set Title Text
  ggtitle("Unemployment Rate Changes along with Years") +
  #Set X and Y Label Text
  xlab("Year") +
  ylab("Unemployment Rate")+
  #Hide Legend Title
  theme(legend.title=element_blank())
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