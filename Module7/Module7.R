#Libraries
library(tidyverse)
#Set Directory
setwd("C:/Users/maver/OneDrive/Documents/School/DS605/Datasets")
#Set to DF
crimeDF = read.csv("Income By States.csv")
View(crimeDF)
#plot the basic histogram
ggplot(crimeDF, aes(x=income)) + 
  geom_histogram(binwidth=10000,color="black", fill="blue")

#save as jpeg
jpeg(file="Histogram_jep.jpeg",width = 800, height = 1000,res=300)
ggplot(crimeDF, aes(x=income)) + 
  geom_histogram(binwidth=5000,color="black", fill="blue")
dev.off()




#save as png
png(file="Histogram_png.png",
    width=600, height=350)
ggplot(crimeDF, aes(x=income)) + 
  geom_histogram(binwidth=5000,color="black", fill="blue")
dev.off()







#save into a pdf
pdf(file="Histogram.pdf",width = 8, height = 10)
ggplot(crimeDF, aes(x=income)) + 
  geom_histogram(binwidth=5000,color="black", fill="blue")

ggplot(crimeDF, aes(x=income)) + 
  geom_histogram(binwidth=5000,color="black", fill="red")

ggplot(crimeDF, aes(x=income)) + 
  geom_histogram(binwidth=5000,color="black", fill="green")
dev.off()
