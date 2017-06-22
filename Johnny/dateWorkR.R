library(dplyr)
library(rjson)
library(lubridate)
library(dplyr)

setwd("C:/Users/johnalva/Box Sync/IBM Finance T&T/Data Sample")
dfT <- read.csv("F_Form1-106.csv")
dim(dfT)
df1 <- filter(df, ID != "")

# Clean Data & Functions ---------------------------------------------------

## Selection of IMT Canada or US
df1<- subset(df, IMT. == "US" | IMT. == "Canada")

## Change sector name, Canada:
for(i in 1:nrow(df1)){
    if(df1$IMT.[i] == "Canada"){
        df1$Sector.[i] = "Canada"
    }
}

# Account= Fleetcor, the sector is “Communication” 
for(i in 1:nrow(df1)){
    if(df1$Account.Name.[i] == "Fleetcor"){
        df1$Account.Name.[i] = "Communications"
    }
}

# Dates -------------------------------------------------------------------

# Creation of new data frame
df2 <- df1

dateFix <- function(d1){
    d2 <- parse_date_time(d1, "%m/%d/%y HM", tz = "America/Guatemala")
    return(d2)
}

dim(df1)

# Clean dates
df2$Creation.Timestamp <- dateFix(df2$Creation.Timestamp)
df2$Last.Updated.Timestamp <- dateFix(df2$Last.Updated.Timestamp)
df2$Server.Time. <- dateFix(df2$Server.Time.)
df2$TTIM.Approve.Date. <- dateFix(df2$TTIM.Approve.Date.)
df2$DPE.Approve.Date. <- dateFix(df2$DPE.Approve.Date.)
df2$PCR.Final.Approval.Date <- dateFix(df2$PCR.Final.Approval.Date)
df2$Budget.End.Date. <- strptime(df2$Budget.End.Date., format = "%Y-%m-%d")
df2$Budget.Start.Date. <- strptime(df2$Budget.Start.Date., format = "%Y-%m-%d")

## Pass to same format. as.Date:
df2$Creation.Timestamp <- as.Date(df2$Creation.Timestamp)
df2$Last.Updated.Timestamp <- as.Date(df2$Last.Updated.Timestamp)
df2$Server.Time. <- as.Date(df2$Server.Time.)
df2$TTIM.Approve.Date. <- as.Date(df2$TTIM.Approve.Date.)
df2$DPE.Approve.Date. <- as.Date(df2$DPE.Approve.Date.)
df2$Estimated.Finish.Date. <- as.Date(df2$Estimated.Finish.Date.)
df2$Estimated.Start.Date. <- as.Date(df2$Estimated.Start.Date.)
df2$Budget.Start.Date. <- as.Date(df2$Budget.Start.Date.)
df2$Budget.End.Date. <- as.Date(df2$Budget.End.Date.)
df2$Date.Identified. <- as.Date(df2$Date.Identified.)
df2$Next.Approval.Date <- as.Date(df2$Next.Approval.Date)
df2$Server.Time. <- as.Date(df2$Server.Time.)
df2$TTIM.Approve.Date. <- as.Date(df2$TTIM.Approve.Date.)
df2$DPE.Backup. <- as.Date(df2$DPE.Approve.Date.)
df2$PCR.Final.Approval.Date <- as.Date(df2$PCR.Final.Approval.Date)

# Month Creation -----------------------------------------------------------

df2$monthCreation.Timestamp <- month(df2$Creation.Timestamp)
df2$monthLast.Updated.Timestamp <- month(df2$Last.Updated.Timestamp)
df2$monthServer.Time. <- month(df2$Server.Time.)
df2$monthTTIM.Approve.Date. <- month(df2$TTIM.Approve.Date.)
df2$monthDPE.Approve.Date. <- month(df2$DPE.Approve.Date.)
df2$monthEstimated.Finish.Date. <- month(df2$Estimated.Finish.Date.)
df2$monthEstimated.Start.Date. <- month(df2$Estimated.Start.Date.)
df2$monthBudget.Start.Date. <- month(df2$Budget.Start.Date.)
df2$monthBudget.End.Date. <- month(df2$Budget.End.Date.)
df2$monthDate.Identified. <- month(df2$Date.Identified.)
df2$monthNext.Approval.Date <- month(df2$Next.Approval.Date)
df2$monthServer.Time. <- month(df2$Server.Time.)
df2$monthTTIM.Approve.Date. <- month(df2$TTIM.Approve.Date.)
df2$monthDPE.Backup. <- month(df2$DPE.Approve.Date.)
df2$monthPCR.Final.Approval.Date <- month(df2$PCR.Final.Approval.Date)

# Year Creation -----------------------------------------------------------

df2$yearCreation.Timestamp <- year(df2$Creation.Timestamp)
df2$yearLast.Updated.Timestamp <- year(df2$Last.Updated.Timestamp)
df2$yearServer.Time. <- year(df2$Server.Time.)
df2$yearTTIM.Approve.Date. <- year(df2$TTIM.Approve.Date.)
df2$yearDPE.Approve.Date. <- year(df2$DPE.Approve.Date.)
df2$yearEstimated.Finish.Date. <- year(df2$Estimated.Finish.Date.)
df2$yearEstimated.Start.Date. <- year(df2$Estimated.Start.Date.)
df2$yearBudget.Start.Date. <- year(df2$Budget.Start.Date.)
df2$yearBudget.End.Date. <- year(df2$Budget.End.Date.)
df2$yearDate.Identified. <- year(df2$Date.Identified.)
df2$yearNext.Approval.Date <- year(df2$Next.Approval.Date)
df2$yearServer.Time. <- year(df2$Server.Time.)
df2$yearTTIM.Approve.Date. <- year(df2$TTIM.Approve.Date.)
df2$yearDPE.Backup. <- year(df2$DPE.Approve.Date.)
df2$yearPCR.Final.Approval.Date <- year(df2$PCR.Final.Approval.Date)

# Adding column Days in progress
df2$daysInProgress <- as.numeric(
    as.duration(interval(df2$TTIM.Approve.Date., Sys.Date())), "days")

# Adding column PCR over than 10
df2$pcrOver10 <- NA

for(i in 1:nrow(df2)){
    if(!is.na(df2$daysInProgress)[i] & df2$daysInProgress[i] > 10){
        df2$pcrOver10[i] <- TRUE
    }else if(!is.na(df2$daysInProgress)[i] & df2$daysInProgress[i] <= 10){
        df2$pcrOver10[i] <- FALSE
    }else{
        df2$pcrOver10[i] <- NA
    }
}

# Adding Column of Days since PCR was Created

df2$pcrCreatedDays <- NA

for(i in 1:nrow(df2)){
    if(!is.na(df2$PCR.Final.Approval.Date)[i]){
        df2$pcrCreatedDays[i] <- as.numeric(
            as.duration(interval(
                df2$PCR.Final.Approval.Date[i], Sys.Date())), "days")
    }else{
        df2$pcrCreatedDays[i] <- as.numeric(
            as.duration(interval(
                df2$Last.Updated.Timestamp[i], Sys.Date())), "days")
    }
}


























