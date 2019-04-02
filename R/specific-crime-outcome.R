


#' Outcomes for a specific crime
#'
#' Returns the outcomes (case history) for a specified crime.
#' The ID of a crime is a 64-character string, named `persistent_id` and
#' returned by other methods.
#'
#' @param persistent_id The 64 character string that is the unique ID of a
#' particular crime.
#'
#' @return Either a `tibble` with basic details of a crime if no outcome
#' is available, or a list with basic details and a `tibble` containing
#' the outcome if one is available.
#' @export
#'
#' @examples
#' \dontrun{
#' no_location <- ukc_crime_no_location(force = "city-of-london")
#'
#' crime_id <- no_location$persistent_id[[1]]
#'
#' outcome <- ukc_specific_outcome(crime_id)
#' }
#'
ukc_specific_outcome <- function(persistent_id) {
  if (missing(persistent_id)) {
    stop("A persistent_id for a crime must be specified", call. = FALSE)
  }

  query <- paste0("outcomes-for-crime/", persistent_id)

  df <- ukc_get_data_specific_crime(query)

  df
}
