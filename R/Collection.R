#' Retrieve a list of folders in a user’s collection.
#'
#'@usage get_collection(
#'  username,
#'  token = NA
#')
#'
#'@param username String containing a valid username
#'@param token Token object obtained from authorize()
#'
#'@details
#'If the collection has been made private by its owner, authentication as the collection owner is required.
#'If you are not authenticated as the collection owner, only folder ID 0 (the “All” folder) will be visible
#'(if the requested user’s collection is public).
#'@examples
#'token <- authorize("key", "secret")
#'collection <- get_collection("username", token)
get_collection <- function(username, token=NA){
  url <- sprintf("%s/users/%s/collection/folders", BASE_URL, username)
  return(content(get(url, config(token = token))))
}

#' Create a new folder in your collection
#'
#'@usage create_collection_folder(
#'  username,
#'  token,
#'  name = ""
#')
#'
#'@param username String containing a valid username
#'@param token Token object obtained from authorize()
#'@param name (optional) Name for the folder
#'
#'@details
#'Authentication as the collection owner is required.
#'@examples
#'token <- authorize("key", "secret")
#'create_collection_folder("username", token, "my_folder")
create_collection_folder <- function(username, token, name=""){
  url <- sprintf("%s/users/%s/collection/folders", BASE_URL, username)
  return(post(url, content = name, config(token = token)))
}

#' Retrieve metadata about a folder in a user’s collection.
#'
#'@usage get_collection_folder(
#'  username,
#'  folder_id,
#'  token = NA
#')
#'
#'@param username String containing a valid username
#'@param folder_id Valid identifier for a folder
#'@param token Token object obtained from authorize()
#'
#'@details
#'If folder_id is not 0, authentication as the collection owner is required.
#'@examples
#'token <- authorize("key", "secret")
#'folder <- get_collection_folder("username", 0, token)
get_collection_folder <- function(username, folder_id, token=NA){
  url <- sprintf("%s/users/%s/collection/folders/%s", BASE_URL, username, folder_id)
  return(content(get(url, config(token = token))))
}

#' Edit a folder’s metadata.
#'
#'@usage edit_collection_folder(
#'  username,
#'  folder_id
#'  token,
#'  name = ""
#')
#'
#'@param username String containing a valid username
#'@param folder_id Valid identifier for a folder
#'@param token Token object obtained from authorize()
#'@param name (optional) Name for the folder
#'
#'@details
#'Folders 0 and 1 cannot be renamed.
#'Authentication as the collection owner is required.
#'@examples
#'token <- authorize("key", "secret")
#'edit_collection_folder("username", 3, token, name = "new_folder_name")
edit_collection_folder <- function(username, folder_id, token, name=""){
  url <- sprintf("%s/users/%s/collection/folders/%s", BASE_URL, username, folder_id)
  return(post(url, content = name, config(token = token)))
}

#' Delete a folder from a user’s collection.
#'
#'@usage delete_collection_folder(
#'  username,
#'  folder_id
#'  token,
#')
#'
#'@param username String containing a valid username
#'@param folder_id Valid identifier for a folder
#'@param token Token object obtained from authorize()
#'
#'@details
#'A folder must be empty before it can be deleted.
#'Authentication as the collection owner is required.
#'@examples
#'token <- authorize("key", "secret")
#'delete_collection_folder("username", 1, token)

delete_collection_folder <- function(username, folder_id, token){
  url <- sprintf("%s/users/%s/collection/folders/%s", BASE_URL, username, folder_id)
  return(delete(url, config(token = token)))
}

#' Get collection items by release
#'
#'@usage get_collection_items_by_release(
#'  username,
#'  release_id
#'  token = NA
#')
#'
#'@param username String containing a valid username
#'@param release_id Integer value representing a valid release ID
#'@param token (optional) Token object obtained from authorize()
#'
#'@details
#'View the user’s collection folders which contain a specified release.
#'This will also show information about each release instance.
#'
#'The release_id must be non-zero.
#'
#'Authentication as the collection owner is required if the owner’s collection is private.

#'@examples
#'items <- get_collection_items_by_release("username", 1000)
get_collection_items_by_release <- function(username, release_id, token=NA){
  url <- sprintf("%s/users/%s/collection/release/%s", BASE_URL, username, release_id)
  return(content(get(url, config(token = token))))
}

#' Collection Items By Folder
#'
#'@usage get_collection_items_by_folder(
#'  username,
#'  folder_id,
#'  options = list(),
#'  token = NA
#')
#'
#'@param username String containing a valid username
#'@param folder_id Valid identifier for a folder
#'@param options (optional) List of named parameters, see Details
#'@param token (optional) Token object obtained from authorize()
#'
#'@details
#'Returns the list of item in a folder in a user’s collection. Accepts Pagination parameters.
#'Basic information about each release is provided, suitable for display in a list. For detailed information, make another API call to fetch the corresponding release.
#'If folder_id is not 0, or the collection has been made private by its owner, authentication as the collection owner is required.
#'If you are not authenticated as the collection owner, only public notes fields will be visible.
#'Valid sort values are: `label`, `artist`, `title`, `catno`, `format`, `rating`, `added`, `year`
#'
#'@examples
#' items <- get_collection_items_by_folder("username", 0, options = list("sort" = "label"))
get_collection_items_by_folder <- function(username, folder_id, options=list(), token=NA){
  url <- sprintf("%s/users/%s/collection/folder/%s/releases?%s",  BASE_URL, username, folder_id, parse_options(options))
  return(content(get(url, config(token = token))))
}

#' Add release to collection
#'
#'@usage add_to_collection_folder(
#'  username,
#'  folder_id,
#'  release_id,
#'  token
#')
#'
#'@param username String containing a valid username
#'@param folder_id Valid identifier for a folder
#'@param release_id Integer value representing a valid release ID
#'@param token Token object obtained from authorize()
#'
#'@details
#'Add a release to a folder in a user’s collection.
#'The folder_id must be non-zero – you can use 1 for “Uncategorized”.
#'Authentication as the collection owner is required.

#'@examples
#'token <- authorize("key", "secret")
#'add_to_collection_folder("username", 0, 1000, token)
add_to_collection_folder <- function(username, folder_id, release_id, token){
  url <- sprintf("%s/users/%s/collection/folders/%s/releases/%s", BASE_URL, username, folder_id, release_id)
  return(post(url, content = "", config(token = token)))
}

#' Change the rating of a release
#'
#'@usage change_release_rating(
#'  username,
#'  folder_id,
#'  release_id,
#'  instance_id
#'  token,
#'  rating = 0
#')
#'
#'@param username String containing a valid username
#'@param folder_id Valid identifier for a folder
#'@param release_id Integer value representing a valid release ID
#'@param instance_id The ID of the instance
#'@param token Token object obtained from authorize()
#'@param rating Integer value between 0-5
#'
#'@details
#'Change the rating on a release and/or move the instance to another folder.

#'Authentication as the collection owner is required.
#'@examples
#'token <- authorize("key", "secret")
#'change_release_rating("username", 0, 1000, 1, token, 4)
change_release_rating <- function(username, folder_id, release_id, instance_id, token, rating=0){
  url <- sprintf("%s/users/%s/collection/folders/%s/releases/%s/instances/%s",
                 BASE_URL, username, folder_id, release_id, instance_id)
  return(post(url, content = rating, config(token = token)))
}

#' Delete Instance From Folder
#'
#'@usage delete_release_from_folder(
#'  username,
#'  folder_id,
#'  release_id,
#'  instance_id,
#'  token
#')
#'
#'@param username String containing a valid username
#'@param folder_id Valid identifier for a folder
#'@param release_id Integer value representing a valid release ID
#'@param instance_id The ID of the instance
#'@param token Token object obtained from authorize()
#'
#'@details
#'Remove an instance of a release from a user’s collection folder.
#'
#'To move the release to the “Uncategorized” folder instead, use add_to_collection()
#'
#'Authentication as the collection owner is required.
#'
#'@examples
#'token <- authorize("key", "secret")
#'delete_release_from_folder("username", 0, 1000, 1, token)

delete_release_from_folder <- function(username, folder_id, release_id, instance_id, token){
  url <- sprintf("%s/users/%s/collection/folders/%s/releases/%s/instances/%s",
                 BASE_URL, username, folder_id, release_id, instance_id)
  return(delete(url, config(token = token)))
}

#' List custom fields in collection
#'
#'@usage get_list_custom_fields(
#'  username,
#'  token = NA
#')
#'
#'@param username String containing a valid username
#'@param token Token object obtained from authorize()
#'
#'@details
#'Retrieve a list of user-defined collection notes fields. These fields are available on every release in the collection.
#'
#'If the collection has been made private by its owner, authentication as the collection owner is required.
#'
#'If you are not authenticated as the collection owner, only fields with public set to true will be visible.
#'@examples
#'token <- authorize("key", "secret")
#'list <- get_list_custom_fields("username", token)
get_list_custom_fields <- function(username, token=NA){
  url <- sprintf("%s/users/%s/collection/fields", BASE_URL, username)
  return(content(get(url, config(token = token))))
}

#' Edit fields of an instance
#'
#'@usage edit_field_instance(
#'  username
#'  value
#'  folder_id
#'  release_id
#'  instance_id
#'  field_id
#'  token
#')
#'
#'@param username String containing a valid username
#'@param value The new value of the field
#'@param folder_id The ID of the folder to modify
#'@param release_id Integer value representing a valid release ID
#'@param instance_id The ID of the instance
#'@param field_id The ID of the field
#'@param token Token object obtained from authorize()
#'@examples
#'token <- authorize("key", "secret")
#'edit_field_instance(username = "username", value = "my_value", folder_id = 0,
#'                    release_id = 1000, instance_id = 1, field_id = 1, token = token)
edit_field_instance <- function(username, value, folder_id, release_id, instance_id, field_id, token){
  url <- sprintf("%s/users/%s/collection/folders/%s/releases/%s/instances/%s/fields/%s?%s",
                 BASE_URL, username, folder_id, release_id, instance_id, field_id, value)
  return(post(url, content = name, config(token = token)))
}

#' Get the value of the user's collection
#'
#'@usage get_collection_value(
#'  username,
#'  token
#')
#'
#'@param username String containing a valid username
#'@param token Token object obtained from authorize()
#'
#'@details
#'Returns the minimum, median, and maximum value of a user’s collection.
#'
#'Authentication as the collection owner is required.
#'
#'@examples
#'token <- authorize("key", "secret")
#'value <- get_collection_value("username", token)
get_collection_value <- function(username, token){
  url <- sprintf("%s/users/%s/collection/value", BASE_URL, username)
  return(content(get(url, config(token = token))))
}
