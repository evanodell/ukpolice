

#' Specific Neighbourhood Boundary
#'
#' Data on a specific neighbourhood boundary, using lat/lng pairs.
#'
#' @param force A string containing the name of the police force to return
#' neighbourhoods for. Must be specified, and is not case sensitive.
#' @param neighbourhood_id A string containing the ID of a given neighbourhood,
#' returned from [ukc_neighbourhood()]. If missing, returns all neighbourhoods
#' for the specified police force, using [ukc_neighbourhood()].
#'
#' @return A tibble with the lat/lng boundaries for a specific neighbourhood.
#' @export
#'
#' @seealso [ukc_neighbourhoods()]
#' @seealso [ukc_specific_neighbourhood()]
#' @seealso [ukc_neighbourhood_location()]
#'
#' @examples
#' \dontrun{
#' # returns a specific neighbourood
#' places4 <- ukc_specific_neighbourhood("dorset", "10-1")
#' 
#' # returns all neighbourhoods as specific neighbourhood is unspecified.
#' places3 <- ukc_specific_neighbourhood("dorset")
#' }
#' 
ukc_neighbourhood_boundary <- function(force, neighbourhood_id) {
  if (missing(force)) {
    stop("The police force must be specified", call. = FALSE)
  }

  if (missing(neighbourhood_id)) {
    df <- ukc_neighbourhood(force)
  } else {
    query <- paste0(tolower(force), "/", neighbourhood_id, "/boundary")

    df <- ukc_get_data(query)
  }

  df
}
