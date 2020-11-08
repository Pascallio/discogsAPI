#' Retrieve basic information about the authenticated user.
#'
#'@usage get_identity(
#'  token
#')
#'
#'@param token Token object obtained from authorize()
#'
#'@details
#'You can use this resource to find out who you’re authenticated as,
#'and it also doubles as a good sanity check to ensure that you’re using OAuth correctly.
#'This function does not work with a personalized token, but only using OAuth.
# For more detailed information, make another request for the user’s Profile.
#'@examples
#'token <- authorize("key", "secret")
#'get_identity(token)

get_identity <- function(token){
  url = sprintf("%s/oauth/identity", BASE_URL)
  return(content(get(url, token)))
}

#' Retrieve a user profile by username.
#'
#'@usage get_profile(
#'  username,
#'  token
#')
#'
#'@param username String containing a valid username
#'@param token Token object obtained from authorize()
#'
#'@details
#'If authenticated as the requested user, the email key will be visible,
#'and the num_list count will include the user’s private lists.
#'If authenticated as the requested user or the user’s collection/wantlist is public,
#'the num_collection / num_wantlist keys will be visible.
#'@examples
#'token <- authorize("key", "secret")
#'profile <- get_profile("name", token)
get_profile <- function(username, token){
  url = sprintf("%s/users/%s", BASE_URL, username)
  return(content(get(url, config(token = token))))
}

#' Edit a user’s profile data.
#'
#'@usage edit_profile(
#'  username,
#'  token,
#'  options = list()
#')
#'
#'@param username String containing a valid username
#'@param token Token object obtained from authorize()
#'@param options (optional) Parameters, see Details
#'
#'@details
#'Authentication as the user is required.
#'For options, the following parameters are allowed:
#' * __name__: The real name of the user.
#' * __home_page__: The user’s website.
#' * __location__: The geographical location of the user.
#' * __profile__: Biographical information about the user.
#' * __curr_abbr__: Currency for marketplace data.
#'
#'@examples
#'token <- authorize("key", "secret")
#'edit_profile("name", token, options = list("home_page" = "www.discogs.com"))
edit_profile <- function(username, token, options=list()){
  url = sprintf("%s/users/%s?%s", BASE_URL, username, parse_options(options))
  return(post(url, config(token = token)))
}

#' Retrieve a user’s submissions by username.
#'
#'@usage get_user_submissions(
#'  username,
#'  token = NA,
#'  options = list()
#')
#'
#'@param username String containing a valid username
#'@param token (optional) Token object obtained from authorize()
#'@param options (optional) Named list with optional parameters, see Details
#'
#'@details
#'Accepts Pagination parameters. Below is a list of available fields.
#' * __page:__ integer, the page you want to request; __example__: 1
#' * __per_page:__ integer, the number of items per page; __example__: 50
#'@examples
#'submissions <- geT_user_submissions("username", options = list("page" = 2))
get_user_submissions <- function(username, token=NA, options=list()){
  url = sprintf("%s/users/%s", BASE_URL, username, parse_options(options))
  return(post(url, config(token = token)))
}

#' Retrieve a user’s contributions by username.
#'
#'@usage get_user_contributions(
#'  username,
#'  options = list(),
#'  token = NA
#')
#'
#'@param username String containing a valid username
#'@param options (optional) Parameters, see Details
#'@param token (optional) Token object obtained from authorize()
#'
#'@details
#'Accepts Pagination parameters. Below is a list of available fields.
#' * __page:__ integer, the page you want to request; __example__: 1
#' * __per_page:__ integer, the number of items per page; __example__: 50
#'
#'@examples
#'contributions <- geT_user_contributions("username", options = list("page" = 2, "per_page" = 50))
get_user_contributions <- function(username, options=list(), token=NA){
  url = sprintf("%s/users/%s?%s", BASE_URL, username, parse_options(options))
  return(post(url, config(token = token)))
}
