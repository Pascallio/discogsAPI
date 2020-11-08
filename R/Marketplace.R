#' Get a seller’s inventory
#'
#' @usage get_inventory(
#'   username,
#'   options = list(),
#'   token = NA
#' )
#' @param username String containing a valid username
#' @param options (optional) Parameters, see Details
#' @param token (optional) Token object obtained from authorize()
#' @details
#' If you are not authenticated as the inventory owner, only items that have a status of For Sale will be visible.
#' If you are authenticated as the inventory owner you will get additional weight, format_quantity, external_id, and location keys.
#' If the user is authorized, the listing will contain a in_cart boolean field indicating whether or not this listing is in their cart.
#'
#' ## Parameters
#' Below are optional parameters that can be provided to the options argument
#'
#' ### status
#' Only show items with this status, for example: `for sale`
#'
#' ### sort
#' Sort items by one of the following fields: `listed`, `price`, `item`  (i.e. the title of the release)
#' `artist`, `label`, `catno`, `audio`, `status` (when authenticated as the inventory owner),
#' `location` (when authenticated as the inventory owner)
#'
#' ### sort_order
#' Sort items in a particular order (one of `asc` or `desc`)
#'
#' @examples
#' inventory <- get_inventory("username")
#'
#' inventory <- get_inventory("username", options = list("sort" = "artist", "sort_order" = "desc"))
get_inventory <- function(username, options=list(), token=NA){
  url <- sprintf("%s/users/%s/inventory?%s", BASE_URL, username, parse_options(options))
  return(content(get(url, token)))
}

#' View the data associated with a listing
#'
#' @usage get_listing(
#'   listing_id,
#'   options = list(),
#'   token = NA
#' )
#' @param listing_id The ID of the listing you are fetching
#' @param options (optional) Parameters, see Details
#' @param token (optional) Token object obtained from authorize()
#' @details
#' If the authorized user is the listing owner the listing will include the weight, format_quantity, external_id, and location keys.
#' If the user is authorized, the listing will contain a in_cart boolean field indicating whether or not this listing is in their cart.
#' @examples
#'
#' listing <- get_listing(1)
#'
#' listing <- get_listing(1, options = list("curr_abbr" = "EUR"))
get_listing <- function(listing_id, options=list(), token=NA){
  url <- sprintf("%s/marketplace/listings/%s?%s", BASE_URL, listing_id, parse_options(options))
  return(content(get(url, token)))
}

#' Edit the data associated with a listing.
#'
#' @usage post_listing(
#'   listing_id,
#'   release_id,
#'   condition,
#'   price,
#'   status,
#'   token,
#'   options = list()
#' )
#' @param listing_id The ID of the listing you are fetching
#' @param release_id Integer value representing a valid release ID
#' @param condition The condition of the release you are posting. See Details
#' @param price The price of the item (in the seller’s currency).
#' @param status The status of the listing. See Details
#' @param token Token object obtained from authorize()
#' @param options (optional) Parameters, see Details
#' @details
#' Create a Marketplace listing.
#' Authentication is required; the listing will be added to the authenticated user’s Inventory.
#'
#' ## Condition
#' Condition must be one of the following:
#' * __Mint(M)__
#' * __Near Mint (NM or M-)__
#' * __Very Good Plus (VG+)__
#' * __Very Good (VG)__
#' * __Good Plus (G+)__
#' * __Good (G)__
#' * __Fair (F)__
#' * __Poor (P)__
#'
#' ## Status
#'  Defaults to __For Sale__. Options are:
#'  * __For Sale__ (the listing is ready to be shown on the Marketplace)
#'  * __Draft__ (the listing is not ready for public display).
#'
#' ## Parameters
#' Below are optional parameters that can be provided to the options argument
#'
#'  ### sleeve_condition
#'  The condition of the sleeve of the item you are posting. Must be one of the following:
#' * __Mint(M)__
#' * __Near Mint (NM or M-)__
#' * __Very Good Plus (VG+)__
#' * __Very Good (VG)__
#' * __Good Plus (G+)__
#' * __Good (G)__
#' * __Fair (F)__
#' * __Poor (P)__
#' * __Generic__
#' * __Not Graded__
#' * __No Cover__
#'
#'  ### comments
#'  Any remarks about the item that will be displayed to buyers.
#'
#'  ### allow_offers
#'  Whether or not to allow buyers to make offers on the item. Defaults to __False__.
#'
#'  ### external_id
#'  A freeform field that can be used for the seller’s own reference.
#'  Information stored here will not be displayed to anyone other than the seller.
#'  This field is called “Private Comments” on the Discogs website.
#'
#'  ### location
#'  A freeform field that is intended to help identify an item’s physical storage location.
#'  Information stored here will not be displayed to anyone other than the seller.
#'  This field will be visible on the inventory management page and will be available in inventory exports via the website.
#'
#'  ### weight
#'  The weight, in grams, of this listing, for the purpose of calculating shipping.
#'  Set this field to __auto__ to have the weight automatically estimated for you.
#'
#'  ### format_quantity
#'  The number of items this listing counts as, for the purpose of calculating shipping.
#'  This field is called “Counts As” on the Discogs website.
#'  Set this field to __auto__ to have the quantity automatically estimated for you.
#' @examples
#'
#' token <- authorize("key", "secret")
#' edit_listing(1, 10, "Near Mint (NM or M-)", "10.30", "For Sale", token)
#'
#' edit_listing(13, 112301, "Near Mint (NM or M-)", 12.30, "Draft", token, options=list("weight" = 400))
edit_listing <- function(listing_id, release_id, condition, price, status, token, options=list()){
  url <- sprintf("%s/marketplace/listings/%s?condition=%s&price=%s&statuts=%s&%s",
                 BASE_URL, listing_id, condition, price, status, parse_options(options))
  return(post(url, token))
}

#' Delete a listing from the Marketplace
#'
#' @usage delete_listing(
#'   listing_id,
#'   token,
#'   options = list(),
#' )
#' @param listing_id The ID of the listing you are fetching
#' @param options (optional) Parameters, see Details
#' @param token Token object obtained from authorize()
#' @details
#' Permanently remove a listing from the Marketplace.
#' Authentication as the listing owner is required.
#' @examples
delete_listing <- function(listing_id, token, options=list()){
  url <- sprintf("/marketplace/listings/%s?%s", listing_id, parse_options(options))
  return(delete(url, token))
}

#' Create a new Marketplace listing
#'
#' @usage new_listing(
#'   listing_id,
#'   release_id,
#'   condition,
#'   price,
#'   status,
#'   token,
#'   options = list(),
#' )
#' @param listing_id The ID of the listing you are fetching
#' @param release_id Integer value representing a valid release ID
#' @param condition The condition of the release you are posting. See Details
#' @param price The price of the item (in the seller’s currency).
#' @param status The status of the listing. See Details
#' @param token Token object obtained from authorize()
#' @param options (optional) Parameters, see Details
#' @details
#' Create a Marketplace listing.
#' Authentication is required; the listing will be added to the authenticated user’s Inventory.
#'
#' ## Condition
#' Condition must be one of the following:
#' * __Mint(M)__
#' * __Near Mint (NM or M-)__
#' * __Very Good Plus (VG+)__
#' * __Very Good (VG)__
#' * __Good Plus (G+)__
#' * __Good (G)__
#' * __Fair (F)__
#' * __Poor (P)__
#'
#' ## Status
#'  Defaults to __For Sale__. Options are:
#'  * __For Sale__ (the listing is ready to be shown on the Marketplace)
#'  * __Draft__ (the listing is not ready for public display).
#'
#' ## Parameters
#' Below are optional parameters that can be provided to the options argument
#'
#'  ### sleeve_condition
#'  The condition of the sleeve of the item you are posting. Must be one of the following:
#' * __Mint(M)__
#' * __Near Mint (NM or M-)__
#' * __Very Good Plus (VG+)__
#' * __Very Good (VG)__
#' * __Good Plus (G+)__
#' * __Good (G)__
#' * __Fair (F)__
#' * __Poor (P)__
#' * __Generic__
#' * __Not Graded__
#' * __No Cover__
#'
#'  ### comments
#'  Any remarks about the item that will be displayed to buyers.
#'
#'  ### allow_offers
#'  Whether or not to allow buyers to make offers on the item. Defaults to __False__.
#'
#'  ### external_id
#'  A freeform field that can be used for the seller’s own reference.
#'  Information stored here will not be displayed to anyone other than the seller.
#'  This field is called “Private Comments” on the Discogs website.
#'
#'  ### location
#'  A freeform field that is intended to help identify an item’s physical storage location.
#'  Information stored here will not be displayed to anyone other than the seller.
#'  This field will be visible on the inventory management page and will be available in inventory exports via the website.
#'
#'  ### weight
#'  The weight, in grams, of this listing, for the purpose of calculating shipping.
#'  Set this field to __auto__ to have the weight automatically estimated for you.
#'
#'  ### format_quantity
#'  The number of items this listing counts as, for the purpose of calculating shipping.
#'  This field is called “Counts As” on the Discogs website.
#'  Set this field to __auto__ to have the quantity automatically estimated for you.
#' @examples
#'
#' token <- authorize("key", "secret")
#' edit_listing(1, 10, "Near Mint (NM or M-)", 10.30, "For Sale", token)
#'
#' edit_listing(13, 112301, "Near Mint (NM or M-)", 12.30, "Draft", token, options=list("weight" = 400))
new_listing <- function(listing_id, release_id, condition, price, status, token, options=list()){
    url <- sprintf("%s/marketplace/listings/%s?condition=%s&price=%s&statuts=%s&%s",
                   BASE_URL, listing_id, condition, price, status, parse_options(options))
    return(post(url, token))
}

#' Get a seller’s Marketplace order
#'
#' @usage get_order(
#'   order_id,
#'   token
#' )
#' @param order_id The ID of the order you are fetching
#' @param token Token object obtained from authorize()
#' @details
#' View the data associated with an order.
#' Authentication as the seller is required.
#' @examples
#'
#' token <- authorize("key", "secret")
#' order <- get_order(1, token)

get_order <- function(order_id, token){
  url <- sprintf("%s/marketplace/orders/%s", BASE_URL, order_id)
  return(content(get(url, token)))
}

#' Edit the data associated with an order
#'
#' @usage edit_order(
#'   order_id,
#'   token,
#'   options = list()
#' )
#' @param order_id The ID of the order you are fetching
#' @param token Token object obtained from authorize()
#' @param options (optional) Parameters, see Details
#' @details
#' Edit the data associated with an order.
#' Authentication as the seller is required.
#' The response contains a next_status key – an array of valid next statuses for this order, which you can display to the user in (for example) a dropdown control.
#' This also renders your application more resilient to any future changes in the order status logic.
#' Changing the order status using this resource will always message the buyer with:
#'
#'     _Seller changed status from Old Status to New Status_
#'
#' and does not provide a facility for including a custom message along with the change.
#' For more fine-grained control, use the Add a new message resource, which allows you to simultaneously add a message and change the order status.
#' If the order status is neither cancelled, Payment Received, nor Shipped, you can change the shipping.
#' Doing so will send an invoice to the buyer and set the order status to Invoice Sent.
#' (For that reason, you cannot set the shipping and the order status in the same request.)

#' @examples
#' token <- authorize("key", "secret")
#' edit_order(1, token)
edit_order <- function(order_id, token, options=list()){
  url <- sprintf("%s/marketplace/orders/%s?%s", BASE_URL, order_id, parse_options(options))
  return(post(url, token))
}

#' Returns a list of the authenticated user’s orders
#'
#' @usage get_list_orders(
#'   token,
#'   options = list(),
#' )
#' @param token Token object obtained from authorize()
#' @param options (optional) Parameters, see Details
#' @details
#' Returns a list of the authenticated user’s orders. Accepts Pagination parameters.
#' @examples
#' token <- authorize("key", "secret")
get_list_orders <- function(token, options=list()){
  url <- sprintf("%s/marketplace/orders?%s", BASE_URL, parse_options(options))
  return(content(get(url, token)))
}

#' Get messages of a single order
#'
#' @usage get_list_order_messages(
#'   order_id,
#'   token,
#'   options = list(),
#' )
#' @param order_id The ID of the order you are fetching
#' @param token Token object obtained from authorize()
#' @param options (optional) Parameters, see Details
#' @details
#' Returns a list of the order’s messages with the most recent first. Accepts Pagination parameters.
#' Authentication as the seller is required.
#' @examples
#' token <- authorize("key", "secret")
get_list_order_messages <- function(order_id, token, options=list()){
  url <- sprintf("%s/marketplace/orders/%s/messages?%s", order_id, parse_options(options))
  return(content(get(url, token)))
}

#' Add a new message to the order's message log
#'
#' @usage add_order_message(
#'   order_id
#'   token = NA,
#'   options = list(),
#' )
#' @param order_id The ID of the order you are fetching
#' @param token (optional) Token object obtained from authorize()
#' @param options (optional) Parameters, see Details
#' @details
#' Adds a new message to the order’s message log.
#' When posting a new message, you can simultaneously change the order status. If you do, the message will automatically be prepended with:
#'     Seller changed status from Old Status to New Status
#' While message and status are each optional, one or both must be present.
#' @examples
add_order_message <- function(order_id, token, options=list()){
  url <- sprintf("%s/marketplace/orders/%s/messages", order_id)
  return(post(url, options, token))
}

#' Get the fee for selling an item on the Marketplace
#'
#' @usage get_fee(
#'   options = list(),
#'   token = NA
#' )
#' @param options (optional) Parameters, see Details
#' @param token (optional) Token object obtained from authorize()
#' @details
#' The Fee resource allows you to quickly calculate the fee for selling an item on the Marketplace.
#' @examples
get_fee <- function(options=list(), token=NA){
  url <- sprintf("%s/marketplace/fee/%s", BASE_URL, parse_options(options))
  return(content(get(url, token)))
}

#' Get the fee for your currency
#'
#' @usage get_fee_with_currency(
#'   price,
#'   options = list(),
#'   token = NA
#' )
#' @param price The price to calculate a fee from
#' @param options (optional) Parameters, see Details
#' @param token (optional) Token object obtained from authorize()
#' @details
#' The Fee resource allows you to quickly calculate the fee for selling an item on the Marketplace given a particular currency.
#' @examples
get_fee_with_currency <- function(price, options=list(), token=NA){
  url <- sprintf("%s/marketplace/fee/%s/%s", BASE_URL, price, parse_options(options))
  return(content(get(url, token)))
}

#' Retrieve price suggestions for the provided Release ID
#'
#' @usage get_price_suggestions(
#'   release_id,
#'   token
#' )
#' @param release_id Integer value representing a valid release ID
#' @param token Token object obtained from authorize()
#' @details
#' Retrieve price suggestions for the provided Release ID. If no suggestions are available, an empty object will be returned.
#' Authentication is required, and the user needs to have filled out their seller settings.
#' Suggested prices will be denominated in the user’s selling currency.
#' @examples
#' token <- authorize("key", "secret")
get_price_suggestions <- function(release_id, token){
  url <- sprintf("%s/marketplace/price_suggestions/%s", BASE_URL, release_id)
  return(content(get(url, token)))
}

#' Retrieve marketplace statistics for the provided Release ID
#'
#' @usage get_release_statistics(
#'   release_id,
#'   options = list(),
#'   token = NA
#' )
#' @param release_id Integer value representing a valid release ID
#' @param options (optional) Parameters, see Details
#' @param token (optional) Token object obtained from authorize()
#' @details
#' Retrieve marketplace statistics for the provided Release ID.
#' These statistics reflect the state of the release in the marketplace currently,
#' and include the number of items currently for sale, lowest listed price of any item for sale,
#' and whether the item is blocked for sale in the marketplace.

#' Authentication is optional.
#' Authenticated users will by default have the lowest currency expressed in their own buyer currency,
#' configurable in buyer settings, in the absence of the curr_abbr query parameter to specify the currency.
#' Unauthenticated users will have the price expressed in US Dollars, if no curr_abbr is provided.

#' Releases that have no items for sale in the marketplace will return a body with null data in the lowest_price and num_for_sale keys.
#' Releases that are blocked for sale will also have null data for these keys.
#' @examples
get_release_statistics <- function(release_id, options=list(), token=NA){
  url <- sprintf("%s/marketplace/stats/%s?%s", BASE_URL, release_id, parse_options(options))
  return(content(get(url, token)))
}

