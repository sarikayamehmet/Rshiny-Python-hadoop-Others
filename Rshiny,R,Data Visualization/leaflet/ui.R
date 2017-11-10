library(shiny)
library(leaflet)
## leafletOutput is used at the ui side to display the rendered map.

shinyUI(fluidPage(
headerPanel("State wise message delivered"),
    leafletOutput("mymap")
  ))