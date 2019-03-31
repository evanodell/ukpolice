



#' Neighbourhood Location
#'
#' Find the neighbourhood policing team responsible for a given area, by
#' a set of coordinates.
#'
#' @param lat Latitude
#' @param lng Longitude
#'
#' @return The police force and neighbourhood code of the given coordinates.
#' @export
#'
#' @seealso [ukc_neighbourhood_boundary()]
#' @seealso [ukc_neighbourhoods()]
#' @examples
#' \dontrun{
#' find <- ukc_neighbourhood_location(lat = 51.500617, lng = -0.124629)
#' }
#' 
ukc_neighbourhood_location <- function(lat, lng) {
  if (length(lng) > 1 | length(lat) > 1) {
    stop("`lat` and `lng` must be specified and be a single string or number",
      call. = FALSE
    )
  }

  query <- paste0("locate-neighbourhood?q=", lat, ",", lng)

  df <- ukc_get_data(query)

  df
}
