
#' Street level crime outcomes
#'
#' Returns details on crimes at a given location, if given the id of a specific
#' location. If given latitude and longitude, finds the nearest pre-defined
#' location and returns the crimes which occurred there.
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
#' \dontrun{
#' street_crime_outcome1 <- ukc_street_crime_outcome(location = 883498)
#' 
#' street_crime_outcome2 <- ukc_street_crime_outcome(lat = 52, lng = 0)
#' }
#' 
ukc_street_crime_outcome <- function(lat, lng, location, date = NULL) {
  date_query <- ukc_date_processing(date)

  if (!missing(location)) {
    query <- paste0(
      "outcomes-at-location?", date_query,
      "&location_id=", location
    )
  } else {
    loc_query <- ukc_lat_lng(lat, lng)

    query <- paste0("crimes-street/crimes-at-location?", loc_query, date_query)
  }

  df <- ukc_get_data(query)

  df
}
