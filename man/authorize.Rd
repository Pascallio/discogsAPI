% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Authentication.R
\name{authorize}
\alias{authorize}
\title{Authorize using OAuth}
\usage{
authorize(
 key,
 secret,
 cache = T
)
}
\arguments{
\item{key}{Your key obtained from Discogs}

\item{secret}{Your secret obtained from Discogs}

\item{cache}{(optional) Should the authorization be cached?}
}
\description{
Authorize using OAuth
}
\details{
This function uses the \strong{httr} package to make OAuth 1.0 requests.
To obtain a developers key and secret, visit \href{https://www.discogs.com/settings/developers}{Discogs developers}
}
\examples{
my_key <- "abcde"
my_secret <- "secret"
token <- authorize(my_key, my_secret)
}
