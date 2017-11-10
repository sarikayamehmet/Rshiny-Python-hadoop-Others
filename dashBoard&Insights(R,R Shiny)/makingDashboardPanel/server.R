
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)



shinyServer(function(input, output,session) {
  
  
  tab1<-read.csv("tab1.csv",header = T)
  tab2<-read.csv("tab2.csv",header = T)
  tab3<-read.csv("tab3.csv",header = T)
  tab4<-read.csv("tab4.csv",header = T)
  tab5<-read.csv("tab5.csv",header = T)
  tab6<-read.csv("tab6.csv",header = T)
  
  
  
  dataFormatFinal<-rbind(tab1,tab2,tab3,tab4,tab5,tab6)
  dataFomatFinal<-rbind(tab1,tab2,tab3,tab4,tab5,tab6)
  
  dataFormatFinal <- subset(dataFormatFinal, select = c(iUserId,day,time,Hour,iAllotedVMN,date))
 # dataFormatFinal$date <- as.Date(dataFormatFinal$date , format = "yyyy/mm/dd") 
  
  #dataFormatFinalJune1<-dataFormatFinal[which(dataFormatFinal$day == 1 ),]
  "dataFormatFinalJune1<-dataFormatFinal[which(dataFormatFinal$day == input$day),]
  dataFormatAisa <- dataFormatFinalJune1 [1:15,]"
  
  observe({
    
    x<- unique(dataFormatFinal$iAllotedVMN)

    updateSelectInput(session,"vmn",label = "Select the VMN",choices =x,
                      selected = "9222281818")
    
    
  })
  
  observe({

    y<-unique(dataFormatFinal$iUserId)
    updateSelectInput(session ,"userId",label = "select the USERID",choices = (y
                                                                                   ), selected = "950")
  })
  
  
  output$plot1 <- renderPlot({
    dataFormatFinal<-dataFormatFinal[which(dataFormatFinal$day == input$day & dataFormatFinal$iAllotedVMN == input$vmn),]
    
    june1<-ggplot(dataFormatFinal, aes(Hour) ) +
      geom_bar() +  ggtitle(paste("MISSED CALL PER HOUR :June",input$day))+ geom_text(stat='count',aes(label=..count..),vjust=-1)
    june1 <- june1 + scale_x_discrete(name = "Hour",limits = c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"
                                                               ,"16","17","18","19","20","21","22","23"))
    june1
    
    
  })
  
  output$table <- renderDataTable({

    dataFormatFinalHour<- dataFomatFinal[which(dataFomatFinal$day == input$day & dataFomatFinal$Hour == input$hour &
                                       dataFomatFinal$iAllotedVMN == input$vmn & dataFomatFinal$iUserId == input$userId
    ),]
    
    dataFormatFinalHour
    
    
  })
  
})
