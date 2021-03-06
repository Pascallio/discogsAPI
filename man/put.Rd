% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Base.R
\name{put}
\alias{put}
\title{Put request to the discogs server}
\usage{
put(
 url,
 content,
 token
)
}
\arguments{
\item{url}{full URL to API endpoint}

\item{content}{The content to post / upload}

\item{token}{Token object obtained from authorize() or a string containing your personal access token}
}
\description{
Put request to the discogs server
}
\details{
This function is not supposed to used directly, but through other functions instead
}
