% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/available-data.R
\name{ukc_available}
\alias{ukc_available}
\title{Available data}
\usage{
ukc_available()
}
\description{
Returns a \code{tibble} with all available datasets. The \code{id} column contains the
year and month, and other columns contain a list with all police forces
reporting data for that month. As of 2019-04-02 only information on
stop and search data is returned by this endpoint.
}
