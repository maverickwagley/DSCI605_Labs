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
newDF
########################Initialize Data#######################
#


#
########################Second Section#######################
# SubSection A
sctr = newDF %>%
  ggplot(aes(x=Crimerate,y=Unemplyrate)) +
  geom_point(alpha=0.5,aes(color=REGION,fill=REGION))
sctr
# SubSection B

########################Second Section#######################
#