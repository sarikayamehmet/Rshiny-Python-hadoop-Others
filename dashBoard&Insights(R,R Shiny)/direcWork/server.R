
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  get_new_data <- function(){
    library(data.table)  
    files <- list.files(path = "C:/Users/Aman Kumar/Documents/direcWork/data",
                        pattern = ".csv",full.names = TRUE)
    files_factor <- as.factor(files)
    temp <- lapply(files, fread, sep=",")
    data <- rbindlist( temp )
    a =0 
    a = 1 
    return(data)
  }
  
  my_data <<- get_new_data()
  
  
  update_data <-  function(){
    my_data <-get_new_data()
    return(my_data)
    
  }
  

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})
