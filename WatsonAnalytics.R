library(RCurl)
library(httr)
library(jsonlite)
# key <- "f0f14e3a-26ef-4b02-a0c5-46bc4a55b868"
# secret <- "P4pA2iJ3tK5fR6cB3lV7bT3sB3dL2jT2tT2mX4yR4lH4pD5cA2"
# 
# wa <- oauth_endpoint("requestToken", "authorize", "accessToken",
#                            base_url = "https://api.ibm.com/watsonanalytics/run/oauth2/v1/token")
# url <- "https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=GRJYZ6BY45JP"
# aut <- authenticate("johnalva@cr.ibm.com", "johALVME143", type = "basic")
# autapp <- oauth_app("watsonanalytics", key = key, secret = secret)
# 
# tk <- oauth1.0_token(endpoint = wa, app = "watsonanalytics")
# #
# 
# ae <- "https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54"
# apic <- oauth_app("watsonanalytics", key, secret)
# rq <- "https://api.ibm.com/watsonanalytics/run/oauth2/v1/token/requestToken"
# au <- "https://api.ibm.com/watsonanalytics/run/oauth2/v1/token/authorize"
# ac <- "https://api.ibm.com/watsonanalytics/run/oauth2/v1/token/accessToken"
# otep <- oauth_endpoint(rq, au, ac, ae)
# 
# token <- oauth1.0_token(otep, apic)
# 
# oauth2.0_token(endpoint =  otep, app =  "watson.analytics")

ww1 <- GET("https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54")
ww1$all_headers



GET("https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54",config = authenticate("johnalva@cr.ibm.com", "johALVME143"))
ww <- GET("https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string")
ww1 <- GET("https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string")

BROWSE("https://w3id.sso.ibm.com/isam/oidc/endpoint/amapp-runtime-oidcidp/authorize?client_id=YjlhYTU1YzEtMTBkYy00&scope=openid&response_type=code&redirect_uri=https%3A%2F%2Fwatson.analytics.ibmcloud.com%3A443%2Fwatsonanalytics%2Fopenid%2Fcode%2Fw3id&state=string")
BROWSE("https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=GRJYZ6BY45JP")
BROWSE("https://watson.analytics.ibmcloud.com/?loginAccountId=3ZPDZ2KL8DE0&loginTenantId=Q1OQDI7I0T3X54")



ww$headers
#

#  ------------------------------------------------------------------------

apic <- oauth_app("trello", "d00e8afb53f716936477840488ad72f5", "7e46b4cff5903e5c74d88cc26fa262a1b347edacfabe7b95157f6ca52c67aa7f")

rq <- "https://trello.com/1/OAuthGetRequestToken"
au <- "https://trello.com/1/OAuthAuthorizeToken"
ac <- "https://trello.com/1/OAuthGetAccessToken"
otep <- oauth_endpoint(rq, au, ac, ae)

my_token <- oauth1.0_token(otep, apic)
req <- httr::GET(ae, my_token, paging = TRUE)
json <- httr::content(req, paging = TRUE)
ibd2 <- get_id_board(ae, my_token)

