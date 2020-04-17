

#' Specific Neighbourhood Team
#
# Data on a specific neighbourhood policing team.
#
# @param force A string containing the name of the police force to return
# neighbourhoods for. Must be specified, and is not case sensitive.
# @param neighbourhood_id A string containing the ID of a given neighbourhood,
# returned from [ukc_neighbourhood()]. If missing, returns all neighbourhoods
# for the specified police force, using [ukc_neighbourhood()].
#'
#' @export
#'
#' @seealso [ukc_neighbourhood_boundary()]
#' @seealso [ukc_neighbourhoods()]
#' @seealso [ukc_neighbourhood_location()]
#' @rdname ukc_neighbourhood_specific
#' @examples
#' \dontrun{
#' people <- ukc_neighbourhood_team("dorset", "55.CR3001")
#' }
#'
ukc_neighbourhood_team <- function(force, neighbourhood_id) {
  if (missing(force)) {
    stop("The police force must be specified", call. = FALSE)
  }

  if (missing(neighbourhood_id)) {
    df <- ukc_neighbourhoods(force)
  } else {
    query <- paste0(tolower(force), "/", neighbourhood_id, "/people")

    df <- ukc_get_data(query)
  }

  df
}
