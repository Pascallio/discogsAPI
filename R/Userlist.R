#' Get a user's lists
#'
#'@usage get_user_lists(
#'  username,
#'  token = NA,
#'  options = list()
#')
#'
#'@param username String containing a valid username
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'@param options (optional) List of named parameters, see Details
#'
#'@details
#' Returns a User’s Lists. Private Lists will only display when authenticated as the owner. Accepts Pagination parameters.
#' ## Pagination options;
#' * __page:__ integer, the page you want to request; __example__: 1
#' * __per_page:__ integer, the number of items per page; __example__: 50
#'@examples
#'user_list <- get_user_lists("username")
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
#'@param token Token object obtained from authorize() or a string containing your personal access token
#'
#'@details
#' Private Lists will only display when authenticated as the owner.
#'@examples
#'specific_list <- get_list(1)
get_list <- function(list_id, token=NA){
  url <- sprintf("%s/lists/%s", BASE_URL, list_id)
  return(content(get(url, token)))
}
