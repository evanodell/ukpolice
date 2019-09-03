

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
#' @param poly_df dataframe containing the lat/lng pairs which define the
#' boundary of the custom area. If a custom area contains more than 10,000
#' crimes, the API will return a 503 status code. [ukc_crime_poly()] converts the
#' dataframe into lat/lng pairs, separated by colons:
#' `lat`,`lng`:`lat`,`lng`:`lat`,`lng`. The first and last coordinates need
#' not be the same — they will be joined by a straight line once the request
#' is made.
#' @param ... further arguments passed to or from other methods. For example,
#' verbose option can be added with
#' `ukc_api("call", config = httr::verbose())`. See more in `?httr::GET`
#' documentation
#' (<https://cran.r-project.org/web/packages/httr/>) and
#' (<https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html>).
#' @inheritParams ukc_stop_search_force
#' @note The API will return a 400 status code in response to a GET request
#' longer than 4094 characters. For submitting particularly complex poly
#' parameters, consider using POST instead.
#'
#' @return A `tibble` with details of stop and searches outcomes.
#'
#' @seealso [ukc_stop_search_force()]
#' @seealso [ukc_stop_search_no_location()]
#'
#' @export
#' @rdname ukc_stop_search
#' @examples
#' \donttest{
#' ukc_stop_search1 <- ukc_stop_search_loc(lat = 52.629729, lng = -1.131592)
#'
#' ukc_stop_search2 <- ukc_stop_search_loc(
#'   lat = c(52.268, 53.194, 52.130),
#'   lng = c(0.543, 0.238, 0.478)
#' )
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


# NEED TO ADD ABILITY TO ACCEPT SF, SP, ETC

#' Find stop and search in custom area
#'
#'
#' Returns details on stops and searches within a custom area. The stop and
#' searches returned in the API, like the crimes, are only an approximation
#' of where the actual stop and searches occurred, they are not the exact
#' locations.
#'
#' @param poly_df dataframe containing the lat/lng pairs which define the
#'   boundary of the custom area. If a custom area contains more than 10,000
#'   crimes, the API will return a 503 status code. ukc_crime_poly converts the
#'   dataframe into lat/lng pairs, separated by colons:
#'   `lat`,`lng`:`lat`,`lng`:`lat`,`lng`. The first and last coordinates need
#'   not be the same — they will be joined by a straight line once the request
#'   is made.
#' @param date, Optional. (YYYY-MM), limit results to a specific month. The
#'   latest month will be shown by default. e.g. date = "2013-01"
#'
#' @rdname ukc_stop_search
#' @examples
#'
#' # with 3 points
#' poly_df_3 <- data.frame(
#'   lat = c(52.268, 52.794, 52.130),
#'   long = c(0.543, 0.238, 0.478)
#' )
#'
#' ukc_data_poly_3 <- ukc_stop_search_poly(poly_df_3)
#' head(ukc_data_poly_3)
#'
#' # with 4 points
#' poly_df_4 <- data.frame(
#'   lat = c(52.268, 52.794, 52.130, 52.000),
#'   long = c(0.543, 0.238, 0.478, 0.400)
#' )
#' ukc_data_poly_4 <- ukc_stop_search_poly(poly_df = poly_df_4)
#'
#' head(ukc_data_poly_4)
#' @export
#'
#'
#'
ukc_stop_search_poly <- function(poly_df, date = NULL, ...) {

  # poly must be a dataframe
  stopifnot(inherits(poly_df, "data.frame"))

  # "poly_df must contain columns named 'lat' and 'long'"
  stopifnot(c("lat", "long") %in% names(poly_df))

  poly_string <- ukpolice:::ukc_poly_paste(
    poly_df,
    "long",
    "lat"
  )

  # if date is used
  if (!is.null(date)) {
    query <- glue::glue("stops-street?poly={poly_string}&date={date}")
    # else if no date is specified
  } else if (is.null(date)) {
    query <- glue::glue("stops-street?poly={poly_string}")
  } # end ifelse

  result <- ukc_get_data(query)

  extract_result <- purrr::map_dfr(
    .x = result$content,
    .f = ukc_crime_unlist
  )

  # rename the data
  extract_result <- dplyr::rename(
    extract_result,
    lat = location.latitude,
    long = location.longitude,
    street_id = location.street.id,
    street_name = location.street.name,
    outcome_object_id = outcome_object.id,
    outcome_object_name = outcome_object.name,
  )

  final_result <- dplyr::mutate(extract_result,
                                lat = as.numeric(lat),
                                long = as.numeric(long)
  )

  final_result <- dplyr::select(
    final_result,
    datetime,
    lat,
    long,
    street_id,
    street_name,
    dplyr::everything()
  )

  return(final_result)
} # end function



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
