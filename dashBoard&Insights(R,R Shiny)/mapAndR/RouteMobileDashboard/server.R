
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(RMySQL)
library(ggplot2)
library(leaflet)
library(htmltools)
library(ggmap)
library(dplyr)




"getDbData<- function(){
  mydb = dbConnect(MySQL(),user = 'root' , password = 'd@em0n51',
                   dbname = 'parser' , host = 'localhost')"
  #rs = dbSendQuery(mydb ,"select * from master_copy ")
  "data.frame <- fetch(rs ,n = 12435696)
  return(data.frame)
}"

shinyServer(function(input, output,session) {
  
  ### Iniiaize my data
  
  #data.frame <<-getDbData()
  
  
  #mydb = dbConnect(MySQL(),user= 'root',password = 'd@em0n51',
   #                dbname = 'parser',host = 'localhost')
  
  #rs = dbSendQuery(mydb, "select * from master_copy")
  
  #data.frame <- fetch(rs , n = 124)
  a<-read.csv("master_10000.csv",header = T)
 # a<-a[1:500,]
  data.frame<-a
  datasetFrame <- a
  
  #data frame for map data
  
  b<-table(data.frame$terminatingCircle,data.frame$terminatingOperator)
  bn <- as.data.frame(b)
  bn<-aggregate(bn$Freq, by=list(Category=bn$Var1), FUN=sum)
  colnames(bn)<- c("terminatingCircle","DeliveryCount")
  origAddress<-bn
  

  # end of map data data subsetting
  
  #### getting the data for missed call 
  tab1<-read.csv("tab1.csv",header = T)
  tab2<-read.csv("tab2.csv",header = T)
  tab3<-read.csv("tab3.csv",header = T)
  tab4<-read.csv("tab4.csv",header = T)
  tab5<-read.csv("tab5.csv",header = T)
  tab6<-read.csv("tab6.csv",header = T)
  
  dataFormatFinal<-rbind(tab1,tab2,tab3,tab4,tab5,tab6)
  
  dataFormatFinal <- subset(dataFormatFinal, 
     select = c(iUserId,day,time,Hour,iAllotedVMN,date))
  
  
  # updating the select Input and VMN
  observe({
    x<-unique(dataFormatFinal$iAllotedVMN)
    updateSelectInput(session,"vmn",label = "Select the VMN",choices =x,
                      selected = "9222281818")
  })
  observe({
    y<-unique(dataFormatFinal$iUserId)
    updateSelectInput(session ,"userId",label = "select the USERID",
                      choices = y,selected = "950")
  })
  observe({
    
    x<- unique(datsetFrame$terminatingCircle)
    
    updateSelectInput(session,"terminatingCircle",label = "Select the Terminating Circle",choices =x,
                      selected = "Mumbai")
  })
  
 
  output$plot1 <- renderPlot({
    
    dataFormatFinal<-dataFormatFinal[which( dataFormatFinal$iAllotedVMN == input$vmn),]
    
    withProgress(message = 'Calculation in progress',
                 detail = 'This may take a while...', value = 0, {
                   for (i in 1:15) {
                     incProgress(1/15)
                     Sys.sleep(0.25)
                   }
                 })
    june1<-ggplot(dataFormatFinal, aes(Hour) ) +
      geom_bar() +  ggtitle(paste("MISSED CALL PER HOUR :June",input$day))+ geom_text(stat='count',aes(label=..count..),vjust=-1)
    june1 <- june1 + scale_x_discrete(name = "Hour",limits = c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"
                                                               ,"16","17","18","19","20","21","22","23"))
    june1
    
    
  })
  output$mymap<- renderLeaflet({
    withProgress(message = 'Calculation in progress',
                 detail = 'This may take a while...', value = 0, {
                   for (i in 1:15) {
                     incProgress(1/15)
                     Sys.sleep(0.25)
                   }
                 })
    
    for (i in 1:nrow(origAddress )){
      result <- geocode(as.character(origAddress$terminatingCircle[i]),output = "latlona", source = "google")
      origAddress$long[i] <- as.numeric(result[1])
      origAddress$lat[i] <- as.numeric(result[2])
    }
    withProgress(message = 'Calculation in progress',
                 detail = 'This may take a while...', value = 0, {
                   for (i in 1:15) {
                     incProgress(1/15)
                     Sys.sleep(0.25)
                   }
                 })
    
    origAddress$lat<-as.numeric(as.character(origAddress$lat))
    origAddress$long<- as.numeric(as.character(origAddress$long))
    colnames(origAddress)<- c("terminatingCircle","DeliveryCount","long","lat")
    leeafletData<-origAddress[complete.cases(origAddress),]
  
    m<-leaflet(leeafletData) %>% addTiles() %>%
      addMarkers(~long,~lat,label = "No of message delivered",popup = ~htmlEscape(
        as.character(DeliveryCount)
      ))
    withProgress(message = 'Calculation in progress',
                 detail = 'This may take a while...', value = 0, {
                   for (i in 1:15) {
                     incProgress(1/15)
                     Sys.sleep(1.25)
                   }
                 })
    m
  })
  
  output$table <- renderDataTable({
    
    dataFormatFinalHour<- dataFormatFinal[which(
      dataFormatFinal$iAllotedVMN == input$vmn & dataFormatFinal$iUserId == input$userId
    ),]
    dataFormatFinalHour
    })
  
  output$plot2<- renderPlot({
    
   # datsetFrame<-data.frame
    datsetFrame <- a[c("terminatingOperator","terminatingCircle","procDate")]
    datsetFrame$procDate = as.Date(datsetFrame$procDate)
    datsetFrame <- datsetFrame[which(#datsetFrame$terminatingOperator == input$terminatingOperator 
    datsetFrame$terminatingCircle == input$terminatingCircle
    #& datsetFrame$procDate <= as.Date(input$dateRangeID[2])
    #& datsetFrame$procDate >= as.Date(input$dateRangeID[1])
    ),]
    ###
    withProgress(message = 'Calculation in progress',
                 detail = 'This may take a while...', value = 0, {
                   for (i in 1:15) {
                     incProgress(1/15)
                     Sys.sleep(0.25)
                   }
                 })
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