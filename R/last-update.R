
#' Latest crime update
#'
#' Returns the latest month crime data was updated for. The date is in standard
#' ISO format but the actual day is not relevant.
#'
#' @export
ukc_last_update <- function() {
  query <- "crime-last-updated"

  df <- ukc_get_data(query)

  df
}
