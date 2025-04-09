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

# Setup Data
setwd("~/FinalProject")
newDS = readRDS("CS_Erate_CrateCombined1.Rds")
newDF = as.data.frame(newDS)
#newDF
########################Initialize Data#######################
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
  ylab("Unemployment Rate per 100 People") +
  #Hide Legend Title
  theme(legend.title=element_blank())
#Draw Plot
sctr
########################Scatter Plot#######################
#