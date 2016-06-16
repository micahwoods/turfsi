
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(VGAM)
library(ggplot2)
library(cowplot)

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

ecdfPlot <- function(zed, xLabInput, scale, shape, maxGSS, mlsn, userPPM) {
  
  
  set.seed(13121914)
  sim.data <- data.frame(simY = rfisk(n = 3683,
                                      scale, shape)) 
  
  sIndex <- pfisk(userPPM, scale = scale,
                  shape1.a = shape)
  
  userData <- cbind.data.frame(userPPM, sIndex)
  
  maxValu <- ifelse(userPPM <= maxGSS, maxGSS, userPPM)
  
 # siLabelX <- ifelse(userPPM >= maxValu - 20, userPPM - 0.08 * maxValu,
 #                     ifelse(userPPM < mlsn, userPPM,
 #                            userPPM + 0.08 * maxValu))
  
  siLabelX <- maxValu * 0.5
  
 # siLabelY <- ifelse(userPPM < mlsn, sIndex + 0.1,
 #                     sIndex - 0.05)
  
  # makes a plot
  
  p <- ggplot(data = sim.data, aes(x = simY))
  p + stat_ecdf(alpha = 0.3) +
    labs(x = bquote(paste(.(xLabInput), ~kg^{-1}*")")),
         y = "Fn(x)") +
    background_grid(major = "xy") +
    scale_x_continuous(limits = c(0, maxValu)) +
    geom_vline(xintercept = mlsn, colour = "#1b9e77", linetype = 3) +
    geom_point(data = userData, aes(x = userPPM, y = sIndex),
               colour = "#d95f02") +
    annotate("text", colour = "#1b9e77", label = "MLSN",
             x = mlsn + 0.08 * maxValu, y = 0.95) +
    annotate("text", colour = "#d95f02", label = paste("SI =", 
                                                       formatC(1 - sIndex, digits = 2,
                                                                 format = "f")),
             x = siLabelX, y = 0.1)
}

shinyServer(function(input, output) {
  
  output$siPlot <- renderPlot({
    
  k <-  ecdfPlot(input$potassium, "K (mg", 73.48, 3.2, 300, 37, input$potassium)
  p <-  ecdfPlot(input$phosphorus, "P (mg", 55.07, 2.23, 300, 21, input$phosphorus)
  ca <-   ecdfPlot(input$calcium, "Ca (mg", 548.13, 4.85, 1000, 348, input$calcium)
  mg <-   ecdfPlot(input$magnesium, "Mg (mg", 83.17, 3.83, 300, 47, input$magnesium)
  s <-   ecdfPlot(input$sulfur, "S (mg", 19.366119, 2.299949, 100, 7, input$sulfur)
  
  multiplot(k, p, ca, mg, s, cols = 2)
    
  })
  
})