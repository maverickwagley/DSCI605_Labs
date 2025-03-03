install.packages("plotly")

library(plotly)
p = plot_ly(x=rnorm(1000),y=rnorm(1000),mode='markers')
p

plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length, color= ~Species,
         type = "scatter",mode="markers")

plot_ly(iris, x = ~Petal.Width, color=~Species, type="box")

land = readxl::read_xlsx('Crop_Range_GOES0901_CountJday.xlsx')
View(land)
