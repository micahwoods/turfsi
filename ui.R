
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Sustainability index (SI) calculator"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput("potassium",
                  "Soil test potassium (ppm):",
                  min = 0,
                  max = 10000,
                  value = 37),
   
        numericInput("phosphorus",
                     "Soil test phosphorus (ppm):",
                     min = 0,
                     max = 10000,
                     value = 21),
      
          numericInput("calcium",
                       "Soil test calcium (ppm):",
                       min = 0,
                       max = 10000,
                       value = 348),
        
            numericInput("magnesium",
                         "Soil test magnesium (ppm):",
                         min = 0,
                         max = 10000,
                         value = 47),
          
              numericInput("sulfur",
                           "Soil test sulfur (ppm):",
                           min = 0,
                           max = 10000,
                           value = 7)
            ),
  
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("siPlot")
    )
  )
)
)

