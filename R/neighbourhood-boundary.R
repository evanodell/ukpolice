

#' Specific Neighbourhood Boundary
#'
#' Data on a specific neighbourhood boundary, using lat/lng pairs.
#'
#' @inheritParams ukc_neighbourhood_specific
#'
#' @return A tibble with the lat/lng boundaries for a specific neighbourhood.
#' @export
#'
#' @seealso [ukc_neighbourhoods()]
#' @seealso [ukc_neighbourhood_specific()]
#' @seealso [ukc_neighbourhood_location()]
#'
#' @examples
#' \dontrun{
#' borders <- ukc_neighbourhood_boundary("dorset", "55.CR3001")
#' }
#'
ukc_neighbourhood_boundary <- function(force, neighbourhood_id) {
  if (missing(force)) {
    stop("The police force must be specified", call. = FALSE)
  }

  if (missing(neighbourhood_id)) {
    df <- ukc_neighbourhoods(force)
  } else {
    query <- paste0(tolower(force), "/", neighbourhood_id, "/boundary")

    df <- ukc_get_data(query)
  }

  df
}
