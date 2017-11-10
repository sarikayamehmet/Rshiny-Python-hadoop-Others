
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
#library(mongolite)
shinyServer(function(input, output,session) {
terCirc = read.csv("C:/Users/Aman Kumar/Documents/dashboard/EVRMAIN/look-up-table/lookupTable.csv",
                   header = T)
 # EVR_MAIN <- mongo(collection = "EVR_MAIN",db = "test")


observe({
  y <- unique(terCirc$operator_circle)
  updateSelectInput(session,"terminating_circle",label = "Terminating Circle",choices = y,
                    selected = "Mumbai")
})
  output$distPlot <- renderPlot({
     getting_the_data <- EVR_MAIN$find('{"MAP_MESSAGE_ID" :"004016071723580801727114",
                                       "RECORDTYPE":"23"}')

  })
 

})
