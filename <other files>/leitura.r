library(XLConnect)
library(ggvis)
library(dplyr)
dez <- readWorksheetFromFile("Controle geral de indicadores.xlsx",1,startRow = 4, endRow =201,startCol = 1, endCol = 23)

options(OutDec = ".")
View(dez)

attach(dez)

dadosre<- reshape(dez,varying = names(dez)[12:23] ,timevar = "Periodo",times = c("01/2016","02/2016","03/2016","04/2016","05/2016","06/2016","07/2016","08/2016","09/2016","10/2016","11/2016","12/2016"),v.names = "valor",direction = "long")
View(dadosre)
attach(dadosre)
valor
dadosre$valor<- gsub(",",".",valor)
dadosre
View(subset(dadosre, Periodo == "03/2016")
)
