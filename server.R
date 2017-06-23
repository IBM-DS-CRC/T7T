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
library(shinydashboard)
library(tibble)


shinyServer(function(input, output) {
 
    observeEvent(input$do, {
        # Download Report from IBM Form
        downloadReport()
        
        # Change Variable names
        variablenameChange(dataframeTT)
        
        # 1. Delete blanks from ID Column
        blacksRemove(dataframeTT)
        
        # 2. North American Accounts
        northAmericaAccounts(dataframeTT)
        
        # 3. Sector Info:
        setorInfo(dataframeTT)
        
        # 6. Dates:
        datesTT(dataframeTT)
        
        # 4. In Progress PCRs:
        
        
        # 5. Approved PCRs
        
        
        # 7. # Days In Progress:
        inProgress(dataframeTT)
        
        # 8. PCRs over 10 Days
        pcrOver10F(dataframeTT)
        
        # 9. Days since PCR was created:
        pcrCreated(dataframeTT)
        
        # Response once report is really to download.
        output$response <- renderText({
            "Your data is really to download"
        })
    })
    
    # Download the report from IBM Form
    downloadReport <- function(x){
        url  <- "https://w3-01.ibm.com"
        path <- "https://w3-01.ibm.com/tools/cio/forms-basic/secure/org/data/98fdd9e5-4671-448a-8578-9a71a719ecc6/F_Form1?format=application/json"
        
        raw.result <- GET(path,authenticate(input$login, input$pass))
        this.raw.content <- rawToChar(raw.result$content)
        this.content <- fromJSON(this.raw.content)
        dataframeTT <- this.content$items
        myvars <- names(dataframeTT) %in% c("lastModifiedBy", "createdBy",
                                            "F_Attachment2","F_Attachment3","F_Attachment4",
                                            "F_Attachment1", "F_Table1", 
                                            "F_Table2", "availableSubmitButtons") 
        dataframeTT <<- dataframeTT[,!myvars]
    }
    
    # Changing column names
    variablenameChange <- function(dataframeTT){
        colnames(dataframeTT)[which(names(dataframeTT) == "id")] <- "ID"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_SingleLine2")] <- "PCR Number"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_SingleLine5")] <- "PCR Title"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pcrstate")] <- "PCR State"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_currentstage")] <- "PCR Current Stage"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_PCRtobeCp")] <- "PCR # to Clone"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_DropDown7")] <- "Account Name"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_DropDown6")] <- "Sector"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_SingleLine1")] <- "TTIM Name"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_SingleLine11")] <- "XM Name"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_tsm")] <- "TSM Name"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_accountgeo")] <- "GEO"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_accountiot")] <- "Account IOT"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_accountimt")] <- "IMT"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_accountcountry")] <- "Country"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Paragraphtext1")] <- "PCR Executive Summary Statement"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_DropDown1")] <- "PCR Class"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_DropDown5")] <- "PCR Priority"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_DropDown9")] <- "PCR Tower or Function"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_SingleLine10")] <- "PCR Creator"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_SingleLine8")] <- "PCR Owner"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_DropDown10")] <- "Engagement Failure Category"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_tsvr")] <- "Found in TSVR Session?"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Date2")] <- "Estimated Start Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Date3")] <- "Estimated Finish Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Date1")] <- "Budget Start Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Date4")] <- "Budget End Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Date7")] <- "Date Identified"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency16")] <- "T&T Total"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency17")] <- "SS Total (Est)"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency18")] <- "PCR Total (USD)"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_subprojects")] <- "Sub-Projects"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency4")] <- "T&T Non-Labor Cost"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency10")] <- "T&T Labor Cost"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Number2")] <- "T&T Labor Hours"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency11")] <- "T&T Total"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency13")] <- "SS Non-Labor Cost"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency14")] <- "SS Labor Cost"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Number1")] <- "SS Labor Hours"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency15")] <- "SS Total"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency5")] <- "Total Non-Labor"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency6")] <- "Total Labor"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Number3")] <- "PCR Total - Hours"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Currency1")] <- "PCR Total (USD)"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Paragraphtext3")] <- "Detailed Summary"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Paragraphtext4")] <- "Background Information"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Paragraphtext5")] <- "Impact Assessment"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_URL1")] <- "URL"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_URL2")] <- "URL_1"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_URL3")] <- "URL_2"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_URL4")] <- "URL_3"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_initiatorcomments")] <- "Initiator Comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ttimcomments")] <- "TTIM Comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_dpecomments")] <- "DPE Comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_facomments")] <- "Contract FA Comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_solutioningcomments")] <- "Engagement Comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pecomments")] <- "PE Comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pfdcomments")] <- "Portfolio Director / T&T Portfolio Leader Comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ivpcomments")] <- "Industry VP Comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_gmcomments")] <- "GM Comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ttcomments")] <- "T&T VP / Director T&T Europe Comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_peapproval")] <- "PEs approval means s/he will or has billed the Client"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pdlcheckc2")] <- "This includes the confirmation that the new budget was HCP-D approved/certified"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pdlcheckc3")] <- "This includes the confirmation that the IMT GTS exec has provided his approval in writing"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_capincreased")] <- "CAP Increased Y/N"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_dateclientagreedtopay")] <- "Signature date when client agreed to pay"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_finalamountbilled")] <- "Final Amount Billet to Client"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_clientagreedtopaycom")] <- "Payment comments"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_name")] <- "Name"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_lastname")] <- "Last Name"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_servertime")] <- "Server Time"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_linktopcr")] <- "Link"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_originalclass")] <- "Original Class"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_currentuser")] <- "Current User NAME"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_currentuseremail")] <- "Current User EMAIL"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_recordid")] <- "RID"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ttimapprovedate")] <- "TTIM Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_todaydate")] <- "Next Approval Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_responseid")] <- "Response ID"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_PCRClassHistory")] <- "PCR Class History"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_accountinitials")] <- "Account Initials"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_xmbackup")] <- "XM-Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ttimbackup")] <- "TTIM Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_tsmbackup")] <- "TSM Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_cfm")] <- "CFM"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_cfmbackup")] <- "CFM Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_cfmapprovedate")] <- "CFM Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_buttonpressed")] <- "Button Pressed"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_dpe")] <- "DPE"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_dpebackup")] <- "DPE Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_dpeapprovedate")] <- "DPE Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pe")] <- "PE"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pebackup")] <- "PE BAckup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_peapprovedate")] <- "PE Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pfmdirector")] <- "PfM Director"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pfmdirectorbackup")] <- "Pfm Director Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pfmapprovedate")] <- "Pfm Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_pfm2ndapprovedate")] <- "Pfm 2nd Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_fsmfa")] <- "FSM/FA"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_fsmfabackup")] <- "FSM/FA BAckup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_faapprovedate")] <- "FA Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_linktothisform")] <- "Link to this form"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_solutioning")] <- "Solutioning"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_solutioningbackup")] <- "Solutioning Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_solutioningapprovedate")] <- "Solutioning Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_industryvp")] <- "Industry VP"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_industryvpbackup")] <- "Industry VP Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ivpapprovedate")] <- "Industry VP Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ttvp")] <- "T&T VP"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ttvpbackup")] <- "T&T VP Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ttvpapprovedate")] <- "T&T Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_gm")] <- "GM"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_gmbackup")] <- "GM Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_gmapprovedate")] <- "GM Approve Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Paragraphtext6")] <- "To ac"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_Paragraphtext7")] <- "To nt"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_subjectactionrequired")] <- "subject ac"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_subjectnotification")] <- "subject nt"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_contentactionrequired")] <- "content ac"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_contentnotification")] <- "content nt"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_finalapproval")] <- "PCR Final Approval Date"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_hold")] <- "Hold Date - Time"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_unhold")] <- "UnHold Date - Time"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ttie")] <- "TTIE"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ttiebackup")] <- "TTIE Backup"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_hasttie")] <- "does the account has a ttie?"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_ttie")] <- "TTIE"
        colnames(dataframeTT)[which(names(dataframeTT) == "F_impactrevenue")] <- "Is there any Impact to Revenue?"
        
        dataframeTT <<- dataframeTT
    }
    # Delete blanks from ID Column
    blacksRemove <- function(x){
        Preprocessed_Form <- subset(x, ID !="")
        dataframeTT <<- Preprocessed_Form
    }
    
    # North American Accounts
    northAmericaAccounts <- function(x){
        dataframeTT <<- subset(x, x$IMT == "US" | x$IMT == "Canada")
    }
    
    # Sector Info
    setorInfo <- function(x){
        for(i in 1:nrow(x)){
            if(x$IMT[i] == "Canada"){
                x$Sector[i] = "Canada"
            }
        }
        dataframeTT <<- x
    }
    
    # Days In Progress
    # Adding a new data with variables of  In Progres PCRs
    # Adding variables
    inProgress <- function(x){
        # Adding column
        x$daysInProgress <- as.numeric(
            as.duration(interval(x$`TTIM Approve Date`, Sys.Date())), "days")
        dataframeTT <<- x
    }
    
    # PCRs over 10 Days
    # Approved PCRs
    pcrOver10F <- function(x){
        x$pcrOver10 <- NA
        for(i in 1:nrow(x)){
            if(!is.na(x$daysInProgress)[i] & x$daysInProgress[i] > 10){
                x$pcrOver10[i] <- TRUE
            }else if(!is.na(x$daysInProgress)[i] & x$daysInProgress[i] <= 10){
                x$pcrOver10[i] <- FALSE
            }else{
                x$pcrOver10[i] <- NA
            }
        }
        dataframeTT <<- x
    }
    
    # Dates
    datesTT <- function(x){
        x$`PCR Final Approval Date` <- parse_date_time(x$`PCR Final Approval Date`, "%m/%d/%y HM", tz = "America/Guatemala")
        x$`TTIM Approve Date` <- parse_date_time(x$`TTIM Approve Date`, "%m/%d/%y HM", tz = "America/Guatemala")
        x$`Budget Start Date` <- strptime(dataframeTT$`Budget Start Date`, format = "%Y-%m-%d")
        x$`Budget End Date` <- strptime(dataframeTT$`Budget End Date`, format = "%Y-%m-%d")
        x$`Estimated Start Date` <- strptime(dataframeTT$`Estimated Start Date`, format = "%Y-%m-%d")
        x$`Estimated Finish Date` <- strptime(dataframeTT$`Estimated Finish Date`, format = "%Y-%m-%d")
        x$`Budget Start Date` <- as.Date(x$`Budget Start Date`, tz = "America/Guatemala")
        x$`Estimated Start Date` <- as.Date(x$`Estimated Start Date`, tz = "America/Guatemala")
        x$`Estimated Finish Date` <- as.Date(x$`Estimated Finish Date`, tz = "America/Guatemala")
        x$`Budget End Date` <- as.Date(x$`Budget End Date`, tz = "America/Guatemala")
        x$`Date Identified` <- as.Date(x$`Date Identified`, tz = "America/Guatemala")
        x$`Next Approval Date` <- as.Date(x$`Next Approval Date`, tz = "America/Guatemala")
        x$lastModified <- as.Date(x$lastModified, tz = "America/Guatemala")
        x$created <- as.Date(x$created, tz = "America/Guatemala")
        x$`Server Time` <- parse_date_time(x$`Server Time`, "%m/%d/%y HM", tz = "America/Guatemala")
        x$`Server Time`  <- as.Date(x$`Server Time`, tz = "America/Guatemala")
        x$`TTIM Approve Date` <- as.Date(x$`TTIM Approve Date`, tz = "America/Guatemala")
        x$`PCR Final Approval Date` <- as.Date(x$`PCR Final Approval Date`, tz = "America/Guatemala")
        
        # Month Creation
        x$`Month Budget Start Date` <- month(x$`Budget Start Date`)
        x$`Month Estimated Start Date` <- month(x$`Estimated Start Date`)
        x$`Month Estimated Finish Date` <- month(x$`Estimated Finish Date`)
        x$`Month Budget End Date` <- month(x$`Budget End Date`)
        x$`Month Date Identified` <- month(x$`Date Identified`)
        x$`Month Next Approval Date` <- month(x$`Next Approval Date`)
        x$MonthlastModified <- month(x$lastModified)
        x$Monthcreated <- month(x$created)
        x$`Month Server Time`  <- month(x$`Server Time`)
        x$`Month TTIM Approve Date` <- month(x$`TTIM Approve Date`)
        x$`Month PCR Final Approval Date` <- month(x$`PCR Final Approval Date`)

        # Year Creation
        x$`Year Budget Start Date` <- year(x$`Budget Start Date`)
        x$`Year Estimated Start Date` <- year(x$`Estimated Start Date`)
        x$`Year Estimated Finish Date` <- year(x$`Estimated Finish Date`)
        x$`Year Budget End Date` <- year(x$`Budget End Date`)
        x$`Year Date Identified` <- year(x$`Date Identified`)
        x$`Year Next Approval Date` <- year(x$`Next Approval Date`)
        x$YearlastModified <- year(x$lastModified)
        x$Yearcreated <- year(x$created)
        x$`Year Server Time`  <- year(x$`Server Time`)
        x$`Year TTIM Approve Date` <- year(x$`TTIM Approve Date`)
        x$`Year PCR Final Approval Date` <- year(x$`PCR Final Approval Date`)
        
        dataframeTT <<- x
    }
    
    # Days since PCR was created
    pcrCreated <- function(x){
        x$`PCR Created Days` <- NA
        
        for(i in 1:nrow(x)){
            if(!is.na(x$`PCR Final Approval Date`)[i]){
                x$`PCR Created Days`[i] <- as.numeric(
                    as.duration(interval(
                        x$`PCR Final Approval Date`[i], Sys.Date())), "days")
            }else{
                x$`PCR Created Days`[i] <- as.numeric(
                    as.duration(interval(
                        x$lastModified[i], Sys.Date())), "days")
            }
        }
        dataframeTT <<- x
    }

    # Button to download file:    
    output$downloadTT <- downloadHandler(
        filename = function(){'TTFinanceReport.csv'},
        content = function(file){
            write.csv(dataframeTT, file)
        }
    )
})
