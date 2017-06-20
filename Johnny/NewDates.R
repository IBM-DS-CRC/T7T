library(XML)
library(rjson)
library(RJSONIO)
library(httr)
library(jsonlite)
library(lubridate)


url  <- "https://w3-01.ibm.com"
path <- "https://w3-01.ibm.com/tools/cio/forms-basic/secure/org/data/98fdd9e5-4671-448a-8578-9a71a719ecc6/F_Form1?format=application/json"

raw.result <- GET(path, authenticate("johnalva@cr.ibm.com", "johALVME143"))
names(raw.result)
raw.result$status_code
head(raw.result$content)
this.raw.content <- rawToChar(raw.result$content)
nchar(this.raw.content)
substr(this.raw.content, 1, 100)
this.content <- fromJSON(this.raw.content)
class(this.content) #it's a list
length(this.content) #it's a large list
names(this.content)

df1 <- this.content$items
names(df1)

# dates -------------------------------------------------------------------

df1$F_Date1 <- as.Date(df1$F_Date1)
df1$F_Date2 <- as.Date(df1$F_Date2)
df1$F_Date3 <- as.Date(df1$F_Date3)
df1$F_Date4 <- as.Date(df1$F_Date4)
df1$F_Date7 <- as.Date(df1$F_Date7)
df1$F_todaydate <- as.data.frame(df1$F_todaydate)
df1$lastModified <- as.Date(df1$lastModified)
df1$created <- as.Date(df1$created)
df1$F_servertime <- parse_date_time(df1$F_servertime, "%m/%d/%y HM", tz = "America/Guatemala")
df1$F_servertime <- as.Date(df1$F_servertime)


df1 <- filter(df1, ID != "")

# Clean Data & Functions ---------------------------------------------------

## Selection of IMT Canada or US
df1<- subset(df, IMT. == "US" | IMT. == "Canada")

## Change sector name, Canada:
for(i in 1:nrow(df1)){
    if(df1$IMT.[i] == "Canada"){
        df1$Sector.[i] = "Canada"
    }
}

# Account= Fleetcor, the sector is “Communications” 
for(i in 1:nrow(df1)){
    if(df1$Account.Name.[i] == "Fleetcor"){
        df1$Account.Name.[i] = "Communications"
    }
}