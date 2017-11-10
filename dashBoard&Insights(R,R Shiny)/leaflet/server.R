
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(htmltools)
library(ggmap)
library(RMySQL)

shinyServer(function(input, output,session) {
 
  "mydb = dbConnect(MySQL(), user='root', password='d@em0n51',
                   dbname='parser', host='localhost')
  dbListTables(mydb)
  dbListFields(mydb, 'master_copy')"
  
  #rs = dbSendQuery(mydb, "select * from master_copy")
  
  "data.frame <- fetch(rs , n = 1000)
  origAddress<- data.frame"
   
  origAddress <- read.csv("master_10000.csv",header = T)
  b<-table(origAddress$terminatingCircle,origAddress$terminatingOperator)
  bn<-as.data.frame(b)
  
  bn<-aggregate(bn$Freq, by=list(Category=bn$Var1), FUN=sum)
  colnames(bn)<- c("terminatingCircle","DeliveryCount")
  origAddress<-bn
  
  for (i in 1:nrow(origAddress )){
    result <- geocode(as.character(origAddress$terminatingCircle[i]),output = "latlona", source = "google")
    origAddress$long[i] <- as.numeric(result[1])
    origAddress$lat[i] <- as.numeric(result[2])
    }
   origAddress$lat<-as.numeric(as.character(origAddress$lat))
   origAddress$long<- as.numeric(as.character(origAddress$long))
   
  colnames(origAddress)<- c("terminatingCircle","DeliveryCount","long","lat")
  origAddress<-origAddress[complete.cases(origAddress),]
    

    origAddress<-origAddress[-c(22,23,16),]
    
    output$mymap <- renderLeaflet({
    m <-leaflet(origAddress) %>% addTiles() %>%
      addMarkers(~long , ~lat,label = " message delivered",popup = ~ htmlEscape(as.character(DeliveryCount))) 
     
      m
  })
    #,label = as.character( origAddress$DeliveryCount)
})
