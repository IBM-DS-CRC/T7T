#Starting with the Library
library(rjson)
library(RJSONIO)
library(httr)
library(jsonlite)
library(lubridate)
#*************************

#Username and Pass for the IBM Forms, methot is curl and the app is not allowing anon connections, so we are using secure connections.
MyUser <- "User@cr.ibm.com" #From Shiny interface
MyPass <- "HolaPapitos785+" #From Shiny interface

#********************************


#URLand Path for the IBM Forms Tool, using JSON
url  <- "https://w3-01.ibm.com"
path <- "/tools/cio/forms-basic/secure/org/data/bbe9380e-6976-44ef-8475-9aaac239b01f/F_Form1?format=application/json"
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

