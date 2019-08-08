#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#

library(shiny)
library(twitteR)
library(ROAuth)

shinyServer(function(input, output, session) {
    
  
  # Crear acción cuando se hace clic en actionButton conectar
  
  
  observeEvent(input$conectar,
               
               
               {
                 output$estado = renderText("Conexión realizada")
                 
               }
               
               
               )
  
  
  # conexion a los datos de la api de twiter setup_twitter_oauth("consumer key", "consumer secret", "acces token", "acces token secret")
  
  
  
  # consumer_key <- "r51oIoQdGaKsN30Hx8TvmU5Z8"
  # consumer_secret <- "eVB9Vw2qTqjB7PQ7RVGNCGLjz6UNam3nqbkviDEoYsvV1hVHDq"
  # access_token <- "219743012-efZ5bpOckPPxIqr3TL1TBuEj0CYLvf9ynDZThY4E"
  # access_secret <- "GVB3RzuGzK9tUiGHttiWpCJK1eKTn0L9eNuMwPngmcZr5"
  # 
  # conexion <- eventReactive(
  #   input$conectar,{input$clave},{input$secreta},{input$token},{input$stoken})
  # 
  # 
  # })
  
  #setup_twitter_oauth(clave, secreta, token, stoken)
  
  
   
  # Recopilación de datos 
  
  palabra <- eventReactive(
    input$Buscar,{input$busqueda})
  etiqueta <- renderText({ palabra()

  })
  
  # Ejecutar análisis de datos mediante evento clic del botón analizar (ejecutar analisis) 
  
  observeEvent( input$analizar,
                
                {
                  setwd("D:/Estudios/UNAD/Trabajo de grado/Proyecto final/Proyecto R-Twitter/analisis_sentimientos/Interfaz_usuario")
                 
                  source("AnalisisTwitter_TI.R") 
                  
                  # imprime aviso tras completar el proceso anterior
                  output$analizar = renderText("Proceso completado satisfactoriamente")
                  
                }
                
               
  )
  
    
   
  # Importación y análisis de datos
  
    output$contents <- renderTable({
        # input $ file1 sera NULL inicialmente. Despues de que el usuario seleccione
        # y cargue un archivo, este sera un dataframe con columnas "nombre",
        # "tamano", "tipo" y "ruta de datos". La columna 'ruta de datos'
        # contendra los nombres de archivos locales donde pueden
        #encontrarse los datos
        
        inFile <- input$file1
        
        #Establezco el directorio de trabajo
        
        setwd("D:/Estudios/UNAD/Trabajo de grado/Proyecto final/Proyecto R-Twitter/analisis_sentimientos/Interfaz_usuario/datos")
        
        #Exportando datos 
        
        write.csv(inFile, file="Prueba1.csv",row.names = F)
        
        if (is.null(inFile))
            return(NULL)
        
        read.csv(inFile$datapath, header = input$header)
        
      
      })

    
    
    
    
    
    
    # {
    #   
    #   # Puede acceder al valor del widget con input$action, por ejemplo
    #   output$value <- renderPrint({ input$analizar })
    #   
    # }
    
    # para mostrar los datos de frecuencias positivas en la pagina "frecuencias"
    output$datafrec <- renderTable({
        positivas
    })
    
    
    
    # para mostrar el histograma en la pagina "Histograma"
    
    output$plot <- renderPlot({
        hist(positivas$frecuencia, main = "Frecuencia de palabras positivas", xlab = "Palabras mas utilizadas", ylab = "Frecuencia", col ="light blue", breaks=input$rango )
    })
    
    

    # para mostrar nube de palabras en la pagina "Nube de palabras"
     
    output$plot2 <- renderPlot({
        wordcloud(positivas$Palabras, positivas$frecuencia, random.order = FALSE, colors = brewer.pal(8,"Dark2"), max.words = 300)
     })
    
    
    
    
   
    # para la visualizacion de estadisticas de resumen del conjunto de datos en "pagina Resumen"
    output$summary <- renderPrint({
        summary(positivas)
    })
    
})
