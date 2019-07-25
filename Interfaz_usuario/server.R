#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
library(shiny)
shinyServer(function(input, output, session) {
    
    
    output$contents <- renderTable({
        # input $ file1 será NULL inicialmente. Después de que el usuario seleccione
        # y cargue un archivo, este será un dataframe con columnas "nombre",
        # "tamaño", "tipo" y "ruta de datos". La columna 'ruta de datos'
        # contendrá los nombres de archivos locales donde pueden
        #encontrarse los datos
        
        inFile <- input$file1
        
        if (is.null(inFile))
            return(NULL)
        
        importdata<- read.csv(inFile$datapath, header = input$header)
        
        
        
    })

    
    
    # para mostrar los datos de frecuencias positivas en la página "frecuencias"
    output$datafrec <- renderTable({
        positivas
    })
    
    
    
    # para mostrar el histograma en la página "Histograma"
    
    output$plot <- renderPlot({
        hist(positivas$frecuencia, main = "Frecuencia de palabras positivas", xlab = "Palabras más utilizadas", ylab = "Frecuencia", col ="light blue", breaks=input$rango )
    })
    
    

    # para mostrar nube de palabras en la página "Nube de palabras"
     
    output$plot2 <- renderPlot({
        wordcloud(positivas$Palabras, positivas$frecuencia, random.order = FALSE, colors = brewer.pal(8,"Dark2"), max.words = 300)
     })
    
    
    
    
   
    # para la visualización de estadísticas de resumen del conjunto de datos en "pagina Resumen"
    output$summary <- renderPrint({
        summary(positivas)
    })
    
})
