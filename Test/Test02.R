library(tidyverse)
setwd("C:/Users/maver/OneDrive/Documents/School/DS605/Datasets")
df = read.csv("Sampledata2.csv")

newDF = df %>%
  select(CrimeRate) %>%
  mutate(RangeGroup = case_when(CrimeRate < 250 ~"CrimeRate < 250",
                                CrimeRate >= 250 & CrimeRate <= 500 ~ "250 <= CrimeRate <= 500", 
                                CrimeRate > 500 ~"CrimeRate > 500"))
view(newDF)
