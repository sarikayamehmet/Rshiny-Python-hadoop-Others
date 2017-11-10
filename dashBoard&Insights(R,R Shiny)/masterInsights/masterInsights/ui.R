
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Master Table Dashboard"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
     selectInput(inputId = "terminatingOperator", label = "Select the Terminating Operator",
                 choices = c("BSNL","IDEA")
    ),
    selectInput(inputId = "terminatingCircle", label = "Select the Terminating Circle",
                choices = c("Delhi","Mumbai")),
    dateRangeInput(inputId ="dateRangeID",label = "Date",format = "yyyy-mm-dd")
    ),

    # Show a plot of the generated distributioinputn
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
