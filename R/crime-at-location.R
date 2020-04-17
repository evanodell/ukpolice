
#' Crimes at a specific location
#'
#' Returns details at crimes at a given
#'
#' @details If specified, `lat` and `lng` must be the same length. `location`
#' or both `lat` and `lng` must be specified.
#'
#' @param lat Latitude. Accepts a single value.
#' @param lng Longitude. Accepts a single value.
#' @param location If specified, `lat` and `lng` are ignored. Location IDs are
#' available through other methods including [ukc_street_crime()].
#' @param date The year and month in "YYYY-MM" form. If `NULL`, latest
#' available month will be returned. Also accepts dates in formats that can be
#' coerced to `Date` class with `as.Date()`.
#'
#' @return A tibble with details of crimes at a given location.
#' @export
#'
#' @examples
#' \dontrun{
#' x <- ukc_crime_location(lat = 52, lng = 0)
#'
#' y <- ukc_crime_location(location = 802171)
#' }
#'
ukc_crime_location <- function(lat, lng, location, date = NULL) {
  date_query <- ukc_date_processing(date)

  if (!missing(location)) {
    query <- paste0(
      "outcomes-at-location?", date_query,
      "&location_id=", location
    )
  } else {
    if (any(length(lat) != 1, length(lng) != 1)) {
      stop("`lat` and `lng` must only contain a single value each.",
        call. = FALSE
      )
    }

    loc_query <- paste0("lat=", lat, "&lng=", lng)

    query <- paste0(
      "crimes-street/outcomes-at-location?",
      loc_query, date_query
    )
  }

  df <- ukc_get_data(query)

  df
}
