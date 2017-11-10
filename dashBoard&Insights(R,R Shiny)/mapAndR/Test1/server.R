library(leaflet)

hotels <- read.table(text = "Hotel Year  latitude        longitude
                     A   2000  41.886337      -87.628472
                     B   2005  41.88819       -87.635199
                     C   2010  41.891113      -87.63301", 
                     header = TRUE)

shinyServer(function(input, output) {
  
  output$map <- renderLeaflet({
    df <- hotels[hotels$Year == input$year,]  
    leaflet()  %>%
      addTiles() %>%
      addMarkers(data = df)
  })
  
})