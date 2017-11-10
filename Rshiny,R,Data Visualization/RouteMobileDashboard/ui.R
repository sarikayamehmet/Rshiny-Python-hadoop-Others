library(shiny)
library(leaflet)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Dashboard"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel( width = 3 ,
      selectInput("senderId",label = "select the SenderID", choices = list("DM-BOISTR","DM-ICICIL","All"),
                  selected = "DM-BOISTR") ,
    selectInput("interval","Refresh interval",choices = c(
      "30 seconds" = 30,
      "1 minute " =  60,
      "2 minute " = 120,
      "5 minute " = 300,
      "10 minute"  = 600
    ),
    selected = "600"
    ),
      selectInput(inputId = "terminatingCircle", label = "Select the Terminating Circle",
                  choices = c("Delhi","Mumbai","All")),
      
      dateRangeInput(inputId ="dateRangeID",label = "Date",format = "yyyy-mm-dd"),
         actionButton("refresh","Refresh Now")
    ),
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("MAP(Message delivered state wise)",leafletOutput("mymap")),
        tabPanel(" Message delivered in Terminating Circle ",downloadButton(outputId = "down1", label = "Download "),plotOutput("plot1")#,downloadButton(outputId = "down1", label = "Download ")
                 ),
        tabPanel("Sender's message delivered",downloadButton(outputId = "down2", label = "Download "),plotOutput("plot3")# ,downloadButton(outputId ="down1", label = "Download ")
                 ),
        tabPanel("msgType used by sender",downloadButton(outputId = "down3", label = "Download "),plotOutput("plot4") #,downloadButton(outputId = "down2",label = "Download ")
                 ),
        tabPanel("Terminating circle Analysis",downloadButton(outputId = "down4", label = "Download "),plotOutput("plot2")# ,downloadButton(outputId = "down3",label = "Download ")
                 ), 
        tabPanel("summary", dataTableOutput("table"))
      )
    )
  )
)
)

