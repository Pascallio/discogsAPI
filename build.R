library("devtools")
library(roxygen2)
setwd("DiscogsAPI/")
document()
setwd("..")
install("discogsAPI")



library(discogsAPI)

key <- "tOPxZAqfnnwaRMwtVnvS"
secret <- "cwARlOjMeNcKWEGRPEjvBUafrFPFhEiy"
token <- authorize(key, secret)
get_identity(token)
r <- get_release(1, token = token)
