#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(ggplot2)

source("data.R", local=TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$winsPlot <- renderPlotly({
    
       p <- plot_ly(data = wins_table, x = Gm, y = cum_wins, color = team, colors = c("#0E3386", "gray")) %>% 
       layout(title = "Running Win Totals",
                  scene = list(
                       xaxis = list(title = "Game Number"), 
                       yaxis = list(title = "Wins")))
       p
    
  })
  
  output$runsPlot <- renderPlotly({
       
       p <- plot_ly(data = rundiff_table, x = Gm, y = cum_rundiff, color = team, colors = c("#0E3386", "gray")) %>% 
       layout(title = "Running Run Differential",
                  scene = list(
                       xaxis = list(title = "Game Number"),
                       yaxis = list(title = "Run Differential")))
       p
       
  })
  
  
})
