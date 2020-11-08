BASE_URL <- "https://api.discogs.com"

#' get a response from a request with token
#'
#'@usage get(
#'  url,
#'  token = NA
#')
#'
#'@param url
#'@param token Token object obtained from authorize()
#'
#'@details
#'This function is not supposed to used directly, but is used through other functions
#'
#'@examples
get <- function(url, token=NA){
    if (length(token) == 0 || suppressWarnings(is.na(token))){
        Sys.sleep(60 / 25)
        response <- httr::GET(url)
    } else if (typeof(token) == "character") {
        Sys.sleep(1)
        response <- httr::GET(url, add_headers(Authorization = token))
    } else {
        Sys.sleep(1)
        response <- httr::GET(url, config(token = token))
    }
    return(response)
}

#' Post request to the discogs server
#'
#'@usage post(
#'  url,
#'  content,
#'  token = NA
#')
#'
#'@param url
#'@param content
#'@param token Token object obtained from authorize()
#'
#'@details
#'
#'@examples
#'token <- authorize("key", "secret")
post <- function(url, content, token){
  return(httr::POST(url, body = content, config(token = token)))
}

#' Put request to the discogs server
#'
#'@usage put(
#'  url,
#'  content,
#'  token
#')
#'
#'@param url
#'@param content
#'@param token Token object obtained from authorize()
#'
#'@details
#'
#'@examples
#'token <- authorize("key", "secret")
put <- function(url, content, token){
  return(httr::PUT(url, body = content, config(token = token)))
}

#' Delete request to the discogs server
#'
#'@usage delete(
#'  url,
#'  token
#')
#'
#'@param url
#'@param token Token object obtained from authorize()
#'
#'@details
#'
#'@examples
#'token <- authorize("key", "secret")
delete <- function(url, token){
  return(httr::DELETE(url, config(token = token)))
}

#' parse optional parameters
#'
#'@usage parse_options(
#'  options
#')
#'
#'@param options
#'
#'@details
#'
#'@examples
parse_options <- function(options){
  if (length(options) > 0){
    options <- paste0(sapply(1:length(options), function(i){
      sprintf("%s=%s", names(options)[i], options[i])
    }), collapse = "&")
  } else {
    options = ""
  }
  return(options)
}

