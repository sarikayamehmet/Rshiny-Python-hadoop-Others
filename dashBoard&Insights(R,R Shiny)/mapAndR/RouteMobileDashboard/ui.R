
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)

shinyUI(fluidPage(

  # Application title
  titlePanel("Dashboard"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("userId",label = "select the userID", choices = list(950,737),
                  selected = 737) ,
      selectInput("vmn",label = "select the VMN", choices = list(9222281818,9029906308),
                  selected = 9222281818) , 
      selectInput(inputId = "terminatingOperator", label = "Select the Terminating Operator",
                  choices = c("BSNL","IDEA")
      ),
      selectInput(inputId = "terminatingCircle", label = "Select the Terminating Circle",
                  choices = c("Delhi","Mumbai")),
      dateRangeInput(inputId ="dateRangeID",label = "Date",format = "yyyy-mm-dd")
    ),
    # Show a plot of the generated distribution

    mainPanel(
      tabsetPanel(
        tabPanel("MAP(Message delivered state wise)",leafletOutput("mymap")),
         tabPanel("Plot-Missed Call per Hour(filter=VMN and Date)",plotOutput("plot1")),
        tabPanel("Terminating circle Analysis (Filter = Date,Terminating Circle)",plotOutput("plot2")), 
        tabPanel("summary", dataTableOutput("table"))
        )
      )
    )
  )
)


