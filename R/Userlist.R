#' Get a user's lists
#'
#'@usage get_user_lists(
#'  username,
#'  token = NA,
#'  options = list()
#')
#'
#'@param username String containing a valid username
#'@param token Token object obtained from authorize()
#'@param options (optional) List of named parameters, see Details
#'
#'@details
#'
#'@examples
get_user_lists <- function(username, token=NA, options=list()){
  url <- sprintf("%s/users/%s/lists?%s", BASE_URL, username, parse_options(options))
  return(content(get(url, token)))
}

#' Returns items from a specified List.
#'
#'@usage get_list(
#'  list_id,
#'  token = NA
#')
#'
#'@param list_id Integer identifier for a user list
#'@param token Token object obtained from authorize()
#'
#'@details
#' Private Lists will only display when authenticated as the owner.
#'@examples
get_list <- function(list_id, token=NA){
  url <- sprintf("%s/lists/%s", BASE_URL, list_id)
  return(content(get(url, token)))
}
