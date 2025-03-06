#####
# MaverickWagley_Interactive plotting with Shiny app and plotly.R
#####

#Setup
library(tidyverse)
library(plotly)
library(readr)
#data()
#setwd()


#Create UI
ui = fluidPage(
  
  #Input Plotly Object A: State Line Plot
  selectInput(
    inputId = "inputcities",
    label = "Select a city",
    choices = unique(txhousing$city),
    selected = "Abilene",
    multiple = TRUE
  ),
  plotlyOutput(outputId = "outcities")
  
  #Input Plotly Object B: Year Histogram
  #...
)

#Create Server
server = function(input, output, ...){
  
  #Output Plotly Object A: State Line PLot
  output$outcities = renderPlotly({
    plot_ly(txhousing, x = ~date, y = ~median,color=~city) %>%
      filter(city %in% input$inputcities) %>%
      add_markers() %>%
      group_by(city) %>%
      add_lines() %>%
      layout(title="Housing sales in TX",
             xaxis=list(title="Date"),
             yaxis=list(title="Median sale price($))"))
  })
  
  #Output Plotly Object B: Year Histogram
  #...
  
}

#Run App
shinyApp(ui,server)