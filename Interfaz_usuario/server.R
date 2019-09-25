#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
library(rsconnect)
library(shiny) # paquete R que facilita la creación de aplicaciones web interactivas
library(twitteR)# paquete e R que proporciona acceso a la API de Twitter
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
  
  # MODULO RECOPILACION DE DATOS 
  
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
                  
                  output$contenido <- renderTable(
                  
                  Lista

                  )
                  output$Consulta = renderText("Proceso completado satisfactoriamente")
                  
                
                  
                  })
  
  
            
  #Establezco el directorio de trabajo
  
  setwd("D:/Estudios/UNAD/Trabajo de grado/Proyecto final/Proyecto R-Twitter/analisis_sentimientos/Interfaz_usuario/datos")
  
  
  # MODULO ANALISIS DE DATOS 
  
  
  # Importación y análisis de datos
  
    output$fileload <- renderTable({
        # input $ file1 sera NULL inicialmente. Despues de que el usuario seleccione
        # y cargue un archivo, este sera un dataframe con columnas "nombre",
        # "tamano", "tipo" y "ruta de datos". La columna 'ruta de datos'
        # contendra los nombres de archivos locales donde pueden
        #encontrarse los datos
        
        indata <- input$file1
        
        if (is.null(indata))
            return(NULL)
        
        datafile<- input$file1$datapath
        
        
        dataup<- read.csv ( datafile,header = input$header,sep = input$sep,quote = input$quote)
        
       
        

        # Exportando datos 
         
        
        file.copy(indata, "D:/Estudios/UNAD/Trabajo de grado/Proyecto final/Proyecto R-Twitter/analisis_sentimientos/Interfaz_usuario/datos"
  , overwrite = TRUE) 
        
    
    output$fileload <- renderTable(
      dataup
    )

    
        
      })
    
    # RESULTADOS Y GRAFICOS 
    
    # Ejecutar análisis de datos mediante evento clic del botón analizar (ejecutar analisis) 
    
    observeEvent( input$analizar,
                  
                  {
                    setwd("D:/Estudios/UNAD/Trabajo de grado/Proyecto final/Proyecto R-Twitter/analisis_sentimientos/Interfaz_usuario")
                    
                    source("AnalisisTwitter_TI.R") 
                    
                    # imprime aviso tras completar el proceso anterior
                    output$analizar = renderText("Proceso completado satisfactoriamente")
                    
                  }
                  
                  
    )
    
    
    
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
