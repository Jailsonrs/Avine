library(XLConnect)
library(ggvis)
library(dplyr)
library(rCharts)
dez <- readWorksheetFromFile("/home/jailsonr/Desktop/BD AVINE ATUALIZADO/APP SHINY/<other files>/Controle geral de indicadores.xlsx",1,startRow = 4, endRow =201,startCol = 1, endCol = 23)

options(OutDec = ",")
attach(dez)
dadosre<- reshape(dez,varying = names(dez)[12:23] ,timevar = "Periodo",times = c("01/2016","02/2016","03/2016","04/2016","05/2016","06/2016","07/2016","08/2016","09/2016","10/2016","11/2016","12/2016"),v.names = "valor",direction = "long")

attach(dadosre)
#dadosre$valor<- gsub(",",".",valor)

