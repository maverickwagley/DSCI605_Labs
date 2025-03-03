#Libraries
library(tidyverse)
#Set Directory
setwd("C:/Users/maver/OneDrive/Documents/School/DS605/DSCI605_Labs/Datasets")
#Set to DF
crimeDF = read.csv("Sampledata2.csv")
#Add new group column
newDF = crimeDF %>%
  mutate(RangeGroup = case_when(CrimeRate < 250 ~"CrimeRate < 250",
                                CrimeRate >= 250 & CrimeRate <= 500 ~ "250 <= CrimeRate <= 500", 
                                CrimeRate > 500 ~"CrimeRate > 500"))

#Create Color Vectors
col1 = colorspace:diverge_hcl(n)
col2 = c("green","blue","red")

#Histogram 1
ggplot(newDF,aes(x=CrimeRate)) +
  geom_histogram(aes(color=as.factor(Year), fill=as.factor(Year)),position="dodge",alpha=0.5,bins=10)+ 
  scale_fill_manual(values=col1) +
  scale_color_manual(values=col1) +
  theme(legend.position = "right")

#Histogram 2
ggplot(newDF,aes(x=CrimeRate)) +
  geom_histogram(aes(color=as.factor(RangeGroup), fill=as.factor(RangeGroup)),position="dodge",alpha=0.5,bins=10)+
  scale_fill_manual(values=col2) +
  scale_color_manual(values=col2) +
  theme(legend.position = "right") 