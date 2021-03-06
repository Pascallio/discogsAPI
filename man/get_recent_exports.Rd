% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Inventory.R
\name{get_recent_exports}
\alias{get_recent_exports}
\title{Get your recent exports}
\usage{
get_recent_exports(
 token,
 options = list()
)
}
\arguments{
\item{token}{Token object obtained from authorize() or a string containing your personal access token}

\item{options}{(optional) List of named parameters, see Details}
}
\description{
Get your recent exports
}
\examples{
token <- authorize("key", "secret")
exports <- get_recent_exports(token)
}
