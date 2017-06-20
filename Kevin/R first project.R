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


url  <- "https://w3-01.ibm.com"
path <- "https://w3-01.ibm.com/tools/cio/forms-basic/secure/org/data/bbe9380e-6976-44ef-8475-9aaac239b01f/F_Form1?format=application/json"


Res<- get(path, authenticate("kurbina@cr.ibm.com", "Holahol!@#$"))

raw.result <- GET(url = url, path = path)


names(raw.result)

raw.result$status_code

head(raw.result$content)

this.raw.content <- rawToChar(raw.result$content)

nchar(this.raw.content)

substr(this.raw.content, 1, 100)

this.content <- fromJSON(this.raw.content)

class(this.content) #it's a list

length(this.content) #it's a large list

this.content[[4]] #the list

this.content$items

class(this.content$items)

DtFrame <- this.content$items






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

