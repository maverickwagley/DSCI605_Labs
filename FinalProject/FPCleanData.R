#FP Clean Data
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
setwd("~/School/DS605/DSCI605_Labs/FinalProject/final_data")
Unemployrate = read_csv("data/unemployment_county.csv")
Crimerate = read_csv("data/crime_and_incarceration_by_state.csv")
States = st_read("data/tl_2019_us_state/tl_2019_us_state.shp")
########################Initialize Data#######################
#


#
########################Process Polygon Data#######################
# Filter Regions Outside Contiguous USA
Contiguous_state = States%>% filter(STUSPS!="AK"& 
                                       STUSPS!="AS"& 
                                       STUSPS!="MP"& 
                                       STUSPS!="PR"& 
                                       STUSPS!="VI"& 
                                       STUSPS!="HI"& 
                                       STUSPS!="GU")
# Check Length
length(unique(Contiguous_state$STUSPS))
########################Process Polygon Data#######################
#



#
########################Process Unemployment Data#######################
# Check the length of State Column
unique(Unemployrate $State)
length(unique(Unemployrate $State))

# Process Unemployment 1 
Unemployrate = Unemployrate %>% 
  #Filter Non-Contiguous
  filter(State!="AK"& State!="HI") %>%
  #Group States and Years
  group_by(State,Year) %>% 
  #Summarize Data with new variables
  summarise(Totalforce=sum(`Labor Force`),
            Totalemployed=sum(Employed),
            Totalunemployed=sum(Unemployed),
            Meanrate=mean(`Unemployment Rate`,rm.na=TRUE)
  )

# Check the length of State again  
length(unique(Unemployrate $State))

# Process Unemployment 2
Unemployrate = Unemployrate %>% 
  #Match the column name of the crime data set
  rename("STUSPS"="State") %>% 
  #Get selection of years
  filter(Year %in% c(2007:2014))
########################Process Unemployment Data#######################
#



#
########################Process Crime Data#######################
# Check the length of states (jurisdiction)
unique(Crimerate$jurisdiction)
length(unique(Crimerate$jurisdiction))
head(Crimerate)

# Process Data
Crimerate =  Crimerate %>% 
  #Update Jurisdiction to STUSPS (Matches others)
  rename("STUSPS"="jurisdiction") %>% 
  #Update year to Year (Matches others)
  rename("Year"="year") %>% 
  #Filter for only contiguous US
  filter(STUSPS!="FEDERAL"& STUSPS!="ALASKA"& STUSPS!="HAWAII") %>% #library(stringr)
  #Filter for selected years 
  filter(Year %in% c(2007:2014))

# Recheck the data
length(unique(Crimerate$STUSPS))
head(Crimerate)

# Changes the state names in the state column "STUSPS"
Crimerate$STUSPS = state.abb[match(str_to_title(Crimerate$STUSPS),state.name)]

# Calculate the crimerate
Crimerate = Crimerate %>% 
  #Get Rate as a percent (value/total*100)
  mutate(Crimerate=(violent_crime_total/state_population)*100) %>% 
  dplyr::mutate_if(is.numeric, round, 1)
########################Process Crime Data#######################
#


save(list = c("Crimerate", "Unemployrate","Contiguous_state"), file = "CleaneData.Rdata")
##################Read data file into R
load(file = "CleaneData.Rdata")


#
########################The required columns#######################
# As CS_Erate, Join Polygon and Unemployment Tables (Merge to the Right)
CS_Erate<-right_join(Contiguous_state, Unemployrate, 
                     by = c("STUSPS"))
# As CS_Erate_Crate, Join CS_Erate and Crime Tables (Merge to the Right)
CS_Erate_Crate = right_join(CS_Erate, Crimerate, 
                             by = c("STUSPS","Year"))
# With newly joined tables, select only the needed columns
CS_Erate_Crate1 = CS_Erate_Crate %>% 
  select(REGION,STUSPS,NAME,Year,Meanrate,Crimerate) %>% 
  rename("Unemplyrate"="Meanrate")
########################The required columns#######################
#


#
########################Final Check and Save#######################
# Check for missing values
which(is.na(CS_Erate_Crate1$REGION))
# Save the object as CS_Erate_CrateCombined.Rds
#saveRDS(CS_Erate_Crate1, file = "CS_Erate_CrateCombined1.Rds")
########################Final Check and Save#######################
#