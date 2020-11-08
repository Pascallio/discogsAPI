#' Export your inventory
#'
#'@usage export_inventory(
#'  token
#')
#'
#'@param token Token object obtained from authorize()
#'
#'@details
#'
#'@examples
#' token <- authorize("key", "secret")
#' export_inventory(token)
export_inventory <- function(token){
  url <- sprintf("%s/inventory/export", BASE_URL)
  return(post(url, content="", token))
}

#' Get your recent exports
#'
#'@usage get_recent_exports(
#'  token,
#'  options = list()
#')
#'
#'@param token Token object obtained from authorize()
#'@param options (optional) List of named parameters, see Details
#'
#'@details
#'
#'@examples
#' token <- authorize("key", "secret")
#' exports <- get_recent_exports(token)
get_recent_exports <- function(token, options=list()){
  url <- sprintf("%s/inventory/export?%s", BASE_URL, parse_options(options))
  return(content(get(url, token)))
}

#' Get details about a specific export
#'
#'@usage get_export_details(
#'  export_id,
#'  token
#')
#'
#'@param export_id Id of the export
#'@param token Token object obtained from authorize()
#'
#'@details
#'
#'@examples
#' token <- authorize("key", "secret")
#' details <- get_export_details(1, token)
get_export_details <- function(export_id, token){
  url <- sprintf("%s/inventory/export/%s", BASE_URL, export_id)
  return(content(get(url, token)))
}

#' Download an export
#'
#'@usage download_export(
#'  export_id,
#'  token
#')
#'
#'@param export_id Id of the export
#'@param token Token object obtained from authorize()
#'
#'@details
#'
#'@examples
#'token <- authorize("key", "secret")
#'csv <- download_export(1, token)
download_export <- function(export_id, token){
  url <- sprintf("%s/inventory/export/%s/download", BASE_URL, export_id)
  return(content(get(url, token)))
}



#' Upload a CSV of listings to add to your inventory.
#'
#'@usage add_inventory(
#'  path,
#'  token
#')
#'
#'@param path A string representing the source location of a csv file, see Details
#'@param token Token object obtained from authorize()
#'
#'@details
#' ## File structure

#'The file you upload must be a comma-separated CSV. The first row must be a header with lower case field names.

#'Here’s an example:
#'`
#'    release_id,price,media_condition,comments
#'    123,1.50,Mint (M),Comments about this release for sale
#'    456,2.50,Near Mint (NM or M-),More comments
#'    7890,3.50,Good (G),Signed vinyl copy
#'`
#'## Things to note:
#'
#'These listings will be marked “For Sale” immediately.
#'Currency information will be pulled from your marketplace settings.
#'Any fields that aren’t optional or required will be ignored.
#'
#'## Required fields:
#'* __release_id__ - Must be a number. This value corresponds with the Discogs database Release ID.
#'* __price__ - Must be a number.
#'* __media_condition__ - Must be a valid condition (see below).
#'
#'## Optional fields:
#'* __sleeve_condition__ - Must be a valid condition (see below).
#'* __comments__ accept_offer - Must be Y or N.
#'* __location__ - Private free-text field to help identify an item’s physical location.
#'* __external_id__ - Private notes or IDs for your own reference.
#'* __weight__ - In grams. Must be a non-negative integer.
#'* __format_quantity__ - Number of items that this item counts as (for shipping).
#'
#'## Conditions:
#'When you specify a media condition, it must exactly match one of these:
#'* __Mint (M)__
#'* __Near Mint (NM or M-)__
#'* __Very Good Plus (VG+)__
#'* __Very Good (VG)__
#'* __Good Plus (G+)__
#'* __Good (G)__
#'* __Fair (F)__
#'* __Poor (P)__
#'
#'Sleeve condition may be any of the above, or:
#'* __Not Graded__
#'* __Generic__
#'* __No Cover__

#'@examples
#'token <- authorize("key", "secret")
add_inventory <- function(path, token){
  url <- sprinft("%s/inventory/upload/add", BASE_URL)
  return(post(url, content = upload_file(path), token))
}

#' Upload a CSV of listings to change in your inventory.
#'
#'@usage change_inventory(
#'  csv,
#'  token
#')
#'
#'@param csv A string representing the source location of a csv file, see Details
#'@param token Token object obtained from authorize()
#'
#'@details
#' ## File structure

#'The file you upload must be a comma-separated CSV. The first row must be a header with lower case field names.

#'Here’s an example:
#'`
#'    release_id,price,media_condition,comments
#'    123,1.50,Mint (M),Comments about this release for sale
#'    456,2.50,Near Mint (NM or M-),More comments
#'    7890,3.50,Good (G),Signed vinyl copy
#'`
#'
#'## Things to note:
#'
#'These listings will be marked “For Sale” immediately.
#'Currency information will be pulled from your marketplace settings.
#'Any fields that aren’t optional or required will be ignored.
#'
#'## Required fields:
#'* __release_id__ - Must be a number. This value corresponds with the Discogs database Release ID.
#'* __price__ - Must be a number.
#'* __media_condition__ - Must be a valid condition (see below).
#'
#'## Optional fields:
#'* __sleeve_condition__ - Must be a valid condition (see below).
#'* __comments__ accept_offer - Must be Y or N.
#'* __location__ - Private free-text field to help identify an item’s physical location.
#'* __external_id__ - Private notes or IDs for your own reference.
#'* __weight__ - In grams. Must be a non-negative integer.
#'* __format_quantity__ - Number of items that this item counts as (for shipping).
#'
#'## Conditions:
#'When you specify a media condition, it must exactly match one of these:
#'* __Mint (M)__
#'* __Near Mint (NM or M-)__
#'* __Very Good Plus (VG+)__
#'* __Very Good (VG)__
#'* __Good Plus (G+)__
#'* __Good (G)__
#'* __Fair (F)__
#'* __Poor (P)__
#'
#'Sleeve condition may be any of the above, or:
#'* __Not Graded__
#'* __Generic__
#'* __No Cover__
#'
#'@examples
#'token <- authorize("key", "secret")
change_inventory <- function(csv, token){
  url <- sprinft("%s/inventory/upload/change", BASE_URL)
  return(post(url, content = upload_file(path), token))
}

#' Upload a CSV of listings to delete from your inventory.
#'
#'@usage delete_inventroy(
#'  csv,
#'  token
#')
#'
#'@param csv A string representing the source location of a csv file, see Details
#'@param token Token object obtained from authorize()
#'
#'@details
#' ## File structure

#'The file you upload must be a comma-separated CSV. The first row must be a header with lower case field names.

#'Here’s an example:
#'`
#'    release_id,price,media_condition,comments
#'    123,1.50,Mint (M),Comments about this release for sale
#'    456,2.50,Near Mint (NM or M-),More comments
#'    7890,3.50,Good (G),Signed vinyl copy
#'`
#'## Things to note:
#'
#'These listings will be marked “For Sale” immediately.
#'Currency information will be pulled from your marketplace settings.
#'Any fields that aren’t optional or required will be ignored.
#'
#'## Required fields:
#'* __release_id__ - Must be a number. This value corresponds with the Discogs database Release ID.
#'
#'## Optional fields (at least one required):
#'* __price__
#'* __media_condition__ - Must be a valid condition (see below).
#'* __sleeve_condition__ - Must be a valid condition (see below).
#'* __comments__ accept_offer - Must be Y or N.
#'* __location__ - Private free-text field to help identify an item’s physical location.
#'* __external_id__ - Private notes or IDs for your own reference.
#'* __weight__ - In grams. Must be a non-negative integer.
#'* __format_quantity__ - Number of items that this item counts as (for shipping).
#'
#'## Conditions:
#'When you specify a media condition, it must exactly match one of these:
#'* __Mint (M)__
#'* __Near Mint (NM or M-)__
#'* __Very Good Plus (VG+)__
#'* __Very Good (VG)__
#'* __Good Plus (G+)__
#'* __Good (G)__
#'* __Fair (F)__
#'* __Poor (P)__
#'
#'Sleeve condition may be any of the above, or:
#'* __Not Graded__
#'* __Generic__
#'* __No Cover__
#'
#'@examples
#'token <- authorize("key", "secret")
delete_inventory <- function(csv, token){
  url <- sprinft("%s/inventory/upload/delete", BASE_URL)
  return(post(url, content = upload_file(path), token))
}

#' Get recent your uploads
#'
#'@usage get_recent_uploads(
#'  token
#')
#'
#'@param token Token object obtained from authorize()
#'@examples
#'token <- authorize("key", "secret")
#'recent_uploads <- get_recent_uploads(token)
get_recent_uploads <- function(token){
  url <- sprinft("%s/inventory/upload", BASE_URL)
  return(content(get(url, token)))
}

#' Get details about the status of an inventory upload.
#'
#'@usage get_upload(
#'  id,
#'  token = NA
#')
#'
#'@param id upload identifier
#'@param token Token object obtained from authorize()
#'@examples
#'status <- get_upload(1)
get_upload <- function(id, token=NA){
  url <- sprinft("%s/inventory/upload/%s", BASE_URL, id)
  return(content(get(url, token)))
}
