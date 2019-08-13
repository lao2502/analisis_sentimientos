#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#

library(shiny)
library(twitteR)
library(ROAuth)
library(httr)

shinyServer(function(input, output) {
    
  
  # Crear acción cuando se hace clic en actionButton conectar de conexion
  
    observeEvent(input$conectar,
               
               
               {
                 
                 consumer_key <- input$clave
                 consumer_secret <- input$secreta
                 access_token <- input$token
                 access_secret <- input$stoken
                 
                 output$estado <- renderText({
                 if (is.null(consumer_key, consumer_secret,access_token, access_secret))
                   return(NULL)
                   
                 })
                 
              
                 
                 setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
                 
                 
                 
                 # imprime aviso tras completar el proceso anterior
                 
                 output$estado = renderText("Conexión realizada")
                 
               }
               
               
               )
  
   
  # Crea accion buscar para pestaña de Recopilación de datos 
  
  observeEvent( input$Buscar,
                
                  {
                    #Establezco el directorio de trabajo
                    
                   setwd("D:/Estudios/UNAD/Trabajo de grado/Proyecto final/Proyecto R-Twitter/analisis_sentimientos/Interfaz_usuario/datos")
                    
                    
                    palabra <-input$busqueda
                  
                    #Seleccionamos tweets o la busqueda a realizar 
                    consulta <- searchTwitter(palabra, n=1000)
                    
                
                     #Creando un dataset de los datos obtenidos 
                  
                  Lista=twitteR::twListToDF(consulta)
                  
                  
                  #Exportando datos 
                  
                  write.csv(Lista, file="busqueda.csv",row.names = F)
                  
                  output$contents1 <- renderTable(
                  
                  Lista

                  )
                  output$Consulta = renderText("Proceso completado satisfactoriamente")
                  
                
                  
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
        
        indata <- input$file1
        
        #Establezco el directorio de trabajo
        
        setwd("D:/Estudios/UNAD/Trabajo de grado/Proyecto final/Proyecto R-Twitter/analisis_sentimientos/Interfaz_usuario/datos")
        
        
        
        if (is.null(indata))
            return(NULL)
        
        dataup<- read.csv(indata$datapath, sep =";", header = input$header)
       
        output$contents <- renderTable(
          
          dataup
        )
      #Exportando datos 
        write.csv(dataup, file="importado.csv", sep =";", row.names = F)
        
        
        
        
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
