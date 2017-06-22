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

#Username and Pass for the IBM Forms, methot is curl and the app is not allowing anon connections, so we are using secure connections.
MyUser <- "kurbina@cr.ibm.com"
MyPass <- "Holahol!@#$"

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

substr(this.raw.content, 1, 135)

this.content <- fromJSON(this.raw.content)

#class(this.content) 

#length(this.content) 

this.content[[4]] #the list we need 

this.content$items

class(this.content$items)
#************************************************

#Creating the Data Frame in order to start cleaning the data, this variable will be used in the dataprocessing.R script
DtFrame <- this.content$items
#************************************************

# Changing each column name

colnames(DtFrame)[which(names(DtFrame) == "id")] <- "ID"
colnames(DtFrame)[which(names(DtFrame) == "F_SingleLine2")] <- "PCR Number"


#Converting into a Data Frame

Form_PMO<-data.frame(Form_PMO)

#Removing signs of punctuation from headers, this will help us to filter

names(Form_PMO)<- gsub("[:,' .]" ,"", names(Form_PMO))

#Creating a view without blancks ID's

Preprocessed_Form <- subset(Form_PMO, ID !="")


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
InProgress_PCRS<- subset(Preprocessed_Form, PCRState== PCR_STATE_Inprogress & TTIMApproveDate !=PCR_STATEDate_Inprogress)

## Adding a new column to see status
InProgress_PCRS$PCRs_Status<- "In Progress"


# Subsetting data in order to obtain the set that we need

Approved_PCRs <- subset(Preprocessed_Form, PCRState == "Approved" | PCRState == "PE approved, but waiting on Billing" | 
                          PCRState =="Approved and funds received" | PCRState=="Approved but waiting on billing")

#Adding the new Column to see Status

Approved_PCRs$PCRs_Status<- "Approved"



## Gives the first part of pending dataset

FirstPendingDSet<-subset(Preprocessed_Form, PCRState== PCR_STATE_Inprogress & is.na(TTIMApproveDate) == TRUE)

## Adding the column and the status
FirstPendingDSet$PCRs_Status<- "Other"

#Gives the second part of pending dataset

SecondPendingDSet <- subset(Preprocessed_Form,  PCRState != "PE approved, but waiting on Billing" & PCRState != "Approved" &
                              PCRState != PCR_STATE_Inprogress &  PCRState != "Approved and funds received" &
                              PCRState != "Approved but waiting on billing")

## Adding the column and the Status

SecondPendingDSet$PCRs_Status<- "Other"


# Merge all in one uinque archive

Semifinal_Dc<- rbind(InProgress_PCRS,Approved_PCRs, FirstPendingDSet, SecondPendingDSet)

# This will be Johnny's input 


## Solo de prueba por el momento

library(xlsx)

write.csv(Semifinal_Dc,"c:/mydata.csv")



## Watson API


URL<- https://api.ibm.com/watsonanalytics/run/oauth2/v1/config


