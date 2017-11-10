library(RMySQL)
mydb = dbConnect(MySQL(), user='root', password='d@em0n51',
                 dbname='parser', host='localhost')
dbListTables(mydb)
dbListFields(mydb, 'master_copy')

rs = dbSendQuery(mydb, "select * from master_copy")

data.frame <- fetch(rs , n = 12435696)

datsetFrame <- data.frame[c("terminatingOperator","terminatingCircle","procDate")]




