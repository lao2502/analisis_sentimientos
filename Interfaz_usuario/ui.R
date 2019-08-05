library(shiny)


shinyUI(navbarPage( 
  
  
  
    tags$head(
      
      tags$img(src="banner_unad.jpg",width="850px", height="100px"),
      titlePanel("Herramienta para Analisis de tendencias en redes sociales")
    
  ),
  
  navbarMenu("Datos",
             
             
             tabPanel("Recopilar datos",
                      
                      tags$h1 ("Recopilación de datos"),
                  
             # formulario para busqueda de datos
             sidebarPanel(
               
               textInput("busqueda","Ingrese palabras a buscar"),
               actionButton("Buscar", "Buscar") 
               
             )
             ),
         
         
              tabPanel("Analizar",
                  
                       tags$h1 ("Importación y administración de datos"), 
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
                       checkboxInput("header", "Encabezados", TRUE),
                       
                       #Crea boton para ejecutar analisis de datos
                       
                       actionButton("analizar", label= "Ejecutar analisis")
                                ),
                     
                     
                    
                     mainPanel(
                       tableOutput("contents")
                              )
                     
                     
                                )
                  
                 
                  
                  )
             ),
                  
                 
                  
                 navbarMenu("Resultados",
                     
                   tabPanel("Histograma",
                            
                            sidebarLayout(
                                sidebarPanel(
                                    sliderInput("rango", "Seleccione numero de contenedores", min = 5, max = 50,value = 25)
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
                                            "Frequencia minima:",
                                            min = 1,  max = 50, value = 15),
                                sliderInput("max",
                                            "Numero max. palabras:",
                                            min = 1,  max = 300,  value = 100)
                              ),
                             # muestra nube de palabras
                              mainPanel(
                                plotOutput("plot2")
                              )
                            )
                   ),
                   
                   tabPanel("Tabla de frecuencias", tableOutput("datafrec")),
                   
                   tabPanel("Resumen", verbatimTextOutput("summary"))
                   
                 ),

                   
                   
                   ## Use navbarmenu to get the tab with menu capabilities
                   navbarMenu("Acerca de",
                              
                              
                              tabPanel("Ayuda",
                                       h1("requieres apoyo?"),
                                       
                                       em('A continuacion usted encontrara los enlaces de apoyo:

                                          De click sobre la opcion que desee.'),
                                       
                                       h4(HTML(paste("Documentacion", a(href="https://www.unad.edu.co/", "Clic aqui"), "."))),
                                       h4(HTML(paste("Correo electrÃ³nico:", a(href="mailto:lao2502@hotmail.com", "enviar ahora"), ".")))
                                       ),
                                       
                              tabPanel("Creditos", 
                                                mainPanel("",
                                                          
                                                          img(src="logo_unad.png"),
                                                          
                                                          h1('Herramienta tecnologica ARS SIAVA'),
                                                          
                                                          p("ARS SIAVA, es una aplicacion web interactiva para analisis, recopilacion y visualizacion
                                      estadastica de redes sociales, el cual permite ver tendencias, a partir del
                                      analisis de sentimientos de la informacion recopilada. Este es un proyecto desarrollado 
                                      dentro del semillero de investigacion SIAVA CEAD PopayÃ¡n, promovido por la Universidad 
                                      Nacional Abierta y a Distancia - UNAD."),
                                                          
                                                        br(),                                                         
                                                        br(),
                                                        strong ("Director proyecto: Hermes Mosquera - Msc. Ingeniero de sistemas"),br(),   
                                                        strong ("Desarrollado por: Luis Alberto Ortiz Palma - Ingenieria de sistemas"),
                                                        
                                                          
                                                        br(),
                                                        br(),
                                                        br(),
                                                        br(),
                                                        br(),
                                                        br(),
                                                          img(src="Semilleros_unad.png", height=150, weight=360)  
                                                          
                                                          
                                                )
                                       
                                       
                                      )
                              )
)

)