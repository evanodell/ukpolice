

#' Stop and search
#'
#' Returns details on stops and searches at a given location. The stop and
#' searches returned in the API, like the crimes, are only an approximation
#' of where the actual stop and searches occurred, they are not the exact
#' locations.
#'
#' @details Functions accept one of `lat` and `lng` pairs, `location` IDs or
#' a dataframe containing lat/lng pairs defining the boundary of a custom area.
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
#' @inheritParams ukc_crime_location
#'
#' @return A `tibble` with details of stop and searches outcomes.
#'
#' @seealso [ukc_stop_search_force()]
#' @seealso [ukc_stop_search_no_location()]
#'
#' @export
#' @rdname ukc_stop_search
#' @examples
#' \dontrun{
#'
#' ukc_stop_search2 <- ukc_stop_search_coord(
#'   lat = c(52.268, 53.194, 52.130),
#'   lng = c(0.543, 0.238, 0.478)
#' )
#'
#'
#' poly_df_4 <- data.frame(
#'   lat = c(52.268, 52.794, 52.130, 52.000),
#'   long = c(0.543, 0.238, 0.478, 0.400)
#' )
#'
#' ukc_data_poly_4 <- ukc_stop_search_poly(poly_df = poly_df_4)
#' }
#'
ukc_stop_search_loc <- function(location, date = NULL, ...) {
  date_query <- ukc_date_processing(date)

  if (!missing(location)) {
    query <- paste0(
      "stops-at-location?location_id=", location, date_query
    )
  } else {
    stop("`location` must be specified", call. = FALSE)
  }

  df <- ukc_get_data(query)

  df
}



#' @export
#' @rdname ukc_stop_search
ukc_stop_search_coord <- function(lat, lng, date = NULL, ...) {
  date_query <- ukc_date_processing(date)

  loc_query <- ukc_lat_lng(lat, lng)

  query <- paste0("stops-street?", loc_query, date_query)

  df <- ukc_get_data(query)

  df
}


#' @export
#' @rdname ukc_stop_search
ukc_stop_search_poly <- function(poly_df, date = NULL, ...) {
  poly_string <- utils_poly_processing(poly_df)

  date_query <- ukc_date_processing(date)

  query <- paste0("stops-street?poly=", poly_string, date_query)

  result <- ukc_get_data(query)

  result
}
