library(shiny)
library(RMySQL)
library(ggplot2)
library(leaflet)
library(htmltools)
library(ggmap)
library(dplyr)
library(data.table)
shinyServer(function(input, output,session) {
  get_new_master_data<- function(){
    files <- list.files(path = "master_data",
                        pattern = ".csv",
                        full.names = TRUE)
    files_factor <- as.factor(files)
    temp <- lapply(files, fread, sep=",")
    data <- rbindlist( temp )
    a =0 
    a = 1 
    return(data)
  }
  
  update_data_master_data <- function(){
    
    data.frame <<-get_new_master_data()
  }
  
  
  data.frame<- get_new_master_data()
  datsetFrame <- get_new_master_data()
  latLong_data <- read.csv("lat-long-data/latLong.csv",header = T)
  #data frame for map data
  
  observe({
    
    invalidateLater(60000,session)
    
    b<-table(data.frame$terminatingCircle,data.frame$terminatingOperator)
    bn <- as.data.frame(b)
    bn<-aggregate(bn$Freq, by=list(Category=bn$Var1), FUN=sum)
    colnames(bn)<- c("terminatingCircle","DeliveryCount")
    # origAddress<-bn
    origAddress<-bn
  })
  
  
  #### getting the data for missed call 
  
  get_new_missed_Call_data <- function(){
    files <- list.files(path = "missCallData",
                        pattern = ".csv",
                        full.names = TRUE)
    files_factor <- as.factor(files)
    temp <- lapply(files, fread, sep=",")
    data <- rbindlist( temp )
    a =0 
    a = 1
    
    data <- subset(data, select = c(iUserId,day,time,Hour,iAllotedVMN,date))
    return(data)
    
  }
  update_missed_call_data <- function(){
    dataFormatFinal <- get_new_missed_Call_data()
  }
  
  dataFormatFinal <-get_new_missed_Call_data()
  
  
  observe({
    y<-unique(data.frame$senderId)
    updateSelectInput(session ,"senderId",label = "select the SenderId",
                      choices = append(y,"All"),selected = "DM-BOISTR")
  })
  observe({
    
    x<- unique(datsetFrame$terminatingCircle)
    
    updateSelectInput(session,"terminatingCircle",label = "Select the Terminating Circle",choices = append(x,"All"),
                      selected = "Mumbai")
  })
  
  
  output$plot1 <- renderPlot({
    
    input$refresh # refresh if button is clicked
    
    if(input$terminatingCircle == "All"){
      
      interval <- max(as.numeric(input$interval),30)
      invalidateLater(interval * 1000,session)
      # datsetFrame<-data.frame
      #update_data_master_data()
      datsetFrame<-data.frame
      datsetFrame <- datsetFrame[,c("terminatingOperator","terminatingCircle","procDate","msgType")]
      datsetFrame$procDate = as.Date(datsetFrame$procDate)
      withProgress(message = 'Calculation in progress',
                   detail = 'This may take a while...', value = 0, {
                     for (i in 1:15) {
                       incProgress(1/15)
                       Sys.sleep(0.25)
                     }
                   })
      g<- ggplot(datsetFrame %>% count(terminatingCircle, msgType) %>%    # Group by region and species, then count number in each group
                   mutate(pct=n/sum(n),               # Calculate percent within each region
                          ypos = cumsum(n) - 0.5*n),  # Calculate label positions
                 aes(msgType, n, fill=terminatingCircle)) +
        geom_bar(stat="identity", width = 0.2) + coord_flip() +
        geom_text(aes(label=n),  vjust=-1.1) + labs(y = "Type of message") + ggtitle("Message Type in Terminating Circle (filter <- terminating circle and  Date)")
      
      g
      
      
      
    }else{
      
      #get interval (minimum 30)
      interval <- max(as.numeric(input$interval),30)
      invalidateLater(interval * 1000,session)
      # datsetFrame<-data.frame
      #update_data_master_data()
      datsetFrame<-data.frame
      datsetFrame <- datsetFrame[,c("terminatingOperator","terminatingCircle","procDate","msgType")]
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
      
      
      g<- ggplot(datsetFrame %>% count(terminatingCircle, msgType) %>%    # Group by region and species, then count number in each group
                   mutate(pct=n/sum(n),               # Calculate percent within each region
                          ypos = cumsum(n) - 0.5*n),  # Calculate label positions
                 aes(msgType, n, fill=terminatingCircle)) +
        geom_bar(stat="identity", width = 0.2) + coord_flip() +
        geom_text(aes(label=n),  vjust=-1.1) + labs(y = "Type of message") + ggtitle("Message Type in Terminating Circle (filter <- terminating circle and  Date)")
      
      g
    }
  })
  
  
  output$plot4 <- renderPlot({
    
    if(input$senderId == 'All'){
      input$refresh # refresh if button is clicked
      #get interval (minimum 30)
      interval <- max(as.numeric(input$interval),30)
      invalidateLater(interval * 1000,session)
      # datsetFrame<-data.frame
      #update_data_master_data()
      datsetFrame<-data.frame
      datsetFrame <- datsetFrame[,c("terminatingOperator","terminatingCircle","procDate","msgType","senderId")]
      datsetFrame$procDate = as.Date(datsetFrame$procDate)
      withProgress(message = 'Calculation in progress',
                   detail = 'This may take a while...', value = 0, {
                     for (i in 1:15) {
                       incProgress(1/15)
                       Sys.sleep(0.25)
                     }
                   })
      g<- ggplot(datsetFrame %>% count(senderId, msgType) %>%    # Group by region and species, then count number in each group
                   mutate(pct=n/sum(n),               # Calculate percent within each region
                          ypos = cumsum(n) - 0.5*n),  # Calculate label positions
                 aes(senderId, n, fill=msgType)) +
        geom_bar(stat="identity", width = 0.2) + ggtitle("Types Of Message send by sender (Filter -> senderId and date)")+
        geom_text(aes(label=n),  vjust=-1.1) + labs(y = "Type of message")
      
      g
      
    }else{
      input$refresh # refresh if button is clicked
      #get interval (minimum 30)
      interval <- max(as.numeric(input$interval),30)
      invalidateLater(interval * 1000,session)
      # datsetFrame<-data.frame
      #update_data_master_data()
      datsetFrame<-data.frame
      datsetFrame <- datsetFrame[,c("terminatingOperator","terminatingCircle","procDate","msgType","senderId")]
      datsetFrame$procDate = as.Date(datsetFrame$procDate)
      datsetFrame <- datsetFrame[which(
        datsetFrame$senderId == input$senderId
        #& datsetFrame$procDate <= as.Date(input$dateRangeID[2])
        #& datsetFrame$procDate >= as.Date(input$dateRangeID[1])
      ),]
      
      
      withProgress(message = 'Calculation in progress',
                   detail = 'This may take a while...', value = 0, {
                     for (i in 1:15) {
                       incProgress(1/15)
                       Sys.sleep(0.25)
                     }
                   })
      
      
      g<- ggplot(datsetFrame %>% count(senderId, msgType) %>%    # Group by region and species, then count number in each group
                   mutate(pct=n/sum(n),               # Calculate percent within each region
                          ypos = cumsum(n) - 0.5*n),  # Calculate label positions
                 aes(senderId, n, fill=msgType)) +
        geom_bar(stat="identity", width = 0.2) + ggtitle("Types Of Message send by sender (Filter -> senderId and date)")+
        geom_text(aes(label=n),  vjust=-1.1) + labs(y = "Type of message")
      
      g
    }
  })
  
  
  
  
  
  output$plot3 <- renderPlot({
    
    if (input$senderId == "All"){
      
      input$refresh # refresh if button is clicked
      
      #get interval (minimum 30)
      interval <- max(as.numeric(input$interval),30)
      invalidateLater(interval * 1000,session)
      #datsetFrame<-data.frame
      #update_data_master_data()
      datsetFrame<-data.frame
      datsetFrame <- datsetFrame[,c("terminatingCircle","procDate","senderId")]
      datsetFrame$procDate = as.Date(datsetFrame$procDate)
      
      withProgress(message = 'Calculation in progress',
                   detail = 'This may take a while...', value = 0, {
                     for (i in 1:15) {
                       incProgress(1/15)
                       Sys.sleep(0.25)
                     }
                   })
      
      june1<-ggplot(datsetFrame, aes(senderId) ) +
        geom_bar(stat = "count",width = 0.1) + geom_text(stat='count',aes(label=..count..),vjust=-1) +
        ggtitle("Total Message Delivered (filter->SenderId and date)")
      june1
      
    }else{
      
      
      input$refresh # refresh if button is clicked
      
      #get interval (minimum 30)
      interval <- max(as.numeric(input$interval),30)
      invalidateLater(interval * 1000,session)
      #datsetFrame<-data.frame
      #update_data_master_data()
      datsetFrame<-data.frame
      datsetFrame <- datsetFrame[,c("terminatingCircle","procDate","senderId")]
      datsetFrame$procDate = as.Date(datsetFrame$procDate)
      datsetFrame <- datsetFrame[which(
        datsetFrame$senderId == input$senderId
        #& datsetFrame$procDate <= as.Date(input$dateRangeID[2])
        #& datsetFrame$procDate >= as.Date(input$dateRangeID[1])
      ),]
      
      
      
      withProgress(message = 'Calculation in progress',
                   detail = 'This may take a while...', value = 0, {
                     for (i in 1:15) {
                       incProgress(1/15)
                       Sys.sleep(0.25)
                     }
                   })
      
      june1<-ggplot(datsetFrame, aes(senderId) ) +
        geom_bar(stat = "count",width = 0.1) + geom_text(stat='count',aes(label=..count..),vjust=-1) +
        ggtitle("Total Message Delivered (filter->SenderId and date)")
      june1
      
      
    }
  })
  
  
  
  
  output$mymap<- renderLeaflet({
    input$refresh # refresh if button is clicked
    #get interval (minimum 30)
    interval <- max(as.numeric(input$interval),30)
    invalidateLater(interval * 1000,session)
    update_data_master_data()
    b<-table(data.frame$terminatingCircle,data.frame$terminatingOperator)
    bn <- as.data.frame(b)
    bn<-aggregate(bn$Freq, by=list(Category=bn$Var1), FUN=sum)
    colnames(bn)<- c("terminatingCircle","DeliveryCount")
    # origAddress<-bn
    origAddress<-bn
    withProgress(message = 'Calculation in progress',
                 detail = 'This may take a while...', value = 0, {
                   for (i in 1:15) {
                     incProgress(1/15)
                     Sys.sleep(0.25)
                   }
                 })
    origAddress <- left_join(x = origAddress,y = latLong_data,by = c("terminatingCircle" = "State") )
    
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
                     Sys.sleep(0.25)
                   }
                 })
    m
  })
  
  
  
  
  output$table <- renderDataTable({
    input$refresh # refresh if button is clicked
    
    #get interval (minimum 30)
    interval <- max(as.numeric(input$interval),30)
    invalidateLater(interval * 1000,session)
    
    update_missed_call_data()
    dataFormatFinalHour<- dataFormatFinal[which(
      dataFormatFinal$iAllotedVMN == input$vmn & dataFormatFinal$iUserId == input$userId
    ),]
    dataFormatFinalHour
  })
  
  output$plot2<- renderPlot({
    
    if(input$terminatingCircle == "All"){
      
      input$refresh # refresh if button is clicked
      
      #get interval (minimum 30)
      interval <- max(as.numeric(input$interval),30)
      invalidateLater(interval * 1000,session)
      # datsetFrame<-data.frame
      #update_data_master_data()
      datsetFrame<-data.frame
      datsetFrame <- datsetFrame[,c("terminatingOperator","terminatingCircle","procDate")]
      datsetFrame$procDate = as.Date(datsetFrame$procDate)
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
        geom_text(aes(label=n),  vjust=-1.1) + ggtitle("Message Deivered in particular states(Filter ->Terminating circle and date)")
      g
      
    }else{
      
      input$refresh # refresh if button is clicked
      
      #get interval (minimum 30)
      interval <- max(as.numeric(input$interval),30)
      invalidateLater(interval * 1000,session)
      # datsetFrame<-data.frame
      #update_data_master_data()
      datsetFrame<-data.frame
      datsetFrame <- datsetFrame[,c("terminatingOperator","terminatingCircle","procDate")]
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
        geom_text(aes(label=n),  vjust=-1.1) + ggtitle("Message Deivered in particular states(Filter ->Terminating circle and date)")
      g
    }
  })
})
