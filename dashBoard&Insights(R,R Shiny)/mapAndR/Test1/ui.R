library(shiny)
library(leaflet)

shinyUI(fluidPage(
  titlePanel("Hotel Map"),
  sidebarLayout(
    sidebarPanel(
      selectInput("year", 
                  label = "Choose Year:",
                  choices = c(2000,2005,2010),
                  selected = 2000
      )),
    
    mainPanel (leafletOutput("map","100%",300))
    
  )
))