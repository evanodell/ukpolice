
ukc_date_processing <- function(date) {
  if (is.null(date)) {
    date_query <- NULL
  } else {
    if (nchar(as.character(date)) > 7) {
      date <- substr(as.Date(date), 1, 7)
    }

    date_query <- paste0("&date=", date)
  }

  date_query
}
