
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("EVR Panel"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel( width = 3,
      selectInput("MSISDN","msisdn",choices = list("917094985524","919022257036"),selected = "917094985524"),
      dateRangeInput("datarange","DATE",format = "yyyy-mm-dd",start = Sys.Date()-10,
                     end = Sys.Date()+10),
      selectInput("clientId","clientId",choices = list("DM-BOISTR","DM-ICICIL"),selected = "DM-BOISTR"),
      selectInput("interval","Refresh Interval",
                  choices = c(
                    "30 seconds" = 30,
                    "1 min" = 60,
                    "2 min" = 120 ,
                    "5 min" =  300,
                    "10 min" = 600
                  ),selected = "300"),
      selectInput("terminating_circle","Terminating Circle",choices = list("Mumbai","Maharstra"),
                  selected = "Mumbai"),
      selectInput("map_message_id","MAP MESSAGE ID" ,
                  choices = list("004016071723575054313116","004016071720350593742610"),
                  selected = "004016071720350593742610")
      
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
