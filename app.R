library(DT)
library(shiny)
library(dplyr)
library(DBI)
library(RMySQL)
library(RODBC)
Sys.setlocale('LC_ALL','A')

ui <- navbarPage("Banco de Dados | Avine",
                 tabPanel("Controle Geral de Indicadores",
                          titlePanel("Controle Geral de Indicadores"),            
                          tabsetPanel(
                              tabPanel(
                                  "Matriz de Busca",
                                  fluidRow(
                                      column(2,
                                             selectInput("per",
                                                         "Selecione o periodo",
                                                         choices = c("Todos", unique(Periodo)))
                                             ),
                                      column(3,
                                             selectInput(
                                                 "resp",
                                                 "Selecione o responsável  pelo o indicador",
                                                 choices = c("Todos", unique(Responsável.pelo.Indicador)),
                                                 selected = sample(Responsável.pelo.Indicador))       
                                             )
                                  ),
                                  DT::dataTableOutput("table")
                              ),
                              tabPanel("Inserir Valores")
                          )
                          ),
                 tabPanel("Indicadores de Gerência",
                          fluidPage(
                              fluidRow(
                                  column(3,
                                         h3("Análise Gráfica de Indicadores")
                                         
                                         )
                              )
                          )
                          ),
                 tabPanel("Indicadores de Industria",
                          fluidPage(
                              fluidRow(
                                  column(3,
                                         h3("Análise Gráfica de Indicadores")
                                         
                                        )
                              )
                          )
                          ),
                 tabPanel("Indicadores de Logística",
                          fluidPage(
                              fluidRow(
                                  column(3,
                                         h3("Análise Gráfica de Indicadores")
                                         
                                         )
                              )
                          )
                          )
                 
                 )               
server <- function(input, output, session) {
    
                                        # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
        data <- dadosre
        
        if (input$resp != "Todos") {
            data <- dadosre[dadosre$Responsável.pelo.Indicador == input$resp,]
        }
        
        if (input$per != "Todos") {
            data <- dadosre[dadosre$Periodo == input$per,]
            
        }
        if(input$per != "Todos" & input$resp != "Todos"){
            data <- dadosre[dadosre$Periodo == input$per & dadosre$Responsável.pelo.Indicador == input$resp,]   
        }
        data
        
    }))
    
                                        #addrow <- function(data){
                                        #   newrow <- 
                                        #  data <- rbind(data,newrow)
}

    


shinyApp(ui,server) 
                                        #  conn <- dbConnect(
                                        #     drv = RMySQL::MySQL(),
                                        #    dbname = "world",
                                        #       host = "127.0.0.1",
                                        #       username = "jrs",
                                        #      password = "a7v8x")
                                        #  on.exit(dbDisconnect(conn),add=TRUE)
                                        #  dbGetQuery(conn, paste0(
                                        #"SELECT * FROM city LIMIT ", input$nrows, ";"))
                                        # })

 
#cons <- dbListConnections(MySQL())
#for(con in cons)
 #     dbDisconnect(con)
#dbListConnections(MySQL())







    ##CONEXÃO E CONSULTA EM BANCO DE DADOS MySQL USANDO O PACOTE DBI
    #CONEXÃO
   # dados <- dbConnect(
    #    dbDriver("MySQL"),
     #   user = "jrs",
      #  password = "a7v8x",
       # dbname = "world",
        #host = "127.0.0.1"
    #)
    #CONSULTA
   # consulta <- dbSendQuery(dados,"SELECT *  FROM city")
   # ENTREGA<- dbFetch(consulta)