# Libraries required to this project
library(flexdashboard)
library(shiny)
library(XML)
library(rjson)
library(RJSONIO)
library(httr)
library(jsonlite)
library(dplyr)
library(lubridate)
library(httr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
 
   
    observeEvent(input$do, {
        # Download Report from IBM Form
        downloadReport()
        
        # 1. Delete blanks from ID Column
        
        # 2. North American Accounts
        
        # 3. Sector Info:
        
        # 4. In Progress PCRs:
        
        # 5. Approved PCRs
        
        # 6. Dates:
        
        # 7. # Days In Progress:
        
        # 8. PCRs over 10 Days
        
        # 9. Days since PCR was created:
        
        # Response once report is really to download.
        output$response <- renderText({
            "Your data is really to download"
        })
    })
    
    # Procedure to download the report from IBM Form
    downloadReport <- function(x){
        url  <- "https://w3-01.ibm.com"
        path <- "https://w3-01.ibm.com/tools/cio/forms-basic/secure/org/data/98fdd9e5-4671-448a-8578-9a71a719ecc6/F_Form1?format=application/json"
        
        raw.result <- GET(path,authenticate(input$login, input$pass))
        this.raw.content <- rawToChar(raw.result$content)
        this.content <- fromJSON(this.raw.content)
        dataframeTT <- this.content$items
        myvars <- names(dataframeTT) %in% c("lastModifiedBy", "createdBy",
                                            "F_Attachment2","F_Attachment3","F_Attachment4",
                                            "F_Attachment1", "createdBy", "F_Table1", 
                                            "F_Table2", "availableSubmitButtons") 
        dataframeTT <<- dataframeTT[,!myvars]
    }
    
    # Procedure to change variables names:
    
    
    # Button to download file:    
    output$downloadTT <- downloadHandler(
        filename = function(){'TTFinanceReport.csv'},
        content = function(file){
            write.csv(dataframeTT, file)
        }
    )
})



