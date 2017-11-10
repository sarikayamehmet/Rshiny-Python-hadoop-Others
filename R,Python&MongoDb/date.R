
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$dateText  <- renderText({
    
    mydate <- factor("9/07/2017 0:00:00")
    date<-as.Date(mydate, format = "%d/%m/%Y")
   if(date >input$dateRange[1] & date < input$dateRange[2]){
    
      paste("working Fine",date,input$dateRange[1])
   }else{
     paste("not working" ,date,input$dateRange[1],input$dateRange[2])
   }
  })

})
