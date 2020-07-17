

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
#' Data accessed through `ukpolice` is licenced with
#' [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
#'
#' The API allows for 15 requests each second, but up to 30 in a single second
#' if in a single burst. The API does not require authentication.
#' See the [API documentation](https://data.police.uk/docs/) for more details.
#'
#' @docType package
#' @name ukpolice-package
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble
#' @importFrom purrr compact
#' @importFrom httr GET status_code content
#' @importFrom snakecase to_snake_case
#' @aliases NULL ukpolice-package
NULL
