library(shiny)
library(shinydashboard)


dashboardPage(
    dashboardHeader(title = "IBM - TT Finance Report"),
    dashboardSidebar(
        textInput("login", "Please provide your IBM Mail"),
        passwordInput("pass", "Please provide your IBM intranet password."),
        actionButton("do", "Get Report"),
        downloadButton("downloadTT", "Download TT Finance")
        
    ),
    dashboardBody(
        # Boxes need to be put in a row (or column)
        fluidRow(
            box(textOutput("response"))
        )
    )
)