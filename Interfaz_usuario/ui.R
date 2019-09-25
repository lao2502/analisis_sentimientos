library(shiny)


shinyUI(fluidPage(
  
  tags$img(src="Banner_ARS.png",width="100%", height="150px"),
  titlePanel("Software de Analisis de tendencias en redes sociales"),
  
  
  # crea una barra de navegación de nivel superior
  
  navbarPage( 
    
    
    
    tags$head(
      
      tags$style(type="text/css",
      ".test_type {color: blue;
font-size: 20px;
font-style: italic;}"
    )
      
    ),
    
    # Crea un menu con varias pestañas - Datos
    #crea encabezados de selección de menú 
    
    navbarMenu("Datos",
               
               # Crea una pestaña para ir a Recopilar datos 
               
               tabPanel("Recopilar datos",
                        
                        tags$h2("Establecer conexión"),
                        sidebarPanel(
                          tags$strong("Todos los campos son obligatorios"), 
                          br(),
                          tags$em(" *Ingrese datos de enlace con la app-twitter y clic en conectar*"),
                          br(),
                          br(),
                          textInput("clave","Ingrese clave (consumer key)"),       
                          textInput("secreta","Ingrese clave secreta (consumer secret)"),
                          textInput("token","Ingrese token de acceso (token access)"),
                          textInput("stoken","Ingrese token secreto de acceso (secret access)"),
                          
                          actionButton("conectar", "Conectar Twitter"),
                          
                          #  Crear posición para el texto del lado del servidor
                          
                          textOutput("estado")
                        ),
                        
                        
                        tags$h2 ("Recopilación de datos"),
                        
                        # formulario para busqueda de datos
                        
                        sidebarPanel(
                          
                          tags$em("***Antes debe ingresar claves de acceso y conectar
                       con la app de twitter***"),
                          
                          textInput("busqueda","Ingrese palabra a buscar"),
                          actionButton("Buscar", "Buscar"),
                          textOutput("Consulta")
                        ),
                        mainPanel(
                          tableOutput("contenido")  
                        )
                        
               ),
               # # Crea una pestaña para ir a Importar y analizar datos
               
               tabPanel("Analizar",
                        
                        tags$h1 ("Manejo de datos"), 
                        
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
                            
                            radioButtons(
                              "sep", "Separador",
                              choices = c(
                                "Coma" = ",",
                                "Punto y coma" = ";",
                                "Tabulacion" = "\t"
                              ),
                              
                              selected = ";"
                            ),
                            tags$br(),
                            radioButtons(
                              "quote", "Comillas",
                              choices = c(
                                "Ninguna" = "",
                                "Comilla doble" = '"',
                                "Comilla sencilla" = "'"
                              ),
                              selected = ''
                            ),
                            tags$br(),
                            
                            
                            checkboxInput("header", "Encabezados", TRUE),
                            
                            #Crea boton para ejecutar analisis de datos
                            
                            actionButton("analizar", label= "Ejecutar analisis"),
                            
                            #salida de texto estado de analisis de datos
                            textOutput("analizar")
                            
                          ),
                          
                          #  Crear posición para el texto del lado del servidor
                          
                          
                          mainPanel(
                            tableOutput("fileload")
                          )
                          
                          
                        )
                        
               )
    ),
    
    # Crea un menu con varias pestañas - Resultados
    
    navbarMenu("Resultados",
               
               # Crea una pestaña para ir a Histograma 
               
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
               
               # Crea una pestaña para ir a Nube de palabras 
               
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
               
               # Crea una pestaña para ir a Tabla de frecuencias 
               
               tabPanel("Tabla de frecuencias", tableOutput("datafrec")),
               
               # Crea una pestaña para ir a Resumen 
               
                tabPanel("Resumen", verbatimTextOutput("summary"))
               
    ),
    
    
    
    # Crea un menu con varias pestañas - Acerca de
    
    navbarMenu("Acerca de",
               
               # Crea una pestaña para ir a ayuda
               
               tabPanel("Ayuda",
                        h1("Solución de problemas y ayuda"),
                        
                        em('A continuacion usted encontrara los enlaces de apoyo:

                                          De click sobre la opcion que desee.'),
                        
                        h4(HTML(paste("Documentación y problemas comunes", a(href="https://www.unad.edu.co/", "Ver")))),
                        h4(HTML(paste("Contacto:", a(href="mailto:lao2502@hotmail.com", "Comenzar"))))
               ),
               
               # Crea una pestaña para ir creditos
               
               tabPanel("Creditos", 
                        mainPanel("",
                                  
                                  img(src="logo_unad.png"),
                                  
                                  h2('Herramienta tecnologica ARS SIAVA'),
                                  br(),
                                  
                                  p("ARS SIAVA, es una aplicacion web interactiva para analisis, recopilacion y visualizacion
                                      estadastica de redes sociales, el cual permite ver tendencias, a partir del
                                      analisis de sentimientos de la informacion recopilada. Este es un proyecto desarrollado 
                                      dentro del semillero de investigacion SIAVA CEAD Popayan, promovido por la Universidad 
                                      Nacional Abierta y a Distancia - UNAD."),
                                  
                                  br(),                                                         
                                  strong ("Director proyecto: Hermes Mosquera - Msc. Ingeniero de sistemas"),br(),   
                                  strong ("Desarrollado por: Luis Alberto Ortiz Palma - Ingenieria de sistemas"),
                                  
                                  
                                  br(),
                                  br(),
                                  
                                  img(src="Semilleros_unad.png", height=150, weight=360)  
                                  
                                  
                        )
                        
                        
               )
    )
  )
  
) 
)
  
  
  
  
  