
ukc_get_data <- function(query) {
  df <- tibble::as_tibble(jsonlite::fromJSON(paste0(baseurl, query)))

  # maybe thing here to check for error codes? maybe use GET instead

  df
}



ukc_get_data_specific_crime <- function (query) {

  api_return <- jsonlite::fromJSON(paste0(baseurl, query))

  if (is.null(api_return$outcomes)) {

    df <- tibble::as_tibble(purrr::compact(api_return$crime))

  } else {
    df <- api_return
  }
  df
}
