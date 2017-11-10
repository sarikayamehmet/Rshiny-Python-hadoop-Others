
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(data.table)
library(dplyr)
shinyServer(function(input, output,session) {
sm_main_detail1<-read.csv("evr_data/EVR_SM_DETAIL_201706012357293.csv",header = T)
sm_main_detail2<-read.csv("evr_data/EVR_SM_DETAIL_201706012357594.csv",header = T) 
sm_mainDetail <- rbind(sm_main_detail1,sm_main_detail2)
#write.csv(sm_mainDetail,"mainDetail.csv")
sr_main1<- read.csv("evr_data/EVR_SR_MAIN_201706012357293.csv",header = T)
sr_main2 <- read.csv("evr_data/EVR_SR_MAIN_201706012357594.csv",header = T)
sr_main <- rbind (sr_main1 ,sr_main2)
#write.csv(sr_main ,"sr_main.csv")
sm_detail1 <- read.csv("evr_data/EVR_SM_DETAIL_201706012357293.csv",header = T)
sm_detail2 <- read.csv("evr_data/EVR_SM_DETAIL_201706012357594.csv",header = T)
sm_detail <- rbind(sm_detail1,sm_detail2)
#write.csv(sm_detail,"sm_detail.csv")
sm_mainDetail<-sm_mainDetail[ ,c("MAP_MESSAGE_ID","DEST_VMSCADDR")]
sr_main <- sr_main[ ,c("MAP_MESSAGE_ID","SM_STATUS","SM_ERRCODE")]
sm_detail <- sm_detail[,c("MAP_MESSAGE_ID","CAUSE","RECORDTYPE","EVENT")]
mergSRMainSMDetail <- merge(sm_mainDetail,sm_detail, by = c("MAP_MESSAGE_ID"))
mergewithSmMAIN <- merge (mergSRMainSMDetail, sr_main, by = c("MAP_MESSAGE_ID"))
#mergeDatawithSR <- merge (mergingSMDetailMain,sr_main , by = c("MAP_MESSAGE_ID"))
mergeDatawithSR <- as.data.frame(mergSRMainSMDetail)

})
