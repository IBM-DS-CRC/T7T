library(RCurl)
library(httr)
library(jsonlite)
key <- "f0f14e3a-26ef-4b02-a0c5-46bc4a55b868"
secret <- "P4pA2iJ3tK5fR6cB3lV7bT3sB3dL2jT2tT2mX4yR4lH4pD5cA2"
# 

ae <- GET("https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54")
ae <- "https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string"
ae <- "https://watson.analytics.ibmcloud.com/home/data?folder=ea55e3bd-8901-4366-b657-7556df2577b5&rootFolder=shared"
ae <- "https://api.ibm.com/watsonanalytics/run/oauth2/v1/token?grant_type=string&refresh_token=string"
ae <- "https://api.ibm.com/watsonanalytics/run/oauth2/v1/token"
ae <- "https://api.ibm.com/watsonanalytics/run/data/v1/datasets/3ZPDZ2KL8DE0/permissions"

apic <- oauth_app("watsonanalytics", key, secret)
rq <- "https://api.ibm.com/watsonanalytics/run/oauth2/v1/token/requestToken"
au <- "https://api.ibm.com/watsonanalytics/run/oauth2/v1/token/authorize"
ac <- "https://api.ibm.com/watsonanalytics/run/oauth2/v1/token/accessToken"
otep <- oauth_endpoint(rq, au, ac, ae)
oauth2.0_token(endpoint =  otep, app =  apic)

GET("https://watson_analytics_api_url/watson_analytics_api_base_path/clientauth/v1/auth?")

GET("https://api.ibm.com/scx/sbs_orgaccess/customer?_pageSize=string&_namedQuery=string&emailAddress=string&_pageNumber=string")
#  ------------------------------------------------------------------------
oauth2.0_token()

ww1 <- GET("https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54")
ps <- POST("https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54")
wa1 <- GET("https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54")
ww <- GET("https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string")
ww1 <- GET("https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string")

BROWSE("https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string")
BROWSE("https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=GRJYZ6BY45JP")
BROWSE("https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54")
wa1$cookies$domain
ww$cookies$domain
ww$headers
#

req <- GET("https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string/requestToken")
autT <- GET("https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string/authorize")
accT <- GET("https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string/accessToken")
url <- "https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54"
url1 <- "https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string"
url2 <- "https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54"
otep <- oauth_endpoint(req, autT, accT, url2)
token <- oauth2.0_token(endpoint = otep, app = apic)



