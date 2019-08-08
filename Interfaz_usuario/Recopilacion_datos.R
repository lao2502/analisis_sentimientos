# install.packages("twitteR")
# install.packages("ROAuth")
# install.packages("httr")
# install.packages("tm")


library(twitteR)
library(ROAuth)
library(httr)
#library(tm)


# conexion a los datos de la api de twiter setup_twitter_oauth("consumer key", "consumer secret", "acces token", "acces token secret")

consumer_key <- "r51oIoQdGaKsN30Hx8TvmU5Z8"
consumer_secret <- "eVB9Vw2qTqjB7PQ7RVGNCGLjz6UNam3nqbkviDEoYsvV1hVHDq"
access_token <- "219743012-efZ5bpOckPPxIqr3TL1TBuEj0CYLvf9ynDZThY4E"
access_secret <- "GVB3RzuGzK9tUiGHttiWpCJK1eKTn0L9eNuMwPngmcZr5"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

#Seleccionamos tweets o la busqueda a realizar 
consulta <- searchTwitter("empleo", n=1000)

#Creando un dataset de los datos obtenidos 

Lista=twitteR::twListToDF(consulta)

#Establezco el directorio de trabajo

setwd("D:/Estudios/UNAD/Trabajo de grado/Proyecto final/Proyecto R-Twitter/Dataset")

#Exportando datos 

write.csv(Lista, file="bd_descarga.csv",row.names = F)

