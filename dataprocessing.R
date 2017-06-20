#By Gerardo Salas Montoya 06-09-2017

#install.packages("readxl")
#install.packages("excel.link")

# Load required libraries
# -------------------------
require(data.table)
library(dplyr)
library(DT)
library(rCharts)
library(ggplot2)
library(plotly)
library(readr)
library(readxl)
library(excel.link)
source("dataExtraction.R")
# -------------------------

#Loading the Data Frame to the local Variable
DtFromForm <- DtFrame


## 1-Delete blanks from ID Column
DtFromForm <- DtFromForm[!(DtFromForm$id == "" | is.na(DtFromForm$id)), ]

## 2-North American Accounts

## 3-Sector Info


## 4-In Progress PCRs


## 5-Approved PCRs


## 6-Dates


## 7-Days In Progress


## 8-PCRs over 10 Days


## 9-Days since PCR was created




#Exploratory Data Analisys
ColuNames <- colnames(DtFromForm)
NumberOfRows <- length(DtFromForm$ID) #X
Sectors <- sort(unique(DtFromForm$"Sector."))
Accounts <- sort(unique(DtFromForm$"Account.Name."))


