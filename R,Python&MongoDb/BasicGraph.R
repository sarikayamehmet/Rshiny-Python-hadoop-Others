## importing data from CSV file

plotrRegionPieChart<- read.csv(file.choose(),header = T)

# library to be used to plot chart
library(ggplot2)

#creating a group from dataset i.e measuring factor

tableRegionPieChart <- ggplot(plotrRegionPieChart,aes 
               (x = factor(1),fill = factor(plotrRegionPieChart$terminatingState)
                   )) + geom_bar (width = 1)

# plotting the pie chart
pie <-  tableRegionPieChart + coord_polar(theta = "y")

# plotting the bar plot

plotBarGraph<-ggplot(data = plotrRegionPieChart,
                     aes(x = terminatingState))+
  geom_bar(stat = "count") 

# incline the x axis
 plotBarGraph + 
   theme(axis.text.x = element_text(angle = 20, hjust =1 , vjust = 0.3))
 
 # Plotting graph for time
 dataRelaedTime <- read.csv(file.choose(),header = T)

 dataRelatedTimeCheck <- dataRelaedTime[, c("time")]
 
 table(dataRelatedTimeCheck)

 plotBarGraphTime <- ggplot(data = dataRelaedTime , aes(x = time))+ geom_bar(stat = "count")



a<- read.csv(file.choose(),header = T )
table(a$time)
time.dataframe <-as.data.frame(table(a$time))
