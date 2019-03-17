
#' Street level crime outcomes
#'
#' @details If specified, `lat` and `lng` must be the same length. `location`
#' or both `lat` and `lng` must be specified.
#'
#' @param lat Latitude. Accepts a single value or a vector of values to create
#' a custom polygon.
#' @param lng Longitude. Accepts a single value or a vector of values to create
#' a custom polygon.
#' @param location If specified, `lat` and `lng` are ignored. Location IDs are
#' available through other methods including [ukc_street_crime()].
#' @param date The year and month in "YYYY-MM" form. If `NULL`, latest
#' available month will be returned.
#'
#' @return A tibble with details of street crime outcomes.
#' @export
#'
#' @examples
#'

ukc_street_crime_outcome <- function(lat, lng, location, date = NULL) {
  if (is.null(date)) {
    date_query <- NULL
  } else {
    date_query <- paste0("&date=", date)
  }

  if (!missing(location)) {
      query <- paste0("outcomes-at-location?", date_query,
                      "&location_id=", location)
  } else {
  if (length(lat) != length(lng)) {
    stop("`lat` and `lng` must contain the same number of coordinates",
         call. = FALSE)
  }

    if (length(lat) > 1) {
      loc_query <- paste0("poly=",
                          paste(paste(lat, lng, sep = ","), collapse = ":"))

    } else {
      loc_query <- paste0("lat=", lat, "&lng=", lng)
    }

    query <- paste0("crimes-street/outcomes-at-location?",
                    loc_query, date_query)

  }

  df <- ukc_get_data(query)

  df
}
