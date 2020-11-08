#' Retrieve release info by a given ID
#'
#'@usage get_release(
#'  release_id,
#'  options = list(),
#'  token = NA
#')
#'
#'@param release_id Integer value representing a valid release ID
#'@param options Named list containing optional params.
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'@examples
#'# Get a release
#'release <- get_release(1)
#'
#'# Retrieve marketplace data in Euros
#'release <- get_release(1, options=list("curr_abbr" = "EUR"))
#'
get_release <- function(release_id, options=list(), token=NA){
  url <- sprintf("%s/releases/%s?%s", BASE_URL, release_id, parse_options(options))
  return(content(get(url, token)))
}

#' Retrieve rating of a release by a user
#'
#'@usage get_release_rating_by_user(
#'  release_id,
#'  username,
#'  token = NA
#')
#'
#'@param release_id Integer value representing a valid release ID
#'@param username String containing a valid username
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'@examples
#'# Get a rating
#'rating <- get_release_rating_by_user(1, "username")
get_release_rating_by_user <- function(release_id, username, token=NA){
  url <- sprintf("%s/releases/%s/rating/%s", BASE_URL, release_id, username)
  return(content(get(url, token)))
}

#' Submit a rating for a release
#'
#'@usage put_release_rating(
#'  release_id,
#'  username,
#'  rating
#'  token
#')
#'
#'@param release_id Integer value representing a valid release ID
#'@param username String containing a valid username
#'@param rating Integer value between 0-5
#'@param token Token object obtained from authorize() or a string containing your personal access token
#'@examples
#'# Submit a rating
#'token <- authorize("key", "secret")
#'put_release_rating(1, "username", 5, token)
put_release_rating <- function(release_id, username, rating, token){
  url <- sprintf("%s/releases/%s/rating/%s", BASE_URL, release_id, username)
  return(put(url, rating, token))
}

#' Delete a given rating
#'
#'@usage delete_release_rating(
#'  release_id,
#'  username,
#'  token
#')
#'
#'@param release_id Integer value representing a valid release ID
#'@param username String containing a valid username
#'@param token Token object obtained from authorize() or a string containing your personal access token
#'@examples
#'# Delete a rating
#'token <- authorize("key", "secret")
#'delete_release_rating(1, "username", 5, token)
delete_release_rating <- function(release_id, username, token){
  url <- sprintf("%s/releases/%s/rating/%s", BASE_URL, release_id, username)
  return(delete(url, token))
}

#' Get the rating statistics by the community
#'
#'@usage get_community_release_rating(
#'  release_id,
#'  token = NA
#')
#'
#'@param release_id Integer value representing a valid release ID
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'@examples
#'# Retrieve the community rating
#'rating <- get_community_release_rating(1)
get_community_release_rating <- function(release_id, token=NA){
  url <- sprintf("%s/releases/%s/rating", BASE_URL, release_id)
  return(content(get(url, token)))
}

#' Get release statistics
#'
#'@usage get_release_stats(
#'  release_id,
#'  token = NA
#')
#'
#'@param release_id Integer value representing a valid release ID
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'@examples
#'# Retrieve the release statistics
#'stats <- get_release_stats(1)
get_release_stats <- function(release_id, token=NA){
  url <- sprintf("%s/releases/%s/stats", BASE_URL, release_id)
  return(content(get(url, token)))
}

#' Get a master release
#'
#'@usage get_master_release(
#'  master_id,
#'  token = NA
#')
#'
#'@param master_id Integer value representing a valid master ID
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'@examples
#'# Retrieve a master release
#'release <- get_master_release(1000)
get_master_release <- function(master_id, token=NA){
  url <- sprintf("%s/masters/%s", BASE_URL, master_id)
  return(content(get(url, token)))
}

#' Get versions of the given master release
#'
#'@usage get_master_release_versions(
#'  release_id,
#'  options = list(),
#'  token = NA
#')
#'
#'@param master_id Integer value representing a valid master ID
#'@param options (optional) Parameters, see Details
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'
#'@details
#'This function supports Pagination parameters. Below is a list of available fields.
#'\itemize{
#' \item{ __page:__ }{integer, the page you want to request; __example__: 1}
#' \item{ __per_page:__ }{integer, the number of items per page; __example__: 50}
#' \item{ __format:__ }{string, the format to filter; __example__: "Vinyl"}
#' \item{ __label:__ }{string, the label to filter; __example__: "Scorpio Music"}
#' \item{ __released:__ }{string, the release year to filter; __example__: "1992"}
#' \item{ __country:__ }{string, the country to filter; __example__: "Belgium"}
#' \item{ __sort:__ }{string, sort items by these fields: released, title, format, label, catno, country}
#' \item{ __sort_order:__ }{string, sort items in a particular order; __example__: "asc"}
#'}
#'
#'@examples
#'# Retrieve the master versions
#'stats <- get_master_release_versions(1000)
#'
#'# Retrieve the master versions with optional parameters
#'stats <- get_master_release_versions(1000,
#'         options = list("page" = 1, "per_page" = 50, "format" = "Vinyl"))
get_master_release_versions <- function(master_id, options=list(), token=NA){
  url <- sprintf("%s/masters/%s/versions?%s", BASE_URL, master_id, parse_options(options))
  return(content(get(url, token)))
}

#' Retrieve artist information
#'
#'@usage get_artist(
#'  release_id,
#'  token = NA
#')
#'
#'@param artist_id Integer value representing a valid artist ID
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'@examples
#'# Retrieve artist information
#'artist <- get_artist(1)
get_artist <- function(artist_id, token=NA){
  url <- sprintf("%s/artists/%s", BASE_URL, artist_id)
  return(content(get(url, token)))
}

#' Get releases by artist
#'
#'@usage get_artist_releases(
#'  artist_id,
#'  options = list(),
#'  token = NA
#')
#'
#'@param artist_id Integer value representing a valid artist ID
#'@param options (optional) Parameters, see Details
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'
#'@details
#'This function supports Pagination parameters. Below is a list of available fields.
#'\itemize{
#' \item{ __sort:__ }{string, sort items by these fields: year, title, format}
#' \item{ __sort_order:__ }{string, sort items in a particular order; __example__: "asc"}
#'}
#'@examples
#'# Retrieve the release statistics
#'releases <- get_artist_releases(1)
#'
#'releases <- get_artist_releases(1, options=list("sort" = "year"))
get_artist_releases <- function(artist_id, options=list(), token=NA){
  url <- sprintf("%s/artists/%s/releases?%s", BASE_URL, artist_id, parse_options(options))
  return(content(get(url, token)))
}

#' Get label information
#'
#'@usage get_label(
#'  label_id,
#'  token = NA
#')
#'
#'@param label_id Integer value representing a valid release ID
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'@examples
#'# Retrieve label information
#'label <- get_label(1)
get_label <- function(label_id, token=NA){
  url <- sprintf("%s/labels/%s", BASE_URL, label_id)
  return(content(get(url, token)))
}

#' Get all releases of a label
#'
#'@usage get_release_stats(
#'  label_id,
#'  options = list(),
#'  token = NA
#')
#'
#'@param release_id Integer value representing a valid release ID
#'@param options (optional) Parameters, see Details
#'@param token (optional) Token object obtained from authorize() or a string containing your personal access token
#'@details
#'This function supports Pagination parameters. Below is a list of available fields.
#'\itemize{
#' \item{ __page:__ }{integer, the page you want to request; __example__: 1}
#' \item{ __per_page:__ }{integer, the number of items per page; __example__: 50}
#'}
#'@examples
#'# Retrieve releases from a label
#'releases <- get_all_label_releases(1)
get_all_label_releases <- function(label_id, options=list(), token=NA){
  url <- sprintf("%s/labels/%s/releases?%s", BASE_URL, label_id, parse_options(options))
  return(content(get(url, token)))
}

#' Get release statistics
#'
#'@usage get_search(
#'  token,
#'  query = "",
#'  options = list()
#')
#'
#'@param token Token object obtained from authorize() or a string containing your personal access token
#'@param query (optional) String value of query to search
#'@param options (optional) Parameters, see Details
#'@details
#'This function supports many parameters. Below is a list of available fields, all fields are of type __string__.
#'\itemize{
#' \item{ __type:__ }{One of `release`, `master`, `artist` or `label`; __example__: "release"}
#' \item{ __title:__ }{Search by combined “Artist Name - Release Title” title field; __example__: nirvana - nevermind}
#' \item{ __release_title:__ }{Search release titles; __example__: "nevermind"}
#' \item{ __credit:__ }{Search release credits; __example__: "kurt"}
#' \item{ __artist:__ }{Search artist names; __example__: "nirvana"}
#' \item{ __anv:__ }{Search artist ANV; __example__: "nirvana"}
#' \item{ __label:__ }{Search label names; __example__: "dgc" }
#' \item{ __genre:__ }{Search genres; __example__: "rock"}
#' \item{ __style:__ }{Search styles; __example__: "grunge"}
#' \item{ __country:__ }{Search release country; __example__: "canada"}
#' \item{ __year:__ }{Search release year; __example__: "1991"}
#' \item{ __format:__ }{Search formats; __example__: "album"}
#' \item{ __catno:__ }{Search catalog number; __example__: " DGCD-24425"}
#' \item{ __barcode:__ }{Search barcodes; __example__: "7 2064-24425-2 4"}
#' \item{ __track:__ }{Search track titles; __example__: "smells like teen spirit"}
#' \item{ __submitter:__ }{Search submitter username; __example__: "milKt"}
#' \item{ __contributor:__ }{Search contributor usernames; __example__: "jerome99"}
#'}
#'@examples
#'# Retrieve the release statistics
#'token <- authorize("key", "secret")
#'results <- get_search(token, "nirvana", options=list("year" = "1991"))
#'
get_search <- function(token, query="", options=list()){
  url <- sprintf("%s/database/search?q=%s&?%s", BASE_URL, query, parse_options(options))
  return(content(get(url, token)))
}
