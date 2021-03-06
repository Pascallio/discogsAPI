% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Collection.R
\name{change_release_rating}
\alias{change_release_rating}
\title{Change the rating of a release}
\usage{
change_release_rating(
 username,
 folder_id,
 release_id,
 instance_id
 token,
 rating = 0
)
}
\arguments{
\item{username}{String containing a valid username}

\item{folder_id}{Valid identifier for a folder}

\item{release_id}{Integer value representing a valid release ID}

\item{instance_id}{The ID of the instance}

\item{token}{Token object obtained from authorize() or a string containing your personal access token}

\item{rating}{Integer value between 0-5}
}
\description{
Change the rating of a release
}
\details{
Change the rating on a release and/or move the instance to another folder.
Authentication as the collection owner is required.
}
\examples{
token <- authorize("key", "secret")
change_release_rating("username", 0, 1000, 1, token, 4)
}
