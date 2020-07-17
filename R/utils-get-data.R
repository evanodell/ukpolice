
# data retrieval function
ukc_get_data <- function(query, ...) {
  x <- httr::GET(paste0(baseurl, query), ...)

  if (httr::status_code(x) != "200") {
    message(paste("Request returned error code:", httr::status_code(x)))
    return(NULL)
  } else {
    df <- tibble::as_tibble(
      jsonlite::fromJSON(httr::content(x, as = "text", encoding = "utf8"),
        flatten = TRUE
      )
    )

    names(df) <- snakecase::to_snake_case(names(df))
    names(df) <- gsub("location_", "", names(df), fixed = TRUE)

    df
  }
}


# separate function for specific crime outcomes cause different format in API
ukc_get_data_specific_crime <- function(query, ...) {
  x <- httr::GET(paste0(baseurl, query), ...)

  if (httr::status_code(x) != "200") {
    message(paste("Request returned error code:", httr::status_code(x)))
    return(NULL)
  } else {
    api_return <- jsonlite::fromJSON(httr::content(x, as = "text", encoding = "utf8"),
      flatten = TRUE
    )

    if (is.null(api_return$outcomes)) {
      df <- tibble::as_tibble(purrr::compact(api_return$crime))
    } else {
      df <- api_return
    }
    df
  }
}

# because neighbourhood data is weird
ukc_get_hood_data <- function(query) {
  api_return <- jsonlite::fromJSON(paste0(baseurl, query))

  api_return$contact_details <- tibble::as_tibble(api_return$contact_details)
  api_return$centre <- tibble::as_tibble(api_return$centre)
  api_return$locations <- tibble::as_tibble(api_return$locations)

  api_return
}
