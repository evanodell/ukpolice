
#' Crimes without location
#'
#' Returns details of crimes that cannot be mapped to a particular location.
#' Note that the police force must be specified
#'
#' @param force A string containing the name of the police force to return data
#' for. Must be specified, and is not case sensitive.
#' @param crime_category The category of crime to return. Defaults to
#' returning all crimes. See [ukc_crime_category()] for details.
#' See [ukc_forces()] for details.
#' @param date The year and month in "YYYY-MM" form. If `NULL`, latest
#' available month will be returned. Also accepts dates in formats that can be
#' coerced to `Date` class with `as.Date()`.
#'
#' @return A tibble with details of crimes without a specific location.
#' @export
#'
#' @examples
#' \dontrun{
#' no_location <- ukc_crime_no_location(force = "city-of-london")
#' }
#'
ukc_crime_no_location <- function(force, crime_category = NULL, date = NULL) {
  if (missing(force)) {
    stop("The police force must be specified", call. = FALSE)
  } else {
    force_query <- paste0("&force=", force)
  }

  date_query <- ukc_date_processing(date)

  if (is.null(crime_category)) {
    crime_query <- "all-crime&"
  } else {
    crime_query <- paste0(crime_category, "&")
  }

  query <- paste0("crimes-no-location?category=", crime_query, force_query, date_query)

  df <- ukc_get_data(query)

  df
}
