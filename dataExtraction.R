library(XML)
library(rjson)
library(RJSONIO)
library(httr)
library(jsonlite)
library(lubridate)


url  <- "https://w3-01.ibm.com"
path <- "/tools/cio/forms-basic/anon/org/data/bbe9380e-6976-44ef-8475-9aaac239b01f/F_Form1?format=application/json"



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









