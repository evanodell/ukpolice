
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
#'   crimes, the API will return a 503 status code. ukp_crime_poly converts the
#'   dataframe into lat/lng pairs, separated by colons:
#'   `lat`,`lng`:`lat`,`lng`:`lat`,`lng`. The first and last coordinates need
#'   not be the same — they will be joined by a straight line once the request
#'   is made.
#' @param date, Optional. (YYY-MM), limit results to a specific month. The
#'   latest month will be shown by default. e.g. date = "2013-01"
#' @param ... further arguments passed to or from other methods. For example,
#'   verbose option can be added with
#'   `ukp_api("call", config = httr::verbose())`. See more in `?httr::GET`
#'  documentation
#'   (<https://cran.r-project.org/web/packages/httr/>) and
#'   (<https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html>).
#' @name ukp_stop_search
#'
#' @note The API will return a 400 status code in response to a GET request
#'   longer than 4094 characters. For submitting particularly complex poly
#'   parameters, consider using POST instead.

#' @name ukc_stop_search_poly
#' @examples
#'
#' # with 3 points
#' poly_df_3 = data.frame(lat = c(52.268, 52.794, 52.130),
#'                        long = c(0.543, 0.238, 0.478))
#'
#' ukp_data_poly_3 <- ukp_stop_search_poly(poly_df_3)
#' head(ukp_data_poly_3)
#'
#' # with 4 points
#' poly_df_4 = data.frame(lat = c(52.268, 52.794, 52.130, 52.000),
#'                        long = c(0.543,  0.238,  0.478,  0.400))
#' ukp_data_poly_4 <- ukp_stop_search_poly(poly_df = poly_df_4)
#'
#' head(ukp_data_poly_4)
#'
#' @export
ukc_stop_search_poly <- function(poly_df,
                                 date = NULL,
                                 ...){

  # poly must be a dataframe
  stopifnot(inherits(poly_df, "data.frame"))

  # "poly_df must contain columns named 'lat' and 'long'"
  stopifnot(c("lat", "long") %in% names(poly_df))

  poly_string <- ukp_poly_paste(poly_df,
                                "long",
                                "lat")

  # if date is used
  if (!is.null(date)) {
    api_string <- glue::glue("api/stops-street?poly={poly_string}&date={date}")
    # else if no date is specified
  } else if (is.null(date)) {
    api_string <- glue::glue("api/stops-street?poly={poly_string}")
  } # end ifelse

  result <- ukp_api(api_string)

  extract_result <- purrr::map_dfr(.x = result$content,
                                   .f = ukp_crime_unlist)

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
                                long = as.numeric(long))

  final_result <- dplyr::select(final_result,
                                datetime,
                                lat,
                                long,
                                street_id,
                                street_name,
                                dplyr::everything())

  return(final_result)

} # end function
