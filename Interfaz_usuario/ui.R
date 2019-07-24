library(shiny)

shinyUI(navbarPage(title = "Herramienta para Analisis de tendencias en redes sociales", 
                   
                   tabPanel("Gráficas y diagramas",
                            sidebarLayout(
                                sidebarPanel(
                                    sliderInput("rango", "Seleccione número de contenedores", min = 5, max = 50,value = 25)
                                ),
                                mainPanel(
                                    plotOutput("plot")
                                )
                            )
                   ),
                   
                   tabPanel("Matriz de Datos", tableOutput("data")),
                   
                   
                   tabPanel("Créditos", 
                            h4("Luis ALberto Ortiz. ECBTI - UNAD - Universidad Nacional Abierta y a Distancia")
                   ),
                   
                   
                   ## Use navbarmenu to get the tab with menu capabilities
                   navbarMenu("Datos",
                              tabPanel("Resumen", verbatimTextOutput("summary")),
                              tabPanel("Ayuda",
                                       h4(HTML(paste("Escribir texto", a(href="direccioón web", "link"), "."))),
                                       h4(HTML(paste("Escribir texto", a(href="mailto:correo", "email me"), ".")))
                                       
                              ))
))