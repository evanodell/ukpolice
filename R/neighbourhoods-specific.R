

#' Specific Neighbourhood
#'
#' Data on a specific neighbourhood within a given police force area.
#'
#' @details
#' `ukpolice` contains the following functions for specific neighbourhoods:
#' * `ukc_neighbourhood_specific`
#' * `ukc_neighbourhood_team`
#' * `ukc_neighbourhood_events`
#' * `ukc_neighbourhood_priorities`
#'
#'
#' @param force A string containing the name of the police force to return
#' neighbourhoods for. Must be specified, and is not case sensitive.
#' @param neighbourhood_id A string containing the ID of a given neighbourhood,
#' returned from [ukc_neighbourhoods()]. If missing, returns all neighbourhoods
#' for the specified police force, using [ukc_neighbourhoods()].
#'
#' @return A list with data for a specific neighbourhood, or a tibble with all
#' neighbourhood IDs if no neighbourhood is specified.
#' @export
#'
#' @seealso [ukc_neighbourhood_boundary()]
#' @seealso [ukc_neighbourhoods()]
#' @seealso [ukc_neighbourhood_location()]
#'
#' @rdname ukc_neighbourhood_specific
#' @examples
#' \dontrun{
#' # returns a specific neighbourood
#' places4 <- ukc_neighbourhood_specific("dorset", "55.CR3001")
#'
#' # returns all neighbourhoods as specific neighbourhood is unspecified.
#' places3 <- ukc_neighbourhood_specific("dorset")
#' }
#'
ukc_neighbourhood_specific <- function(force, neighbourhood_id) {
  if (missing(force)) {
    stop("The police force must be specified", call. = FALSE)
  }

  if (missing(neighbourhood_id)) {
    df <- ukc_neighbourhoods(force)
  } else {
    query <- paste0(tolower(force), "/", neighbourhood_id)

    df <- ukc_get_hood_data(query)
  }

  df
}
