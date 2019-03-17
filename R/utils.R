
ukc_get_data <- function(query) {

  df <- tibble::as_tibble(jsonlite::fromJSON(paste0(baseurl, query)))

  # thing here to check for error codes

  df
}
