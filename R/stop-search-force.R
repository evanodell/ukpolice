
#' Stop and Searches by Police Force
#'
#' Returns details of stop and searches carried out by a particular police
#' force. Note that the police force must be specified.
#'
#' @param force A string containing the name of the police force to return data
#' for. Must be specified, and is not case sensitive.
#' See [ukc_forces()] for details.
#' @param date The year and month in "YYYY-MM" form. Also accepts dates in
#' formats that can be coerced to `Date` class with `as.Date()`. If `NULL`,
#' the latest available month will be returned. Note that not all forces
#' will necessarily have reported stop and search data for the latest month;
#' check availability with the [ukc_available()] function.
#'
#' @return A `tibble` with details of stop and searches by a given police force.
#'
#' @seealso [ukc_stop_search_location()]
#' @seealso [ukc_stop_search_no_location()]
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ss_dorset <- ukc_stop_search_force(force = "dorset")
#' }
#'
ukc_stop_search_force <- function(force, date = NULL) {
  if (missing(force)) {
    stop("The police force must be specified", call. = FALSE)
  } else {
    force_query <- paste0("force=", force)
  }

  date_query <- ukc_date_processing(date)

  query <- paste0("stops-force?", force_query, date_query)

  df <- ukc_get_data(query)

  df
}
