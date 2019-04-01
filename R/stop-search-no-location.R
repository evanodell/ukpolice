
#' Stop and Searches without location
#'
#' Returns details of stop and searches that cannot be mapped to a particular
#' location. Note that the police force must be specified. For all stop and
#' searches carried out by a police force, use [ukc_stop_search_force()].
#'
#' @param force A string containing the name of the police force to return data
#' for. Must be specified, and is not case sensitive.
#' See [ukc_forces()] for details.
#' @param date The year and month in "YYYY-MM" form. If `NULL`, latest
#' available month will be returned. Also accepts dates in formats that can be
#' coerced to `Date` class with `as.Date()`.
#'
#' @return A tibble with details of stop and searches without a specific
#' location.
#' @export
#'
#' @examples
#' \donttest{
#' ss_no_location <- ukc_stop_search_no_location(force = "city-of-london")
#' }
#' 
ukc_stop_search_no_location <- function(force, date = NULL) {
  if (missing(force)) {
    stop("The police force must be specified", call. = FALSE)
  } else {
    force_query <- paste0("&force=", force)
  }

  date_query <- ukc_date_processing(date)

  query <- paste0("stops-no-location?", force_query, date_query)

  df <- ukc_get_data(query)

  df
}
