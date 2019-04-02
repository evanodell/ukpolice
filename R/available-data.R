


#' Available data
#'
#' Returns a `tibble` with all available datasets. The `id` column contains the
#' year and month, and other columns contain a list with all police forces
#' reporting data for that month. As of 2019-04-02 only information on
#' stop and search data is returned by this endpoint.
#'
#'
#' @export
ukc_available <- function() {
  query <- "crimes-street-dates"

  df <- ukc_get_data(query)

  df
}
