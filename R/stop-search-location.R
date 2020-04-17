

#' Stop and search
#'
#' Returns details on stops and searches at a given location. The stop and
#' searches returned in the API, like the crimes, are only an approximation
#' of where the actual stop and searches occurred, they are not the exact
#' locations.
#'
#' @details If specified, `lat` and `lng` must be the same length. If only one
#' set of coordinates are given, all recorded stop and searches within a one
#' mile radius are returned. If multiple pairs, all recorded stop and searches
#' within a custom drawn polygon will be returned.
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
#' @return A tibble with details of stop and searches outcomes.
#' @export
#'
#' @examples
#' \dontrun{
#' ukc_stop_search1 <- ukc_stop_search_location(lat = 52.629729, lng = -1.131592)
#' 
#' ukc_stop_search2 <- ukc_stop_search_location(
#'   lat = c(52.268, 53.194, 52.130),
#'   lng = c(0.543, 0.238, 0.478)
#' )
#' }
#' 
ukc_stop_search_location <- function(lat, lng, location, date = NULL) {
  date_query <- ukc_date_processing(date)

  if (!missing(location)) {
    query <- paste0(
      "stops-at-location?", "location_id=", location, date_query
    )
  } else {
    loc_query <- ukc_lat_lng(lat, lng)

    query <- paste0("stops-street?", loc_query, date_query)
  }

  df <- ukc_get_data(query)

  df
}
