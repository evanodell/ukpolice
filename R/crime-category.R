

#' Crime categories
#'
#' @return A tibble with all available categories of crime.
#' @export

ukc_crime_category <- function() {
  query <- "crime-categories"

  df <- ukcop_get_data(query)

  df
}
