#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyFiles)
library(miniUI)
library(data.table)
library(dplyr)
library(tidyr)
library("shinydashboard")
library("formattable")
library(readr)
library(DT)
library(shinythemes)

updateDate <- format(file.info("mort_comarques.csv")$mtime, "%d/%m/%y %H:%M")

ui <- fluidPage(theme = shinytheme("flatly"),
                h2("Positius PCR/TA, Hospitalitzacions i Defuncions per COVID19 a Catalunya"),
                h4("Act.", updateDate),
                tabsetPanel(

                    tabPanel("Municipis",
                             div(DT::dataTableOutput("Municipis"), style=c("color:black"))
                    ),

                    tabPanel("Comarques",
                             div(DT::dataTableOutput("Comarques"), style=c("color:black"))
                    ),

                    tabPanel("Test",
                             div(DT::dataTableOutput("Test"), style=c("color:black"))
                    ),

                    tabPanel("ABS",
                             div(DT::dataTableOutput("ABS"), style=c("color:black"))
                    ),

                    tabPanel("Hospitalitzats",
                             div(DT::dataTableOutput("Hospitalitzats"), style=c("color:black"))
                    ),

                    tabPanel("UCI",
                             div(DT::dataTableOutput("UCI"), style=c("color:black"))
                    ),

                    tabPanel("Defuncions",
                             div(DT::dataTableOutput("Defuncions"), style=c("color:black"))
                    ),

                    tabPanel("Vacunes 1a dosi",
                             div(DT::dataTableOutput("Vacunes 1a dosi"), style=c("color:black"))
                    ),
                    h5("IMPORTANT:"),
                    h5("Els positius de les últimes setmanes inclouen: Positius PCR i Test d'Antígens. Els positius totals, també inclouen els Positius per Test Ràpid, ELISA i Epidemiològic"),
                    h5("Els últims tres dies inclouen dades parcials i per això NO s'inclouen en la columna 'Última Setmana'."),
                    h5("Les hospitalitzacions inclouen UCI i no-UCI. Corresponen a HOSPITALITZACIONS ACTUALS, no són NOVES hospitalitzacions."),
                    h5(""),
                    h5("Elaborat per Gerard Giménez Adsuar (Twitter: @gmnzgerard), amb les Dades Obertes de Catalunya. Els errors són la meva responsabilitat.")
                )
)

#### Server function ####

server <- shinyServer(function(input, output, session) {
    abs <- read_csv("abs.csv")
    output$ABS = DT::renderDataTable({
        abs
    })
    comarques <- read_csv("taula_comarques.csv")
    output$Comarques <-  DT::renderDataTable({
        comarques
    })
    taula <- read_csv("prova.csv")
    output$Municipis <-  DT::renderDataTable({
        taula
    })
    hospi <- read_csv("hospitalitzacions.csv")
    output$Hospitalitzats <-  DT::renderDataTable({
        hospi
    })
    uci <- read_csv("uci.csv")
    output$UCI <-  DT::renderDataTable({
        uci
    })
    pcr <- read_csv("pcr.csv")
    output$Test <-  DT::renderDataTable({
        pcr
    })
    defun <- read_csv("mort_comarques.csv")
    output$Defuncions <-  DT::renderDataTable({
        defun
    })
    vac <- read_csv("vacunes.csv")
    output$`Vacunes 1a dosi` <-  DT::renderDataTable({
        vac
    })

})

shinyApp(ui = ui, server = server)
