
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  options(scipen = 999)
  
  get_SmMain_data<- function(){
  
    sm_main1 <- read.table("EVRDATA/EVR_SM_MAIN_201706012357293.txt",sep = ",",dec = ",")
    colnames(sm_main1) <- c("SCTS","SCMSGREF","RECORDTYPE","CAUSE","EVENT","LOGGINGTIME",
                            "ACCESSMETHOD","SMORIGADDR","SMDESTADDR","DISPLAYADDRVALUE","ORIGADDR_TYPE","DESTADDR_TYPE",
                            "ORIG_IMSI","ORIG_VMSC","MSG_LEN","PID","DCS","DSR_REQ","PRIORITY"
                            ,"CONCAT_INFO","CLIENT_ID","SUBS_TYPE","APP_NUM","VALIDITY_PERIOD"
                            ,"DIALLED_NUM","ROUTING_TYPE","NODE_ID","MAP_MESSAGE_ID")
    sm_main2 <- read.table("EVRDATA/EVR_SM_MAIN_201706012357594.txt",sep = ",",dec = ",")
    colnames(sm_main2)<- c("SCTS","SCMSGREF","RECORDTYPE","CAUSE","EVENT","LOGGINGTIME",
                           "ACCESSMETHOD","SMORIGADDR","SMDESTADDR","DISPLAYADDRVALUE","ORIGADDR_TYPE","DESTADDR_TYPE",
                           "ORIG_IMSI","ORIG_VMSC","MSG_LEN","PID","DCS","DSR_REQ","PRIORITY"
                           ,"CONCAT_INFO","CLIENT_ID","SUBS_TYPE","APP_NUM","VALIDITY_PERIOD"
                           ,"DIALLED_NUM","ROUTING_TYPE","NODE_ID","MAP_MESSAGE_ID")
    
    sm_main <- rbind(sm_main1,sm_main2)
   return(sm_main)
     
  }
  
  get_SmDetail_data <- function(){
    sm_detail1 <- read.table("EVRDATA/EVR_SM_DETAIL_201706012357293.txt",sep = ",",dec = ".")
    colnames(sm_detail1) <- c("SCTS","SCMSGREF","RECORDTYPE","CAUSE","EVENT",
                              "LOGGINGTIME","DEST_IMSI","DEST_VMSCADDR","NUMOFDELATTEMPTS",
                              "ACCESSMETHOD","SMORIGADDR","APP_NUM","SMDESTADDR","ROUTING_TYPE"
                              ,"NODE_ID","MAP_MESSAGE_ID")
    
    sm_detail2<- read.table("EVRDATA/EVR_SM_DETAIL_201706012357594.txt",sep = ",",dec = ".")
    colnames(sm_detail2)<-  c("SCTS","SCMSGREF","RECORDTYPE","CAUSE","EVENT",
                              "LOGGINGTIME","DEST_IMSI","DEST_VMSCADDR","NUMOFDELATTEMPTS",
                              "ACCESSMETHOD","SMORIGADDR","APP_NUM","SMDESTADDR","ROUTING_TYPE"
                              ,"NODE_ID","MAP_MESSAGE_ID")
    
    sm_detail <- rbind(sm_detail1,sm_detail2)
     sm_detail[which(sm_detail$CAUSE == 161 ),] <- "ERR_VAL_ASE_SC_NO_SUBS"
     sm_detail[which(sm_detail$CAUSE == 163 ),] <- "ERR_VAL_ASE_INV_SME_ADDR"
     sm_detail[which(sm_detail$CAUSE == 164 ),] <- "ERR_VAL_ASE_DEST_SME_BARRED"
     sm_detail[which(sm_detail$CAUSE == 165 ),] <- "ERR_VAL_ASE_DUP_SM_REJECTED"
     sm_detail[which(sm_detail$CAUSE == 193 ),] <- "ERR_VAL_GSM_SC_NO_SUBS "
     sm_detail[which(sm_detail$CAUSE == 195 ),] <- "ERR_VAL_GSM_INV_SME_ADDR "
     sm_detail[which(sm_detail$CAUSE == 196 ),] <- "ERR_VAL_GSM_DEST_SME_BARRED "
     sm_detail[which(sm_detail$CAUSE == 197 ),] <- "ERR_VAL_GSM_DUP_SM_REJECTED "
     sm_detail[which(sm_detail$CAUSE == 256 ),] <- "ERR_OK "
     sm_detail[which(sm_detail$CAUSE == 257 ),] <- "ERR_TL_LIB_DECODE"
     sm_detail[which(sm_detail$CAUSE == 258 ),] <- "ERR_TL_LIB_ENCODE"
     sm_detail[which(sm_detail$CAUSE == 259 ),] <- "ERR_MSGTYPE_NOT_SUPPORTED"
     sm_detail[which(sm_detail$CAUSE == 260 ),] <-  "ERR_CMD_ACTION_OK"
     sm_detail[which(sm_detail$CAUSE == 261 ),] <- "ERR_RL_PROTOCOL"
     sm_detail[which(sm_detail$CAUSE == 262 ),] <- "ERR_RL_RSP_TIMEOUT"
     sm_detail[which(sm_detail$CAUSE == 263 ),] <- "ERR_RL_UNKNOWN"
     sm_detail[which(sm_detail$CAUSE == 264 ),] <- "ERR_VP_OVER"
     sm_detail[which(sm_detail$CAUSE == 265 ),] <- "ERR_TIMER_FAIL"
     sm_detail[which(sm_detail$CAUSE == 266 ),] <- "ERR_SESSION_PRESENT"
     sm_detail[which(sm_detail$CAUSE == 267 ),] <- "ERR_SESSION_NOT_PRESENT"
     sm_detail[which(sm_detail$CAUSE == 268 ),] <- "ERR_OK_DELIVER_ACK"
     sm_detail[which(sm_detail$CAUSE == 269 ),] <- "ERR_OK_RL_ERROR"
     sm_detail[which(sm_detail$CAUSE == 270 ),] <- "ERR_OK_DEST_TIMEOUT"
     sm_detail[which(sm_detail$CAUSE == 271 ),] <- "ERR_OK_PERMANENT_ERROR"
     sm_detail[which(sm_detail$CAUSE == 272 ),] <- "ERR_DB_FAIL"
     sm_detail[which(sm_detail$CAUSE == 273 ),] <- "ERR_SMT_FAIL"
     sm_detail[which(sm_detail$CAUSE == 274 ),] <- "ERR_VAL_FAIL"
     sm_detail[which(sm_detail$CAUSE == 275 ),] <- "ERR_WRITE_MSGQ_FAIL"
     sm_detail[which(sm_detail$CAUSE == 276 ),] <- "ERR_TIMESTAMP_VAL"
     sm_detail[which(sm_detail$CAUSE == 277 ),] <- "ERR_MSG_ALREADY_DISPATCHED"
     sm_detail[which(sm_detail$CAUSE == 278 ),] <- "ERR_INFO_ELMNT_DECODE"
     sm_detail[which(sm_detail$CAUSE == 279 ),] <- "RCVD_DELETE_CMD"
     sm_detail[which(sm_detail$CAUSE == 280 ),] <- "ERR_DELIVER_NACK"
     sm_detail[which(sm_detail$CAUSE == 281 ),] <- "ERR_NONGUARANTEED_MSG"
     sm_detail[which(sm_detail$CAUSE == 282 ),] <- "ERR_MSG_TIMEOUT"
     sm_detail[which(sm_detail$CAUSE == 283 ),] <- "ERR_THROTTLING_CONGESTION"
     sm_detail[which(sm_detail$CAUSE == 284 ),] <- "ERR_DELETED_BY_OPERATOR"
     sm_detail[which(sm_detail$CAUSE == 285 ),] <- "ERR_MAX_NO_OF_ATMPT_REACHED"
     sm_detail[which(sm_detail$CAUSE == 286 ),] <- "ERR_SPOOF_DETECTED"
     sm_detail[which(sm_detail$CAUSE == 287 ),] <- "ERR_CGW_TIME_OUT"
     sm_detail[which(sm_detail$CAUSE == 288 ),] <- "ERR_CGW_INSUFFICIENT_BALANCE"
     sm_detail[which(sm_detail$CAUSE == 289 ),] <- "ERR_CGW_INVALID_AMOUNT"
     sm_detail[which(sm_detail$CAUSE == 290 ),] <- "ERR_CGW_INVALID_MSISDN"
     sm_detail[which(sm_detail$CAUSE == 291 ),] <- "ERR_CGW_GEN_FAILURE"
     sm_detail[which(sm_detail$CAUSE == 292 ),] <- "ERR_CGW_RESTRICTED_MSISDN"
     sm_detail[which(sm_detail$CAUSE == 293 ),] <- "ERR_CGW_NO_SUBSCRIBER_FOUND"
     sm_detail[which(sm_detail$CAUSE == 294 ),] <- "ERR_CGW_INVALID_OPERATION"
     sm_detail[which(sm_detail$CAUSE == 295 ),] <- "ERR_CGW_INVALID_INTERFACE"
     sm_detail[which(sm_detail$CAUSE == 296 ),] <- "ERR_CGW_CAUGHT_EXCEPTION"
     sm_detail[which(sm_detail$CAUSE == 297 ),] <- "ERR_CGW_INTERFACE_NOT_RUNNING"
     sm_detail[which(sm_detail$CAUSE == 298 ),] <- "ERR_CGW_OPERATION_NOT_SUPPORTED"
     sm_detail[which(sm_detail$CAUSE == 299 ),] <- "ERR_CGW_IN_OVERLOAD"
     sm_detail[which(sm_detail$CAUSE == 300 ),] <- "ERR_CGW_UNKNOWN_ERROR"
     sm_detail[which(sm_detail$CAUSE == 301 ),] <- "EVR_REDIRECTED_TO_APP"
     sm_detail[which(sm_detail$CAUSE == 302 ),] <- "EVR_PARENTAL_CHECK_FAIL"
     sm_detail[which(sm_detail$CAUSE == 303 ),] <- "EVR_AO_CHARGING_SENT"
     
    return(sm_detail)
  }
  get_SrMain_data <- function(){
   sr_main1 <- read.table("EVRDATA/EVR_SR_MAIN_201706012357293.txt",sep = ",",dec = ".")
   colnames(sr_main1)<-c("SCTS","SCMSGREF","SRORIGADDR","SRDESTADDR","MSGID","SR_SCTS",
                         "SM_STATUS","SM_ERRCODE","CAUSE","EVENT","ACCESSMETHOD","DIALLED_NUM",
                         "LOGGINGTIME","NODE_ID","MAP_MESSAGE_ID") 
   
   sr_main2 <- read.table("EVRDATA/EVR_SR_MAIN_201706012357594.txt",sep = ",",dec = ".")
   colnames(sr_main2)<-c("SCTS","SCMSGREF","SRORIGADDR","SRDESTADDR","MSGID","SR_SCTS",
                         "SM_STATUS","SM_ERRCODE","CAUSE","EVENT","ACCESSMETHOD","DIALLED_NUM",
                         "LOGGINGTIME","NODE_ID","MAP_MESSAGE_ID") 
   
   sr_main  <- rbind(sr_main1,sr_main2)
   return(get_SrMain_data)
  }
  get_SrDetail_data <- function(){
    sr_detail1 <- read.table("EVRDATA/EVR_SR_DETAIL_201706012357293.txt",sep = ",",dec = ".")
    colnames(sr_detail1)<- c("SCTS","SCMSGREF","CAUSE","EVENT","ACCESSMETHOD","SRORIGADDR",
                             "SRDESTADDR","LOGGINGTIME","NODE_ID")
    sr_detail2 <- read.table("EVRDATA/EVR_SR_DETAIL_201706012357594.txt",sep = ",",dec = ".")
    colnames(sr_detail2)<- c("SCTS","SCMSGREF","CAUSE","EVENT","ACCESSMETHOD","SRORIGADDR",
                             "SRDESTADDR","LOGGINGTIME","NODE_ID")
    sr_detail <- rbind(sr_detail1,sr_detail2)
    return(sr_detail)
  }
    
  sm_mainData <-  get_SmMain_data()
  sm_detailData <- get_SmDetail_data()
  sr_detailData <- get_SrDetail_data()
  sr_mainData <- get_SrMain_data()
  
  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})
