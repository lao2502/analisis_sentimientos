library(shiny)


shinyUI(  navbarPage(title = "Herramienta para Analisis de tendencias en redes sociales", 
                   
                   tabPanel("Importar datos",
                   
                  # Widget para carga de datos externos formato csv          
                   sidebarLayout(
                     sidebarPanel(
                       fileInput("file1", "Subir un archivo CSV",
                                 accept = c(
                                   "text/csv",
                                   "text/comma-separated-values,text/plain",
                                   ".csv")
                       ),
                       tags$br(),
                       checkboxInput("header", "Encabezados", TRUE)
                     ),
                    
                     mainPanel(
                       tableOutput("contents")
                     )
                    ),
                  
                 # botón para lanzar análisis de datos cargados en contenedor
                 
                 tags$head(
                   tags$style(HTML('#analizar{background-color:yellow}'))
                 ),
                 
                 actionButton("analizar", "Ejecutar análisis")
                  
                   ),
                  
                     
                   tabPanel("Histograma",
                            
                            sidebarLayout(
                                sidebarPanel(
                                    sliderInput("rango", "Seleccione número de contenedores", min = 5, max = 50,value = 25)
                                ),
                                mainPanel(
                                    plotOutput("plot")
                                )
                            )
                   ),
                   
                   
                   tabPanel("Nube de palabras",
                            sidebarLayout(
                              sidebarPanel(
                                hr(),
                                sliderInput("frec",
                                            "Frequencia mínima:",
                                            min = 1,  max = 50, value = 15),
                                sliderInput("max",
                                            "Número max. palabras:",
                                            min = 1,  max = 300,  value = 100)
                              ),
                             # muestra nube de palabras
                              mainPanel(
                                plotOutput("plot2")
                              )
                            )
                   ),
                   
                   tabPanel("Tabla de frecuencias", tableOutput("datafrec")),
                   
                   
                   tabPanel("Créditos", 
                            h4("Luis ALberto Ortiz. ECBTI - UNAD - Universidad Nacional Abierta y a Distancia")
                   ),
                   
                   
                   ## Use navbarmenu to get the tab with menu capabilities
                   navbarMenu("Acerca de",
                              
                              tabPanel("Resumen", verbatimTextOutput("summary")),
                              tabPanel("Ayuda",
                                       h4(HTML(paste("Escribir texto", a(href="direccioón web", "link"), "."))),
                                       h4(HTML(paste("Escribir texto", a(href="mailto:correo", "email me"), ".")))
                                       
                              ))
))