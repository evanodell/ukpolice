
# data retrieval function
ukc_get_data <- function(query) {
  df <- tibble::as_tibble(jsonlite::fromJSON(paste0(baseurl, query)))

  df
}


# separate function for specific crime outcomes cause different format in API
ukc_get_data_specific_crime <- function(query) {
  api_return <- jsonlite::fromJSON(paste0(baseurl, query))

  if (is.null(api_return$outcomes)) {
    df <- tibble::as_tibble(purrr::compact(api_return$crime))
  } else {
    df <- api_return
  }
  df
}

# because neighbourhood data is weird
ukc_get_hood_data <- function(query) {
  api_return <- jsonlite::fromJSON(paste0(baseurl, query))

  api_return$contact_details <- as.data.frame(api_return$contact_details)
  api_return$centre <- as.data.frame(api_return$centre)

  df <- as_tibble(api_return)

  df
}
