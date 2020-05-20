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

  df <- ukc_get_data(query, ...)

  df
}
