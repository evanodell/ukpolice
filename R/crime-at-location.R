
#' Crimes at a specific location
#'
#' Returns details of crimes within a one mile radius of a given point.
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
#' @return A `tibble` with details of crimes at a given location.
#' @export
#'
#' @examples
#' \donttest{
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


#' Extract crime areas within a polygon
#'
#'
#' If a custom area contains more than 10,000 crimes, the API will return a
#' 503 status code.
#'
#' @param poly_df A dataframe containing the lat/lng pairs which define the
#'   boundary of the custom area. The first and last coordinates need
#'   not be the same — they will be joined by a straight line once the request
#'   is made.
#' @param date, Optional. (YYY-MM), limit results to a specific month. The
#'   latest month will be shown by default. e.g. date = "2013-01"
#' @param ... further arguments passed to or from other methods.
#' @note further documentation here:
#'   <https://data.police.uk/docs/method/crime-street/>
#'
#' @examples
#'
#' library(ukpolice)
#'
#' # with 3 points
#' poly_df_3 = data.frame(lat = c(52.268, 52.794, 52.130),
#'                        long = c(0.543, 0.238, 0.478))
#'
#' ukc_data_poly_3 <- ukc_crime_poly(poly_df_3)
#' head(ukc_data_poly_3)
#'
#' # with 4 points
#' poly_df_4 = data.frame(lat = c(52.268, 52.794, 52.130, 52.000),
#'                        long = c(0.543,  0.238,  0.478,  0.400))
#' ukc_data_poly_4 <- ukc_crime_poly(poly_df = poly_df_4)
#'
#' head(ukc_data_poly_4)
#'
#' @export
ukc_crime_poly <- function(poly_df,
                           date = NULL,
                           ...){

  ## Accept SFs?

  # poly must be a dataframe
  stopifnot(inherits(poly_df, "data.frame"))

  # "poly_df must contain columns named 'lat' and 'long'"
  stopifnot(c("lat", "long") %in% names(poly_df))

  # date = NULL

  poly_string <- ukpolice:::ukc_poly_paste(poly_df,
                                "long",
                                "lat")

  # if date is used
  if (is.null(date) == FALSE) {

    result <- ukc_api(
      glue::glue("crimes-street/all-crime?poly={poly_string}&date={date}")
    )

    # else if no date is specified
  } else if (is.null(date) == TRUE) {

    # get the latest date
    # last_date <- ukpolice::ukc_last_update()

    result <- ukc_api(
      glue::glue("api/crimes-street/all-crime?poly={poly_string}")
    )

  } # end ifelse

  extract_result <- purrr::map_dfr(.x = result$content,
                                   .f = ukc_crime_unlist)

  # rename the data
  extract_result <- dplyr::rename(
    extract_result,
    lat = location.latitude,
    long = location.longitude,
    street_id = location.street.id,
    street_name = location.street.name,
    date = month,
    outcome_status = outcome_status.category,
    outcome_date = outcome_status.date
  )

  # ensure that lat and long are numeric
  final_result <- dplyr::mutate(extract_result,
                                lat = as.numeric(lat),
                                long = as.numeric(long))

  final_result <- dplyr::select(final_result,
                                category,
                                persistent_id,
                                date,
                                lat,
                                long,
                                street_id,
                                street_name,
                                context,
                                id,
                                location_type,
                                location_subtype,
                                outcome_status,
                                category)

  return(final_result)

} # end function
