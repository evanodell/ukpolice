#' @export
#' @rdname ukc_stop_search
ukc_stop_search_location <- function(lat, lng, location, date = NULL) {
  .Deprecated("ukc_stop_search_loc")
  date_query <- ukc_date_processing(date)

  if (!missing(location)) {
    query <- paste0(
      "stops-at-location?location_id=", location, date_query
    )
  } else {
    loc_query <- ukc_lat_lng(lat, lng)

    query <- paste0("stops-street?", loc_query, date_query)
  }

  df <- ukc_get_data(query)

  df
}


#' @export
#' @rdname ukc_crime_location
ukc_crime_location <- function(lat, lng, location, date = NULL, ...) {
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
