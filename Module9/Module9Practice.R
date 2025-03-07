
library(tidyverse)
library(plotly)
library(readr)
data(txhousing)
View(txhousing)

ui = fluidPage(
  selectInput(
    inputId = "inputcities",
    label = "Select a city",
    choices = unique(txhousing$city),
    selected = "Abilene",
    multiple = TRUE
  ),
  plotlyOutput(outputId = "outcities")
)

server = function(input, output, ...){
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
}
shinyApp(ui,server)