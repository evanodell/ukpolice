

#' ukpolice: Download Data on UK Police and Crime
#'
#' Downloads data from the 'UK Police' public data API. Includes data on UK
#' police forces and police force areas, crime reports, and the use of
#' stop-and-search powers.
#'
#' Most functions return a `tibble` with the requested data, with the exception
#' of [ukc_specific_outcome()] in some cases, which returns a list containing a
#' list and a `tibble`.
#'
#' The API allows for 15 requests each second, but up to 30 in a single second
#' if in a single burst. The API does not require authentication.
#' See the [API documentation](https://data.police.uk/docs/) for more details.
#'
#' @docType package
#' @name ukpolice
#' @importFrom jsonlite fromJSON
#' @importFrom `tibble` as_`tibble` enframe
#' @importFrom purrr compact
#' @aliases NULL ukpolice-package
NULL
