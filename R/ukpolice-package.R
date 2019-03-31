

#' ukpolice: Download Data on UK Police and Crime
#'
#'
#' The API allows for 15 requests each second, but up to 30 in a single second
#' if in a single burst. The API does not require authentication.
#' See the [API documentation](https://data.police.uk/docs/) for more details.
#'
#' @docType package
#' @name ukpolice
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble enframe
#' @importFrom purrr compact
#' @aliases NULL ukpolice-package
NULL
