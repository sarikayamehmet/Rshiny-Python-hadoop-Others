
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("EVR Report"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(width = 3,
      selectInput(inputId = "circle", label = "select the terminating cirle",
                  choices = c("Mumbai",  "Maharastra")),
     selectInput(inputId = "msgType",label = "select the Message Type",choices = c("UNDELIV","DELIVRD")
                 ,selected = "DELIVRD"),
      dateRangeInput(inputId = "dateRange","Date")
      ),

    # Show a plot of the generated distribution
    mainPanel(
      #dataTableOutput("distPlot")
      tabsetPanel(
       # tabPanel("Plot(Message status delivered)",plotOutput("plot2")),
        tabPanel("Plot (message status )",plotOutput ("plot1")),
        tabPanel("summary",dataTableOutput("table"))
      )
    )
  )
))
