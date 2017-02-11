library(DT)
library(shiny)
library(dplyr)
library(DBI)
library(RMySQL)
library(RODBC)
Sys.setlocale('LC_ALL','A')

ui <- navbarPage(
    "Banco de Dados | Avine",
    tabPanel(
        "Controle Geral de Indicadores",
        titlePanel("Controle Geral de Indicadores"),            
        tabsetPanel(
            tabPanel(
                "Matriz de Busca",
                fluidRow(
                    column(3,
                           selectInput(
                               "per",
                               "Selecione o periodo",
                               choices = c("Todos", unique(Periodo)),
                               selected = "Todos"
                           )
                           ),
                    column(3,
                           selectInput(
                               "resp",
                               "Selecione o responsável  pelo o indicador",
                               choices = c("Todos", unique(Responsável.pelo.Indicador)),
                               selected = "Todos"
                           )
                           ),
                    column(3,
                           selectInput(
                               "ind",
                               "Selecione um indicador",
                               choices = c(unique(Indicador),"Todos")
                           )
                           ),
                    column(4,
                           radioButtons(
                               "natu","Selecione a natureza do Indicador",
                               choices = c("Todas",unique(dadosre$Natureza)),
                               selected = "Todas"
                           )
                           ),                                                             
                    DT::dataTableOutput("table")                                   
                )                                  
            ),
            tabPanel("Análise",
                     pageWithSidebar(headerPanel("33"),
                                     sidebarPanel("we"),
                                     mainPanel(plotOutput("ana")))
                     
                     )
        )
    ),
    tabPanel(
        "Indicadores de Gerência"),
    tabPanel(
        "Indicadores de Industria",
        fluidPage(
            fluidRow(
                column(
                    3,
                    h3("Análise Gráfica de Indicadores")                                                
                )
            ) 
        )
    ),
    tabPanel(
        "Indicadores de Logística",
        fluidPage(
            fluidRow(
                column(7,
                       tabsetPanel(
                           "Ola",
                           tabPanel("Custo Logístico",
                                    ggvisOutput(
                                        "teste"                                  
                                    ),
                                    verbatimTextOutput("test")
                                    ),
                           tabPanel("Conformidade Logística"),
                           tabPanel("Devoluções(%)"),
                           tabPanel("Perdas de Ovos")
                       )
                 )    
            )
        )
    )
)

        #============================================================================#
        #=============                   SERVER LOGIC               =================#
        #============================================================================#

server <- function(input, output, session) {
    dass <- subset(dadosre, Indicador == "Custo Logístico")
    dass$valor <- as.numeric(dass$valor)
    dass %>%
        ggvis(~Periodo,~valor) %>%
        layer_bars() %>%
        bind_shiny("teste")
 
    output$test <- renderText(
        summary(as.numeric(subset(dadosre, Indicador == "Custo Logístico")$valor))
        
    )
    output$table <- DT::renderDataTable(
        DT::datatable({
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
            if(input$natu != "Todas" ){
                data <-  dadosre[dadosre$Natureza == input$natu,]
                
            }
            if(input$resp != "Todos" & input$natu != "Todas" & input$per != "Todos"){
                data <-  dadosre[dadosre$Natureza == input$natu & dadosre$Responsável.pelo.Indicador == input$resp & dadosre$Periodo == input$per,]
            }
            if(input$natu != "Todas" & input$per != "Todos" ){
                data <-  dadosre[dadosre$Natureza == input$natu & dadosre$Periodo == input$per,]
            }
       

            data
        })
    )
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
