## Instaling new packages:
install.packages("excel.link")

## Calling default libraries:
library(dplyr)
library(readxl)
library(excel.link)
library(stringr)
library(plyr)
library(plyr)

## Loading file:
setwd("C:/Users/johnalva/Box Sync/IBM Finance T&T/Data Sample")
df <-xl.read.file("T&T Consolidated PCR Report8.xlsb",xl.sheet = "Raw_data")


# Clean Data --------------------------------------------------------------

## Selection of IMT Canada or US
df1<- subset(df, `IMT:` == "US" | `IMT:` == "Canada")

## Change sector name, Canada:
for(i in 1:nrow(df1)){
    if(df1$`IMT:`[i] == "Canada"){
        df1$`Sector:`[i] = "Canada"
    }
}
    
# Account= Fleetcor, the sector is “Communications” 
for(i in 1:nrow(df1)){
    if(df1$`Account Name:`[i] == "Fleetcor"){
        df1$`Account Name:`[i] = "Communications"
    }
}


# For Plotting ------------------------------------------------------------

# In Progress PCRs:
#pcrIP <- select(df1, `PCR State:`, `TTIM Approve Date:`)
pcrIP <- subset(df1, `PCR State:` == "In Progress" & `TTIM Approve Date:` != "")

# Approved PCRs:
pcrAP <- subset(df1, `PCR State:` == "Approved" | 
                    `PCR State:` == "Approved and funds received" |
                    `PCR State:` == "PE approved, but waiting on Billing")

# Dates grouped:




# Days in progress Today (-) TTIM Approve Date:


# PCRs over 10 Days, which dates should be take on this?

































