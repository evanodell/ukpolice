
#' England and Wales Police Forces
#'
#' Returns available police forces, details on a specific police force, or
#' officers on that force.
#'
#'
#' @param force The id of the police force, available from the `id` column
#' returned by `ukc_forces`.
#'
#' @rdname ukc_forces
#' @return `ukc_forces` returns a `tibble` with all police forces in England
#' and Wales, `ukc_force_details` returns details on a given police force and
#' `ukc_officers` returns details on senior officers for a given police force.
#' @export
#'
#' @examples
#' \dontrun{
#' forces <- ukc_forces()
#' 
#' cops <- ukc_officers("cumbria")
#' }
ukc_forces <- function() {
  df <- ukc_get_data("forces")

  df
}




#' @export
#' @rdname ukc_forces
ukc_force_details <- function(force = NULL) {
  query <- paste0("forces/", force)

  df <- ukc_get_data(query)

  df
}

#' @export
#' @rdname ukc_forces
ukc_officers <- function(force) {
  query <- paste0("forces/", force, "/people")

  df <- ukc_get_data(query)

  df
}
