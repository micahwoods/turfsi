### What these files do

The `ui.R` and `server.R` files make a [Shiny](http://shiny.rstudio.com/) app, online at https://asianturfgrass.shinyapps.io/turfsi/.

### More about the project and app

We evaluated thousands of Mehlich 3 soil test results collected from locations producing good turf at the time the sample was collected. These results can be described by a 2 parameter log logistic (Fisk) distribution. The sustainability index (SI) is the value of 1 minus the cumulative distribution function (CDF) evaluated at given soil nutrient level, with the CDF determined by the distribution fit for that element in the MLSN project.

This app calculates and displays the SI for any soil test value of K, P, Ca, Mg, and S.