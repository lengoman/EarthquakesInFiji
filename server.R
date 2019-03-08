#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    # Reactive expression for the data subsetted to what the user selected
    filteredData <- reactive({
        quakes[quakes$mag >= input$range[1] & quakes$mag <= input$range[2],]
    })
    
    output$table <- renderTable(filteredData())

    output$map <- renderLeaflet({
        leaflet(quakes) %>% addTiles() %>%
            fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat)) 
    })
    observe({
        pal <- colorNumeric("Oranges", quakes$mag)
        
        leafletProxy("map", data = filteredData()) %>%
            clearShapes() %>%
            addCircles(radius = ~10^mag/10, weight = 1, color = "#777777",
                       fillColor = ~pal(mag), fillOpacity = 0.7, popup = ~paste(mag)
            )
    })
})
