#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(RColorBrewer)

shinyUI(bootstrapPage(
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
    leafletOutput("map", width = "100%", height = "100%"),
    absolutePanel(id = "controls", 
                  style="border: 1px solid rgba(0, 0, 255, 0.09);background: rgba(0, 0, 255, 0.09);",
                 fixed = TRUE,
                  draggable = TRUE, top = 300, left = "auto", right = 20, bottom = "auto",
                  width = 380, height = 450,
                  div(style="padding:20px",h3("Earthquakes in Fiji"),
                      h6("by Magnitude (drag me)"),
                      sliderInput("range", "", min(quakes$mag), max(quakes$mag),
                                  value = range(quakes$mag), step = 0.1
                      ),
                      div(style="overflow-y:scroll;height:220px",tableOutput('table'))
                  )
    )
))
