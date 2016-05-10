#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "bootstrap.css",
                  
  # Application title
  titlePanel("Way Too Early Graphs at History"),
  
  # Sidebar with a slider input for number of bins 
#  sidebarLayout(
    # sidebarPanel(
    #    # sliderInput("bins",
    #    #             "Number of bins:",
    #    #             min = 1,
    #    #             max = 50,
    #    #             value = 30)
    # ),
    
    # Show a plot of the generated distribution
    mainPanel(
         plotlyOutput("winsPlot"),
         hr(),
         plotlyOutput("runsPlot")
    )
#  )
))
