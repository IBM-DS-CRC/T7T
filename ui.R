library(shiny)
library(shinydashboard)
library(markdown)
library(shinyjs)

source("helpers.R")

dashboardPage(
  dashboardHeader(title = "IBM - TT Finance Report"),
  dashboardSidebar(
    useShinyjs(),
    textInput("login", "Please provide your IBM Mail"),
    passwordInput("pass", "Please provide your IBM intranet password."),
    #actionButton("do", "Get Report"),
    withBusyIndicatorUI(
      actionButton(
        "do",
        "Get Report",
        class = "btn-primary"
      )
    ),
    br(), 
    
     downloadButton("downloadTT", "Download"),
    
    br(),
    
    br(),
    
    withBusyIndicatorUI(
      actionButton(
        "does",
        "Upload Data",
        class = "btn-primary"
      )
    )
    
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      infoBoxOutput("progressBox"),
      infoBoxOutput("progressBox2")
    ),
    fluidRow(
      box(title = "TT Finance Instructions", status = "primary", solidHeader = TRUE,
          collapsible = TRUE,
          p(includeMarkdown('include.md')) #calling the Markdown File with the instructions
      )
    )
    
  )
)
