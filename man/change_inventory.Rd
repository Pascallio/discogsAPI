% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Inventory.R
\name{change_inventory}
\alias{change_inventory}
\title{Upload a CSV of listings to change in your inventory.}
\usage{
change_inventory(
 csv,
 token
)
}
\arguments{
\item{csv}{A string representing the source location of a csv file, see Details}

\item{token}{Token object obtained from authorize() or a string containing your personal access token}
}
\description{
Upload a CSV of listings to change in your inventory.
}
\details{
\subsection{File structure}{

The file you upload must be a comma-separated CSV. The first row must be a header with lower case field names.
Here’s an example:
\verb{release_id,price,media_condition,comments 123,1.50,Mint (M),Comments about this release for sale 456,2.50,Near Mint (NM or M-),More comments 7890,3.50,Good (G),Signed vinyl copy}
}

\subsection{Things to note:}{

These listings will be marked “For Sale” immediately.
Currency information will be pulled from your marketplace settings.
Any fields that aren’t optional or required will be ignored.
}

\subsection{Required fields:}{
\itemize{
\item \strong{release_id} - Must be a number. This value corresponds with the Discogs database Release ID.
\item \strong{price} - Must be a number.
\item \strong{media_condition} - Must be a valid condition (see below).
}
}

\subsection{Optional fields:}{
\itemize{
\item \strong{sleeve_condition} - Must be a valid condition (see below).
\item \strong{comments} accept_offer - Must be Y or N.
\item \strong{location} - Private free-text field to help identify an item’s physical location.
\item \strong{external_id} - Private notes or IDs for your own reference.
\item \strong{weight} - In grams. Must be a non-negative integer.
\item \strong{format_quantity} - Number of items that this item counts as (for shipping).
}
}

\subsection{Conditions:}{

When you specify a media condition, it must exactly match one of these:
\itemize{
\item \strong{Mint (M)}
\item \strong{Near Mint (NM or M-)}
\item \strong{Very Good Plus (VG+)}
\item \strong{Very Good (VG)}
\item \strong{Good Plus (G+)}
\item \strong{Good (G)}
\item \strong{Fair (F)}
\item \strong{Poor (P)}
}

Sleeve condition may be any of the above, or:
\itemize{
\item \strong{Not Graded}
\item \strong{Generic}
\item \strong{No Cover}
}
}
}
\examples{
token <- authorize("key", "secret")
}
