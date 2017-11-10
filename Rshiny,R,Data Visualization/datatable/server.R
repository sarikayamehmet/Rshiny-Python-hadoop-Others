
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


shinyServer(function(input, output) {

  
  tab1<-read.csv("tab1.csv",header = T)
  tab2<-read.csv("tab2.csv",header = T)
  tab3<-read.csv("tab3.csv",header = T)
  tab4<-read.csv("tab4.csv",header = T)
  tab5<-read.csv("tab5.csv",header = T)
  tab6<-read.csv("tab6.csv",header = T)
  
  
  
  dataFormatFinal<-rbind(tab1,tab2,tab3,tab4,tab5,tab6)
  
  dataFormatFinal <- subset(dataFormatFinal, select = c(iUserId,day,time,Hour,iAllotedVMN,date))
  dataFormatFinal$date <- as.Date(dataFormatFinal$date , format = "yyyy/mm/dd") 
    
  #dataFormatFinalJune1<-dataFormatFinal[which(dataFormatFinal$day == 1 ),]
  "dataFormatFinalJune1<-dataFormatFinal[which(dataFormatFinal$day == input$day),]
  dataFormatAisa <- dataFormatFinalJune1 [1:15,]"
  
  output$table <- renderDataTable({
    
    #dataFormatFinalJune1<-dataFormatFinal[which(dataFormatFinal$day == input$day ),]
    
    dataFormatFinalHour<- dataFormatFinal[which(  # dataFormatFinal$day == input$day 
                                               #&
                                                 dataFormatFinal$Hour == input$hour
                                               & dataFormatFinal$iAllotedVMN == input$VMN
                                               & dataFormatFinal$iUserId == input$userId
                                               & dataFormatFinal$dtTime == input$slider_datetime
                                               & as.Date(input$dates[2],format = "yyyy-mm-dd" ) >= dataFormatFinal$date 
                                               & as.Date(input$dates[1], format = "yyyy-mm-dd") <= dataFormatFinal$date 
                                               ),]
    


  })

})
