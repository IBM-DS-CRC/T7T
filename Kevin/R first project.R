# Adding the required libraries

require(xlsx)
require(data.table)


# pending the link between IBM forms and R
library(XML)
library(rjson)
library(RJSONIO)
library(httr)
library(jsonlite)
library(lubridate)
library(stringi)
library(devtools)


#Username and Pass for the IBM Forms, methot is curl and the app is not allowing anon connections, so we are using secure connections.
MyUser <- "" 
MyPass <- "" 

#********************************


#URLand Path for the IBM Forms Tool, using JSON
url  <- "https://w3-01.ibm.com"
path <- "/tools/cio/forms-basic/secure/org/data/98fdd9e5-4671-448a-8578-9a71a719ecc6/F_Form1?format=application/json"
#**********************************************

#Extracting the data from the API using GET
raw.result <- GET(url = url, path = path, authenticate(MyUser,MyPass))
#**********************************************


#Exploratory Data Analysis
Names <- names(raw.result)

rawResuld <- raw.result$status_code

headResult <- head(raw.result$content)

this.raw.content <- rawToChar(raw.result$content)

nchar(this.raw.content)

substr(this.raw.content, 1, 160)

this.content <- fromJSON(this.raw.content)

#class(this.content) 

#length(this.content) 

#this.content[[4]] #the list we need 

this.content$items

#************************************************

#Creating the Data Frame in order to start cleaning the data, this variable will be used in the dataprocessing.R script
DtFrame <- this.content$items
#************************************************



# Changing column names

colnames(DtFrame)[which(names(DtFrame) == "id")] <- "ID"

colnames(DtFrame)[which(names(DtFrame) == "F_SingleLine2")] <- "PCR Number"

colnames(DtFrame)[which(names(DtFrame) == "F_SingleLine5")] <- "PCR Title:"

colnames(DtFrame)[which(names(DtFrame) == "F_pcrstate")] <- "PCR State:"

colnames(DtFrame)[which(names(DtFrame) == "F_currentstage")] <- "PCR Current Stage:"

colnames(DtFrame)[which(names(DtFrame) == "F_PCRtobeCp")] <- "PCR # to Clone:"

colnames(DtFrame)[which(names(DtFrame) == "F_DropDown7")] <- "Account Name:"

colnames(DtFrame)[which(names(DtFrame) == "F_DropDown6")] <- "Sector:"

colnames(DtFrame)[which(names(DtFrame) == "F_SingleLine1")] <- "TTIM Name:"

colnames(DtFrame)[which(names(DtFrame) == "F_SingleLine11")] <- "XM Name:"

colnames(DtFrame)[which(names(DtFrame) == "F_tsm")] <- "TSM Name:"

colnames(DtFrame)[which(names(DtFrame) == "F_accountgeo")] <- "GEO:"

colnames(DtFrame)[which(names(DtFrame) == "F_accountiot")] <- "Account IOT:"

colnames(DtFrame)[which(names(DtFrame) == "F_accountimt")] <- "IMT:"

colnames(DtFrame)[which(names(DtFrame) == "F_accountcountry")] <- "Country:"

colnames(DtFrame)[which(names(DtFrame) == "F_Paragraphtext1")] <- "PCR Executive Summary Statement:"

colnames(DtFrame)[which(names(DtFrame) == "F_DropDown1")] <- "PCR Class:"

colnames(DtFrame)[which(names(DtFrame) == "F_DropDown5")] <- "PCR Priority:"

colnames(DtFrame)[which(names(DtFrame) == "F_DropDown9")] <- "PCR Tower or Function:"

colnames(DtFrame)[which(names(DtFrame) == "F_SingleLine10")] <- "PCR Creator:"

colnames(DtFrame)[which(names(DtFrame) == "F_SingleLine8")] <- "PCR Owner:"

colnames(DtFrame)[which(names(DtFrame) == "F_DropDown10")] <- "Engagement Failure Category:"

colnames(DtFrame)[which(names(DtFrame) == "F_tsvr")] <- "Found in TSVR Session?"

colnames(DtFrame)[which(names(DtFrame) == "F_Date2")] <- "Estimated Start Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_Date3")] <- "Estimated Finish Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_Date1")] <- "Budget Start Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_Date4")] <- "Budget End Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_Date7")] <- "Date Identified:"

colnames(DtFrame)[which(names(DtFrame) == "F_Table1")] <- "Cost Summary"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency16")] <- "T&T Total:"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency17")] <- "SS Total (Est):"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency18")] <- "PCR Total (USD):"

colnames(DtFrame)[which(names(DtFrame) == "F_subprojects")] <- "Sub-Projects:"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency4")] <- "T&T Non-Labor Cost"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency10")] <- "T&T Labor Cost"

colnames(DtFrame)[which(names(DtFrame) == "F_Number2")] <- "T&T Labor Hours"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency11")] <- "T&T Total"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency13")] <- "SS Non-Labor Cost"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency14")] <- "SS Labor Cost"

colnames(DtFrame)[which(names(DtFrame) == "F_Number1")] <- "SS Labor Hours"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency15")] <- "SS Total"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency5")] <- "Total Non-Labor"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency6")] <- "Total Labor"

colnames(DtFrame)[which(names(DtFrame) == "F_Number3")] <- "PCR Total - Hours"

colnames(DtFrame)[which(names(DtFrame) == "F_Currency1")] <- "PCR Total (USD)"

colnames(DtFrame)[which(names(DtFrame) == "F_Paragraphtext3")] <- "Detailed Summary:"

colnames(DtFrame)[which(names(DtFrame) == "F_Paragraphtext4")] <- "Background Information:"

colnames(DtFrame)[which(names(DtFrame) == "F_Paragraphtext5")] <- "Impact Assessment:"

colnames(DtFrame)[which(names(DtFrame) == "F_Attachment1")] <- "Attachment"

colnames(DtFrame)[which(names(DtFrame) == "F_Attachment2")] <- "Attachment_1"

colnames(DtFrame)[which(names(DtFrame) == "F_Attachment3")] <- "Attachment_2"

colnames(DtFrame)[which(names(DtFrame) == "F_Attachment4")] <- "Attachment_3"

colnames(DtFrame)[which(names(DtFrame) == "F_URL1")] <- "URL"

colnames(DtFrame)[which(names(DtFrame) == "F_URL2")] <- "URL_1"

colnames(DtFrame)[which(names(DtFrame) == "F_URL3")] <- "URL_2"

colnames(DtFrame)[which(names(DtFrame) == "F_URL4")] <- "URL_3"

colnames(DtFrame)[which(names(DtFrame) == "F_initiatorcomments")] <- "Initiator Comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_ttimcomments")] <- "TTIM Comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_dpecomments")] <- "DPE Comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_facomments")] <- "Contract FA Comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_solutioningcomments")] <- "Engagement Comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_pecomments")] <- "PE Comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_pfdcomments")] <- "Portfolio Director / T&T Portfolio Leader Comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_ivpcomments")] <- "Industry VP Comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_gmcomments")] <- "GM Comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_ttcomments")] <- "T&T VP / Director T&T Europe Comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_peapproval")] <- "PEs approval means s/he will or has billed the Client."

colnames(DtFrame)[which(names(DtFrame) == "F_pdlcheckc2")] <- "This includes the confirmation that the new budget was HCP-D approved/certified."

colnames(DtFrame)[which(names(DtFrame) == "F_pdlcheckc3")] <- "This includes the confirmation that the IMT GTS exec has provided his approval in writing."

colnames(DtFrame)[which(names(DtFrame) == "F_capincreased")] <- "CAP Increased Y/N"

colnames(DtFrame)[which(names(DtFrame) == "F_dateclientagreedtopay")] <- "Signature date when client agreed to pay:"

colnames(DtFrame)[which(names(DtFrame) == "F_finalamountbilled")] <- "Final Amount Billet to Client:"

colnames(DtFrame)[which(names(DtFrame) == "F_clientagreedtopaycom")] <- "Payment comments:"

colnames(DtFrame)[which(names(DtFrame) == "F_name")] <- "Name:"

colnames(DtFrame)[which(names(DtFrame) == "F_lastname")] <- "Last Name:"

colnames(DtFrame)[which(names(DtFrame) == "F_servertime")] <- "Server Time:"

colnames(DtFrame)[which(names(DtFrame) == "F_linktopcr")] <- "Link"

colnames(DtFrame)[which(names(DtFrame) == "F_originalclass")] <- "Original Class:"

colnames(DtFrame)[which(names(DtFrame) == "F_currentuser")] <- "Current User NAME:"

colnames(DtFrame)[which(names(DtFrame) == "F_currentuseremail")] <- "Current User EMAIL:"

colnames(DtFrame)[which(names(DtFrame) == "F_recordid")] <- "RID"

colnames(DtFrame)[which(names(DtFrame) == "F_ttimapprovedate")] <- "TTIM Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_todaydate")] <- "Next Approval Date"

colnames(DtFrame)[which(names(DtFrame) == "F_responseid")] <- "Response ID"

colnames(DtFrame)[which(names(DtFrame) == "F_PCRClassHistory")] <- "PCR Class History"

colnames(DtFrame)[which(names(DtFrame) == "F_accountinitials")] <- "Account Initials"

colnames(DtFrame)[which(names(DtFrame) == "F_xmbackup")] <- "XM-Backup:"

colnames(DtFrame)[which(names(DtFrame) == "F_ttimbackup")] <- "TTIM Backup:"

colnames(DtFrame)[which(names(DtFrame) == "F_tsmbackup")] <- "TSM Backup:"

colnames(DtFrame)[which(names(DtFrame) == "F_cfm")] <- "CFM:"

colnames(DtFrame)[which(names(DtFrame) == "F_cfmbackup")] <- "CFM Backup:"

colnames(DtFrame)[which(names(DtFrame) == "F_cfmapprovedate")] <- "CFM Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_buttonpressed")] <- "Button Pressed:"

colnames(DtFrame)[which(names(DtFrame) == "F_dpe")] <- "DPE:"

colnames(DtFrame)[which(names(DtFrame) == "F_dpebackup")] <- "DPE Backup:"

colnames(DtFrame)[which(names(DtFrame) == "F_dpeapprovedate")] <- "DPE Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_pe")] <- "PE:"

colnames(DtFrame)[which(names(DtFrame) == "F_pebackup")] <- "PE BAckup:"

colnames(DtFrame)[which(names(DtFrame) == "F_peapprovedate")] <- "PE Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_pfmdirector")] <- "PfM Director:"

colnames(DtFrame)[which(names(DtFrame) == "F_pfmdirectorbackup")] <- "Pfm Director Backup:"

colnames(DtFrame)[which(names(DtFrame) == "F_pfmapprovedate")] <- "Pfm Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_pfm2ndapprovedate")] <- "Pfm 2nd Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_fsmfa")] <- "FSM/FA:"

colnames(DtFrame)[which(names(DtFrame) == "F_fsmfabackup")] <- "FSM/FA BAckup:"

colnames(DtFrame)[which(names(DtFrame) == "F_faapprovedate")] <- "FA Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_linktothisform")] <- "Link to this form:"

colnames(DtFrame)[which(names(DtFrame) == "F_solutioning")] <- "Solutioning:"

colnames(DtFrame)[which(names(DtFrame) == "F_solutioningbackup")] <- "Solutioning Backup:"

colnames(DtFrame)[which(names(DtFrame) == "F_solutioningapprovedate")] <- "Solutioning Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_industryvp")] <- "Industry VP:"

colnames(DtFrame)[which(names(DtFrame) == "F_industryvpbackup")] <- "Industry VP Backup:"

colnames(DtFrame)[which(names(DtFrame) == "F_ivpapprovedate")] <- "Industry VP Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_ttvp")] <- "T&T VP:"

colnames(DtFrame)[which(names(DtFrame) == "F_ttvpbackup")] <- "T&T VP Backup:"

colnames(DtFrame)[which(names(DtFrame) == "F_ttvpapprovedate")] <- "T&T Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_gm")] <- "GM:"

colnames(DtFrame)[which(names(DtFrame) == "F_gmbackup")] <- "GM Backup:"

colnames(DtFrame)[which(names(DtFrame) == "F_gmapprovedate")] <- "GM Approve Date:"

colnames(DtFrame)[which(names(DtFrame) == "F_Paragraphtext6")] <- "To ac"

colnames(DtFrame)[which(names(DtFrame) == "F_Paragraphtext7")] <- "To nt"

colnames(DtFrame)[which(names(DtFrame) == "F_subjectactionrequired")] <- "subject ac"

colnames(DtFrame)[which(names(DtFrame) == "F_subjectnotification")] <- "subject nt"

colnames(DtFrame)[which(names(DtFrame) == "F_contentactionrequired")] <- "content ac"

colnames(DtFrame)[which(names(DtFrame) == "F_contentnotification")] <- "content nt"

colnames(DtFrame)[which(names(DtFrame) == "F_finalapproval")] <- "PCR Final Approval Date"

colnames(DtFrame)[which(names(DtFrame) == "F_hold")] <- "Hold Date - Time:"

colnames(DtFrame)[which(names(DtFrame) == "F_unhold")] <- "UnHold Date - Time:"

colnames(DtFrame)[which(names(DtFrame) == "F_ttie")] <- "TTIE"

colnames(DtFrame)[which(names(DtFrame) == "F_ttiebackup")] <- "TTIE Backup"

colnames(DtFrame)[which(names(DtFrame) == "F_hasttie")] <- "does the account has a ttie?"

colnames(DtFrame)[which(names(DtFrame) == "F_ttie")] <- "TTIE"

colnames(DtFrame)[which(names(DtFrame) == "F_impactrevenue")] <- "Is there any Impact to Revenue?"



## Needs to be updated



myvars <- names(DtFrame) %in% c("lastModifiedBy", "createdBy", "Attachment",
                            "Attachment_1","Attachment_2","Attachment_3", 
                            "createdBy", "F_Table1", "F_Table2", "availableSubmitButtons",
                            "Cost Summary")

DtFrame <- DtFrame [,!myvars]



#Removing signs of punctuation from headers, this will help us to filter

names(DtFrame)<- gsub("[:]" ,"", names(DtFrame))

#Creating a view without blancks ID's

Preprocessed_Form <- subset(DtFrame, ID !="")


#Selecting IMT US and Canada

Preprocessed_Form<- subset(Preprocessed_Form, Preprocessed_Form$IMT == "US" | Preprocessed_Form$IMT == "Canada")



# Changing the sector name for Canada when IMT is Canada

for(i in 1:nrow(Preprocessed_Form)){
  if(Preprocessed_Form$IMT[i] == "Canada"){
   Preprocessed_Form$Sector[i] = "Canada"
  }
}



# Adding a new data with variables of  In Progres PCRs
# Adding variables
PCR_STATE_Inprogress<- "In Progress"
PCR_STATEDate_Inprogress<-""

# Subsetting data in order to obtain the set that we need
InProgress_PCRS<- subset(Preprocessed_Form, `PCR State`== PCR_STATE_Inprogress & `TTIM Approve Date`!=PCR_STATEDate_Inprogress)

## Adding a new column to see status
InProgress_PCRS$PCRs_Status<- "In Progress"




# Subsetting data in order to obtain the set that we need

Approved_PCRs <- subset(Preprocessed_Form, `PCR State` == "Approved" | `PCR State` == "PE approved, but waiting on Billing" | 
                          `PCR State` =="Approved and funds received" | `PCR State`=="Approved but waiting on billing")

#Adding the new Column to see Status

Approved_PCRs$PCRs_Status<- "Approved"





## Gives the first part of pending dataset

Preprocessed_Form$`TTIM Approve Date`<- as.character(Preprocessed_Form$`TTIM Approve Date`)

FirstPendingSet<-subset(Preprocessed_Form, `PCR State`== PCR_STATE_Inprogress & Preprocessed_Form$`TTIM Approve Date` =="")

## Adding the column and the status

FirstPendingSet$PCRs_Status<- "Other"



#Gives the second part of pending dataset

SecondPendingDSet <- subset(Preprocessed_Form,  `PCR State` != "PE approved, but waiting on Billing" & `PCR State` != "Approved" &
                              `PCR State` != PCR_STATE_Inprogress &  `PCR State` != "Approved and funds received" &
                              `PCR State` != "Approved but waiting on billing")

## Adding the column and the Status

SecondPendingDSet$PCRs_Status<- "Other"



# Merge all in one uinque archive

DtFrame<- rbind(InProgress_PCRS,Approved_PCRs, FirstPendingSet, SecondPendingDSet)


# This will be Johnny's input 







## Solo de prueba por el momento

library(xlsx)

write.xlsx(DtFrame,"c:/mydata1.xlsx")





## Watson API


