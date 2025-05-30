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
########################Plotly Time Series#######################
#Filter Data for Just the Desired States
timeline = newDF %>%
  filter(NAME=="Indiana" | NAME=="Illinois" | NAME=="Michigan"| NAME=="Ohio" ) %>%
  #Add Day and Month Columns for Date Object Column
  mutate(Day = 1) %>%
  mutate(Month = 1) %>%
  #Add Column for Date Object
  mutate(Date=as.Date(format(as.Date(paste(Day, Month, Year, sep = '.'),"%d.%m.%Y"),"%Y-%m-%d")))

#Unemployment Plot
plot_ly(data=timeline,x=~Date,y=~Unemplyrate,type="scatter",mode="lines",color=~NAME) %>%
  layout(title="Unemployment Rate Over Time",xaxis=list(title="Year"),yaxis=list(title="Unemployment Rate"))

#Crime Plot
plot_ly(data=timeline,x=~Date,y=~Crimerate,type="scatter",mode="lines",color=~NAME) %>%
  layout(title="Crime Rate Over Time",xaxis=list(title="Year"),yaxis=list(title="Crime Rate"))
########################Plotly Time Series#######################
#


#
########################GGPlot Spatial Map#######################
# A spatial map of the contiguous US in 2014
geoDF = newDF %>%
  filter(Year == "2014")

#Set Color Palette
mapPal = colorspace::diverge_hcl(20, palette = "Blue-Red")

#Unemployment Plot
ggplot() +
  #States Shape
  geom_sf(data=geoDF$geometry,aes(fill=as.factor(floor(geoDF$Unemplyrate))))+
  #Scale Color With Palette
  scale_fill_manual(values = mapPal)+
  #Scale Bar
  annotation_scale(location="bl", width_hint=0.5) +
  #North Arrow
  annotation_north_arrow(location = "bl", which_north = "true",
                         pad_x = unit(0, "in"), pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  #Set Legend Position
  theme(legend.position = "bottom") +
  #Remove Legend Title
  labs(fill = "Unemployment Rate")+
  #Set font size for all texts
  theme(text = element_text(size=20)) +
  #Labels
  xlab("Longitude") + ylab("Latitude") +
  #Title
  ggtitle("2014 Unemplyment Rate Map over Contiguous US")


#Crime Plot
ggplot() +
  #States Shape
  geom_sf(data=geoDF$geometry,aes(fill=as.factor(geoDF$Crimerate)))+
  #Scale Color With Palette
  scale_fill_manual(values = mapPal)+
  #Scale Bar
  annotation_scale(location="bl", width_hint=0.5) +
  #North Arrow
  annotation_north_arrow(location = "bl", which_north = "true",
                         pad_x = unit(0, "in"), pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  #Set Legend Position
  theme(legend.position = "bottom") +
  #Remove Legend Title
  labs(fill = "Crime Rate")+
  #Set font size for all texts
  theme(text = element_text(size=20)) +
  #Labels
  xlab("Longitude") + ylab("Latitude") +
  #Title
  ggtitle("2014 Crime Rate Map over Contiguous US")
########################GGplot Spatial Map#######################
#



#
########################GGPlot Spatial Map#######################
# A spatial map of the contiguous US in 2014
geoDF = newDF %>%
  filter(Year == "2014")

#Set Color Palette
mapPal = colorspace::diverge_hcl(20, palette = "Blue-Red")

#Unemployment Plot
ggplot() +
  #States Shape
  geom_sf(data=geoDF$geometry,aes(fill=as.factor(floor(geoDF$Unemplyrate))))+
  #Scale Color With Palette
  scale_fill_manual(values = mapPal)+
  #Labels
  xlab("Longitude") + ylab("Latitude") +
  #Title
  ggtitle("Unemployment Rate Map over Contiguous US")


#Crime Plot
ggplot() +
  #States Shape
  geom_sf(data=geoDF$geometry,aes(fill=as.factor(floor(geoDF$CrimeRate))))+
  #Scale Color With Palette
  scale_fill_manual(values = mapPal)+
  #Labels
  xlab("Longitude") + ylab("Latitude") +
  #Title
  ggtitle("Unemployment Rate Map over Contiguous US")
########################GGplot Spatial Map#######################
#



#
########################Plotly Crime and Unemployment Scatter#######################
# Filter Data for Just 2014
sctr = newDF %>% filter(Year == "2014") 
#Plot Time 
plot_ly(data=sctr,x=~Crimerate,y=~Unemplyrate,type="scatter",mode="markers",color=~REGION) %>%
  layout(title="2014 Crime and Unemployment by Region",xaxis=list(title="Crime Rate per 100 People"),yaxis=list(title="Unemployment Rate per 100 People"))
########################Plotly Crime and Unemployment Scatter#######################
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