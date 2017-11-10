
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(data.table)
library(dplyr)
library(ggplot2)
library(lubridate)
library(stringr)
library(rebus)

shinyServer(function(input, output,session) {
  
  lookuptable <- read.csv("operator/lookupTable.csv",header = T)
  #sr_main1<- read.csv("EVRDATA/SR_MAIN_1.csv",header = T)
  sr_main1 <- read.table("EVRDATA/EVR_SR_MAIN_201706012357293.txt",sep =",",dec = ".")
  colnames(sr_main1)<-c("SCTS","SCMSGREF","SRORIGADDR","SRDESTADDR","MSGID","SR_SCTS",
                        "SM_STATUS","SM_ERRCODE","CAUSE","EVENT","ACCESSMETHOD","DIALLED_NUM",
                        "LOGGINGTIME","NODE_ID","MAP_MESSAGE_ID") 
  
 # sr_main1$LOGGINGTIME<-substr(sr_main1$LOGGINGTIME,1,8)
  sr_main2 <- read.table("EVRDATA/EVR_SR_MAIN_201706012357594.txt",sep=",",dec = ".")
  colnames(sr_main2)<-c("SCTS","SCMSGREF","SRORIGADDR","SRDESTADDR","MSGID","SR_SCTS",
                        "SM_STATUS","SM_ERRCODE","CAUSE","EVENT","ACCESSMETHOD","DIALLED_NUM",
                        "LOGGINGTIME","NODE_ID","MAP_MESSAGE_ID") 
  
  
 # sr_main2$LOGGINGTIME<-substr(sr_main2$LOGGINGTIME,1,8)
  sr_main <- rbind (sr_main1 ,sr_main2)
  timeVar <- sr_main$LOGGINGTIME
  sr_main$Hour <-str_sub(timeVar,start = 9 ,end = -7)
  sr_main$minute <- str_sub(timeVar, start = 11, end =-5)
  sr_main$second <- str_sub (timeVar,start = 13 , end = -3)
  sr_main$millisec <- str_sub(timeVar,start = 15 , end = -1 )
  
  #sr_main$hour <- str_sub(sr_main$LOGGINGTIME,)
  #sr_main$minute <- str_sub(sr_main$LOGGINGTIME,-8)
  sr_main$LOGGINGTIME<-substr(sr_main$LOGGINGTIME,1,8)
  
  sr_main$LOGGINGTIME<-ymd(sr_main$LOGGINGTIME)
  
  sm_detail1 <- read.table("EVRDATA/EVR_SM_DETAIL_201706012357293.txt",sep = ",",dec = ".")
  colnames(sm_detail1)<- c("SCTS","SCMSGREF","RECORDTYPE","CAUSE","EVENT",
                          "LOGGINGTIME","DEST_IMSI","DEST_VMSCADDR","NUMOFDELATTEMPTS",
                          "ACCESSMETHOD","SMORIGADDR","APP_NUM","SMDESTADDR","ROUTING_TYPE"
                          ,"NODE_ID","MAP_MESSAGE_ID")
  
  sm_detail2 <- read.table("EVRDATA/EVR_SM_DETAIL_201706012357594.txt",sep = ",",dec = ".")
  colnames(sm_detail2)<- c("SCTS","SCMSGREF","RECORDTYPE","CAUSE","EVENT",
                           "LOGGINGTIME","DEST_IMSI","DEST_VMSCADDR","NUMOFDELATTEMPTS",
                           "ACCESSMETHOD","SMORIGADDR","APP_NUM","SMDESTADDR","ROUTING_TYPE"
                           ,"NODE_ID","MAP_MESSAGE_ID")
  sm_detail <- rbind(sm_detail1,sm_detail2)
  sr_main <- sr_main[ ,c("MAP_MESSAGE_ID","SM_STATUS","SM_ERRCODE","LOGGINGTIME","Hour","minute"
                         ,"second","millisec")]
  sm_detail <- sm_detail[,c("MAP_MESSAGE_ID","CAUSE","RECORDTYPE","EVENT","DEST_VMSCADDR")]
  mergSRMainSMDetail <- merge(sr_main,sm_detail, by = c("MAP_MESSAGE_ID"))
  
  #  m <- merge(mergSRMainSMDetail,sm_main,by =  c ("MAP_MESSAGE_ID"))
  #mergSRMainSMDetail$DEST_VMSCADDR <- floor (mergSRMainSMDetail$DEST_VMSCADDR/100000)
  
  a <- mergSRMainSMDetail
  #a$DEST_VMSCADDR<- as.character(a$DEST_VMSCADDR)
  b<-  lookuptable
  #b$vmsc_no<- as.character(b$vmsc_no)
  a<-as.data.frame(a)
  b<- as.data.frame(b)
  
  colnames(a)
  colnames(b)
   
  df1<- as.data.frame(a)
  df1 <- df1[complete.cases(df1),]
  df2<- as.data.frame(b)
  
  df2 <- df2[complete.cases(df2),]
  
  names(df1) [names(df1)=='DEST_VMSCADDR'] <- 'Vmsc'
  names(df2)[names(df2)=='vmsc_no'] <- 'vmsc'
  colnames(df1)
  colnames(df2)
  
  df3<-df1 %>%
    # USE str_extract  to get vmsc matched in df2
    mutate(Vmsc = str_extract(string = formatC(Vmsc, 
                                               digits = 0, 
                                               format = "f"), 
                              pattern = or1(df2$vmsc))) %>%
    # Join with df2 by the updated vmsc
    left_join(df2 %>% 
                mutate(Vmsc = as.character(vmsc)) %>%
                select(-vmsc), 
              by = "Vmsc")
  
  
  
  
  options(scipen = 999)
  observe({
   y<- unique(lookuptable$operator_circle)
  updateSelectInput(session ,"circle",label = "select the operator",
  choices = y,selected = "Gujarat")
  })
  output$plot1 <- renderPlot({
    df3 <- df3[which(df3$operator_circle==input$circle
                     & df3$SM_STATUS ==  input$msgType
                     & df3$LOGGINGTIME >= input$dateRange[1] 
                     & df3$LOGGINGTIME <= input$dateRange[2]
                     ),]
    g<- ggplot(df3 %>% count(operator_name, operator_circle) %>%   
                 # Group by region and species, then count number in each group
                 mutate(pct=n/sum(n),               # Calculate percent within each region
                xypos = cumsum(n) - 0.5*n),  # Calculate label positions
               aes(operator_name, n, fill=operator_circle)) +
      geom_bar(stat="identity", width = 0.2) + coord_flip() +
      geom_text(aes(label=n),  vjust=-1.1) + ggtitle("Message Status")
    g
  })
  output$table <- renderDataTable({
   # mergSRMainSMDetail
    #df3 <- unique(df3[which(df3$operator_circle==input$circle
            #         & df3$SM_STATUS == "UNDELIV"),]
    df3 <- df3[which(
                   df3$operator_circle==input$circle &
                              df3$LOGGINGTIME >= input$dateRange[1] 
                            & df3$LOGGINGTIME <= input$dateRange[2]
    ),]
    colnames(df3)[4]<- "Time(YYYY-mm-dd)"
    df3<- (df3)
  })

})
