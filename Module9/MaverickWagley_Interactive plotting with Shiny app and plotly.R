#####
# MaverickWagley_Interactive plotting with Shiny app and plotly.R
#####

#Setup
library(tidyverse)
library(plotly)
library(readr)
setwd("C:/Users/maver/OneDrive/Documents/School/DS605/DSCI605_Labs/Datasets")
mainData = readxl::read_xlsx('Sampledata2.xlsx')


#Create UI
ui = fluidPage(
  
  #Input Plotly Object A: State Line Plot
  selectInput(
    inputId = "inputstates",
    label = "States",
    choices = unique(mainData$State),
    selected = "Alabama",
    multiple = TRUE
  ),
  
  #Input Plotly Object B: Year Histogram
  selectInput(
    inputId = "inputyears",
    label = "Years",
    choices = unique(mainData$Year),
    selected = "2007",
    multiple = FALSE
  ),
  
  #Plotly IDs
  plotlyOutput(outputId = "outstates"),
  plotlyOutput(outputId = "outyears")
 
)

#Create Server State, Year, CrimeRate
server = function(input, output, ...){
  
  #Output Plotly Object A: State Line PLot
  output$outstates = renderPlotly({
    plot_ly(mainData, x = ~Year, y = ~CrimeRate,color=~State) %>%
      filter(State %in% input$inputstates) %>%
      add_markers() %>%
      group_by(State) %>%
      add_lines() %>%
      layout(title="Crime Rate Per Year (Individual States)",
             xaxis=list(title="Year"),
             yaxis=list(title="Crime Rate"))
  })
  
  #Output Plotly Object B: Histogram
  output$outyears = renderPlotly({
    plot_ly(mainData, x = ~State, y = ~CrimeRate)%>%
      add_histogram(marker = list(color = "teal", line = list(color = "darkgray", width = 2)), name = "Year23")
  })
}

#Run App
shinyApp(ui,server)