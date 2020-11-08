#' Get a list of releases in a user's wantlist.
#'
#'@usage get_wantlist(
#'  username,
#'  options = list(),
#'  token = NA
#')
#'
#'@param username String containing a valid username
#'@param options (optional) List of named parameters, see Details
#'@param token Token object obtained from authorize()
#'
#'@details
#'Returns the list of releases in a user’s wantlist. Accepts Pagination parameters.
#'Basic information about each release is provided, suitable for display in a list. For detailed information, make another API call to fetch the corresponding release.
#'If the wantlist has been made private by its owner, you must be authenticated as the owner to view it.
#'The notes field will be visible if you are authenticated as the wantlist owner.
#'@examples
#'wantlist <- get_wantlist("username")
#'
#'wantlist <- get_want_list("username", options = list())
get_wantlist <- function(username, options=list(), token=NA){
  url <- sprintf("%s/users/%s/wants?", BASE_URL, username, parse_options(options))
  return(content(get(url, config(token = token))))
}

#' Add a new release to your wantlist
#'
#'@usage add_to_wantlist(
#'  username,
#'  release_id,
#'  token,
#'  options = list()
#')
#'
#'@param username String containing a valid username
#'@param release_id Integer value representing a valid release ID
#'@param token Token object obtained from authorize()
#'@param options (optional) List of named parameters, see Details
#'
#'@details
#'Add a release to a user’s wantlist.
#'Authentication as the wantlist owner is required.
#'@examples
#'token <- authorize("key", "secret")
add_new_to_wantlist <- function(username, release_id, token, options=list()){
  url <- sprintf("%s/users/%s/wants/%s?%s", BASE_URL, username, release_id, parse_options(options))
  return(put(url, content="", token))
}

#' Add a release to your wantlist
#'
#'@usage add_to_wantlist(
#'  username,
#'  release_id,
#'  token,
#'  options = list()
#')
#'
#'@param username String containing a valid username
#'@param release_id Integer value representing a valid release ID
#'@param token Token object obtained from authorize()
#'@param options (optional) List of named parameters, see Details
#'
#'@details
#'Add a release to a user’s wantlist.
#'Authentication as the wantlist owner is required.
#'@examples
#'token <- authorize("key", "secret")
add_to_wantlist <- function(username, release_id, token, options=list()){
  url <- sprintf("%s/users/%s/wants/%s?%s", BASE_URL, username, release_id, parse_options(options))
  return(post(url, content="", token))
}

#' Delete a release from your wantlist
#'
#'@usage delete_from_wantlist(
#'  username,
#'  release_id,
#'  token,
#'  options = list()
#')
#'
#'@param username String containing a valid username
#'@param release_id Integer value representing a valid release ID
#'@param token Token object obtained from authorize()
#'@param options (optional) List of named parameters, see Details
#'
#'@details
#'
#'@examples
#'token <- authorize("key", "secret")
#'delete_from_wantlist("username", 1, token)
delete_from_wantlist <- function(username, release_id, token, options=list()){
  url <- sprintf("%s/users/%s/wants/%s?%s", BASE_URL, username, release_id, parse_options(options))
  return(delete(url, token))
}
