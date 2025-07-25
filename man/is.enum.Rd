% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Enum-class.R
\name{is.enum}
\alias{is.enum}
\title{Check if an object is an Enum}
\usage{
is.enum(x)
}
\arguments{
\item{x}{An object to test.}
}
\value{
\code{TRUE} if the object is an Enum, \code{FALSE} otherwise.
}
\description{
Check if an object is an Enum
}
\examples{
colors <- Enum(RED = 1, GREEN = 2, BLUE = 3)
is.enum(colors) # TRUE
is.enum(list(a = 1, b = 2)) # FALSE

}
