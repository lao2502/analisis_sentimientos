#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
library(shiny)
shinyServer(function(input, output, session) {
    
    
    # para mostrar los datos de mtcars en la página "Datos"
    output$data <- renderTable({
        positivas
    })
    
    
    
    # para mostrar el histograma en la página "Gráficos y diagramas"
    
    output$plot <- renderPlot({
        hist(positivas$frecuencia, main = "Frecuencia de palabras positivas", xlab = "Palabras más utilizadas", ylab = "Frecuencia", col ="light blue", breaks=input$rango )
    })

    
    
    
    # para la visualización de estadísticas de resumen del conjunto de datos en "pagina Resumen"
    output$summary <- renderPrint({
        summary(positivas)
    })
    
})
