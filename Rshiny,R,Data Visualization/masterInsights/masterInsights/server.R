
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(RMySQL)
library(ggplot2)
library(dplyr)



shinyServer(function(input, output,session) {

  #mydb = dbConnect(MySQL(), user='root', password='d@em0n51',
   #                dbname='parser', host='localhost')
  #rs = dbSendQuery(mydb, "select * from master_copy")
  #data.frame <- fetch(rs , n = 124359)
  data.frame<-read.csv("master_10000.csv",header = T)
  
  datsetFrame <- data.frame[c("terminatingOperator","terminatingCircle","procDate")]
  
  datsetFrame$procDate = as.Date(datsetFrame$procDate)
  
  observe({
    
    y<- unique(datsetFrame$terminatingOperator)
    
    updateSelectInput(session,"terminatingOperator",label = "Select the Terminating Operator",choices = y,
                      selected = "MTNL")
    })
  
  observe({
    
    x<- unique(datsetFrame$terminatingCircle)
    
    updateSelectInput(session,"terminatingCircle",label = "Select the Terminating Circle",choices =x,
                      selected = "Mumbai")
  })
  
   
  
  
  output$distPlot <- renderPlot({
    
    datsetFrame <- datsetFrame[which(#datsetFrame$terminatingOperator == input$terminatingOperator 
                                      datsetFrame$terminatingCircle == input$terminatingCircle
                                   # & datsetFrame$procDate <= as.Date(input$dateRangeID[2])
                                    #& datsetFrame$procDate >= as.Date(input$dateRangeID[1])
                                     ),]
    ###
    
    g<- ggplot(datsetFrame %>% count(terminatingOperator, terminatingCircle) %>%    # Group by region and species, then count number in each group
             mutate(pct=n/sum(n),               # Calculate percent within each region
                    ypos = cumsum(n) - 0.5*n),  # Calculate label positions
           aes(terminatingOperator, n, fill=terminatingCircle)) +
      geom_bar(stat="identity", width = 0.2) + coord_flip() +
    geom_text(aes(label=n),  vjust=-1.1)
    
    
    
     # geom_text(aes(label=paste0(sprintf("%1.1f", pct*100),"%"), y=ypos))
      g
  })

})
