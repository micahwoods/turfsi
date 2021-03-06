
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Sustainability index (SI) calculator"),
  
  HTML("<p>The sustainability index (SI) is a comparison of a soil test value to the distribution
          of that element in soils that produce good turfgrass. In the MLSN project, we've studied
         thousands of Mehlich 3 soil test results from soils that produce good performing turf. 
         The SI is a 
         simple way to compare your soil nutrient levels to the distribution of soil nutrient levels 
         in the MLSN project.</p>

          <p>The numerical value of SI 
          represents the proportion
          of turfgrass soils having values smaller than the given soil test value. A low SI means 
          there are relatively few soils with lower concentrations of that nutrient. For example, with an SI of 0.07,
          one can expect 7% of soils producing good turf to have nutrient levels below that value, and 93% to be above it.
          When the SI is 0.5, 
          one can expect half the soils producing good turf to have nutrient levels less than the given soil test value. 
          When the SI is 0.97, one can expect 97% of the soils producing good turf to be doing so with nutrient levels
          below the given soil test value. </p>
        <p> Change these input values to show the SI for 
            Mehlich 3 soil test results of your choice. When the soil is at
           the MLSN guideline level, the SI is 0.1. More details at bottom.
          </p>"),


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
    ),
    
    
  ),
  hr(),
  helpText(HTML(paste("<p>We define the sustainability index as the cumulative distribution 
            function 
            evaluated at the given soil test value, for a 2 parameter log logistic distribution
            based on the MLSN data. For more information, see the data and the distribution
            fitting procedure in ",
                 a("this 2016_mlsn_paper repository",
                   href = "https://github.com/micahwoods/2016_mlsn_paper"),
                 ". The code to make this ShinyApp is in the ",
                 a("turfsi", 
                   href = "https://github.com/micahwoods/turfsi"),
                 " repository.</p>",
                 "<p>This is a joint project of ",
                 a("PACE Turf ",
                   href = "http://www.paceturf.org"),
                  "and the ",
                 a("Asian Turfgrass Center.",
                   href = "http://www.asianturfgrass.com"),
                 sep = "")
  )),
  
  br(), 
  br(),
  
  a(href = "http://www.paceturf.org", 
    img(src = "pace.png", width = 130)),
  a(href = "http://www.asianturfgrass.com", 
    img(src = "atc.png", height = 85, width = 85))

)
)

