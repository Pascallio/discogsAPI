% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Database.R
\name{get_all_label_releases}
\alias{get_all_label_releases}
\title{Get all releases of a label}
\usage{
get_release_stats(
 label_id,
 options = list(),
 token = NA
)
}
\arguments{
\item{options}{(optional) Parameters, see Details}

\item{token}{(optional) Token object obtained from authorize() or a string containing your personal access token}

\item{release_id}{Integer value representing a valid release ID}
}
\description{
Get all releases of a label
}
\details{
This function supports Pagination parameters. Below is a list of available fields.
\itemize{
\item{ \strong{page:} }{integer, the page you want to request; \strong{example}: 1}
\item{ \strong{per_page:} }{integer, the number of items per page; \strong{example}: 50}
}
}
\examples{
# Retrieve releases from a label
releases <- get_all_label_releases(1)
}
