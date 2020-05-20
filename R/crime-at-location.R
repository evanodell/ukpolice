
#' Crimes at a specific location
#'
#' Returns details of crimes within a one mile radius of a given point, at a
#' specific location ID, or from within a custom polygon.
#'
#' @details If specified, `lat` and `lng` must be the same length. `location`
#' or both `lat` and `lng` must be specified.
#'
#' @param lat Latitude. Accepts a single value.
#' @param lng Longitude. Accepts a single value.
#' @param location If specified, `lat` and `lng` are ignored. Location IDs are
#' available through other methods including [ukc_street_crime()].
#' @param poly_df a dataframe containing the lat/lng pairs which define
#' the boundary of the custom area, or a [`sf`][sf::sf] or
#' [`SpatialPointsDataFrame`][sp::SpatialPointsDataFrame()]
#' If a custom area contains more than 10,000
#' crimes, the API will return a 503 status code.
#' The internal `ukc_crime_poly` function converts the
#' dataframe into lat/lng pairs, separated by colons:
#' `lat`,`lng`:`lat`,`lng`:`lat`,`lng`. The first and last coordinates need
#' not be the same — they will be joined by a straight line once the request
#' is made.
#' @param date The year and month in "YYYY-MM" form. If `NULL`, latest
#' available month will be returned. Also accepts dates in formats that can be
#' coerced to `Date` class with `as.Date()`.
#' @param ... further arguments passed to [`httr::GET`][httr::GET].
#' @note The API will return a 400 status code in response to a GET request
#' longer than 4094 characters.

#' @return A `tibble` with details of crimes at a given location.
#' @export
#'
#' @examples
#' \dontrun{
#' x <- ukc_crime_location(lat = 52, lng = 0)
#'
#' y <- ukc_crime_location(location = 802171)
#'
#' poly_df_3 <- data.frame(
#'   lat = c(52.268, 52.794, 52.130),
#'   long = c(0.543, 0.238, 0.478)
#' )
#'
#' z <- ukc_crime_poly(poly_df_3)
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


#' @rdname ukc_crime_location
#' @export
ukc_crime_poly <- function(poly_df,
                           date = NULL,
                           ...) {
  poly_string <- utils_poly_processing(poly_df)

  # if date is used
  if (is.null(date) == FALSE) {
    query <- paste0(
      "crimes-street/all-crime?poly=", poly_string,
      "&date=", date
    )
  } else {
    query <- paste0("crimes-street/all-crime?poly=", poly_string)
  }

  result <- ukc_get_data(query)
}
