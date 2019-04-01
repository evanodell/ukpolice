

#' Neighbourhoods
#'
#' All the neighbourhoods within a given police force area.
#'
#' @param force A string containing the name of the police force to return
#' neighbourhoods for. Must be specified, and is not case sensitive.
#'
#' @return A tibble with data for neighbourhoods within the area of the
#' given police force.
#' @export
#'
#' @seealso [ukc_neighbourhood_boundary()]
#' @seealso [ukc_neighbourhood_specific()]
#' @examples
#' \donttest{
#' places <- ukc_neighbourhoods("dorset")
#' }
#' 
ukc_neighbourhoods <- function(force) {
  if (missing(force)) {
    stop("The police force must be specified", call. = FALSE)
  }

  query <- paste0(tolower(force), "/neighbourhoods")

  df <- ukc_get_data(query)

  df
}
