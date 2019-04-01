
#' Street level crime
#'
#' @details `lat` and `lng` must be the same length.
#'
#'
#' @param lat Latitude. Accepts a single value or a vector of values to create
#' a custom polygon.
#' @param lng Longitude. Accepts a single value or a vector of values to create
#' a custom polygon.
#' @param date The year and month in "YYYY-MM" form. If `NULL`, latest
#' available month will be returned.
#' @param crime_category The category of crime to return. Defaults to
#' returning all crimes. See [ukc_crime_category()] for details.
#'
#' @return A tibble with details of street crimes.
#' @export
#'
#' @examples
#' \donttest{
#' crime <- ukc_street_crime(
#'   lat = 51.5, lng = -0.6,
#'   crime_category = "bicycle-theft"
#' )
#' 
#' crime_poly <- ukc_street_crime(
#'   lat = c(52.268, 52.794, 52.130),
#'   lng = c(0.543, 0.238, 0.478)
#' )
#' }
#' 
ukc_street_crime <- function(lat, lng, date = NULL, crime_category = NULL) {
  date_query <- ukc_date_processing(date)

  if (is.null(crime_category)) {
    crime_query <- "all-crime?"
  } else {
    crime_query <- paste0(crime_category, "?")
  }

  loc_query <- ukc_lat_lng(lat, lng)

  query <- paste0("crimes-street/", crime_query, loc_query, date_query)

  df <- ukc_get_data(query)

  df
}
