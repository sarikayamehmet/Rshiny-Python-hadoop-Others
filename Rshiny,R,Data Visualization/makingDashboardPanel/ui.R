
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Dashboard"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("userId",label = "select the userID", choices = list(950,737),
                  selected = 950) ,
      selectInput("vmn",label = "select the VMN", choices = list(9222281818,9029906308),
                  selected = 9222281818) , 
      selectInput("hour",label = "select the hour",choices = list(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
                  ,selected = 0 ),
      selectInput("day",label = "select the day",choices = list("1 june" = 1 ,
                                                                "2 june" = 2,
                                                                "3 june" = 3,
                                                                "4 june" = 4,
                                                                "5 june" = 5,
                                                                "6 june"= 6 ,
                                                                "7 june" =7 ,
                                                                "8 june" = 8, "9 june" = 9 ,
                                                                "10 june" = 10 ,"11 june" = 11 ,
                                                                "12 june" = 12 , "13 june" =13,
                                                                "14 june" = 14 , "15 june" =15
      ),selected = 1)
      #,
     # dateRangeInput("dates", label = h3("Date range"),format = "yyyy/mm/dd")
     
     
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      #dataTableOutput("table")
      
      tabsetPanel(
       
        tabPanel("Plot (select VMN and DAY for filter )",
                 plotOutput("plot1")),
         tabPanel("summary", dataTableOutput("table"))
      )
    )
  )
))
