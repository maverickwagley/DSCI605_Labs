#Libraries
install.packages("bookdown")
library(tidyverse)
library(hrbrthemes)
library(viridis)
#Set Directory
setwd("C:/Users/maver/OneDrive/Documents/School/DS605/DSCI605_Labs/Datasets")
#Load Data
data(mpg)


#Basic Scatter Plot
mpg %>%
  arrange(desc(class)) %>%
  ggplot(aes(x=cty,y=displ,fill=class,shape=as.factor(cyl))) + 
  geom_point(alpha=0.5,color="black") + 
  scale_fill_viridis(discrete=TRUE,option="A") +
  theme(legend.position ="bottom") +
  guides(shape=guide_legend(nrow=2,byrow=TRUE,title="CYL"))+
  guides(fill=guide_legend(nrwo=2,byrow=TRUE,title="Class"))+
  ylab("Engine displacement, in litres (displ)") +
  xlab("City mile per gallon (cyt)")

#Scatter PLot 2
mpg %>%
  arrange(desc(class)) %>%
  ggplot(aes(x=cty,y=displ,size=year,fill=class)) + 
  geom_point(alpha=0.5,shape=21,color="black") + 
  scale_fill_viridis(discrete=TRUE,option="A") +
  theme(legend.position ="bottom") +
  guides(shape=guide_legend(nrow=2,byrow=TRUE,title="CYL"))+
  guides(fill=guide_legend(nrwo=2,byrow=TRUE,title="Class"))+
  ylab("Engine displacement, in litres (displ)") +
  xlab("City mile per gallon (cyt)")
  
