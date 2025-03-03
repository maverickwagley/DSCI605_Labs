install.packages("plotly")
library(tidyverse)
library(plotly)
library(readr)

setwd("C:/Users/maver/OneDrive/Documents/School/DS605/DSCI605_Labs/Datasets")
tcg = read.csv("TCGDataset.csv")

fig = plot_ly(x = tcg$Set.Name, y = tcg$Fairy, type ='bar') %>%
  layout(title="Fairy Per Set",plot_bgcolor='#e5ecf6')
fig
