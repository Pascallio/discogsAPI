
#'Authorize using OAuth
#'
#'@usage authorize(
#'  key,
#'  secret,
#'  cache = T
#')
#'
#'@param key Your key obtained from Discogs
#'@param secret Your secret obtained from Discogs
#'@param cache (optional) Should the authorization be cached?
#'
#'@details
#'This function uses the __httr__ package to make OAuth 1.0 requests.
#'To obtain a developers key and secret, visit [Discogs developers](https://www.discogs.com/settings/developers)
#'@examples
#'my_key <- "abcde"
#'my_secret <- "secret"
#'token <- authorize(my_key, my_secret)
authorize <- function(key, secret, cache = T){
  oauth <- oauth_app("Discogs extensions", key = key, secret = secret)
  endpoint <- oauth_endpoint(request = sprintf("%s/oauth/request_token", BASE_URL),
                             authorize = "https://www.discogs.com/oauth/authorize",
                             access = sprintf("%s/oauth/access_token", BASE_URL))
  return(oauth1.0_token(endpoint, oauth, cache = cache))
}














