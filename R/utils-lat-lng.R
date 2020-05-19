
# internal function for lat & lng for functions that accept co-ord pairs
ukc_lat_lng <- function(lat, lng) {
  if (length(lat) != length(lng)) {
    stop("`lat` and `lng` must contain the same number of coordinates",
      call. = FALSE
    )
  }

  if (length(lat) > 1) {
    loc_query <- paste0(
      "poly=",
      paste(paste(lat, lng, sep = ","), collapse = ":")
    )
  } else {
    loc_query <- paste0("lat=", lat, "&lng=", lng)
  }
  loc_query
}



# Utility functions used by the crime functions --------------------------------

#' Unlist and clean crime data
#'
#' `ukc_crime_unlist` is a utility function to clean and unlist the data
#'   extracted from the crime data.
#'
#' @param result_content a result from the ukp_api
#'
#' @return  data.frame

ukc_crime_unlist <- function(result_content){

  result_unlist <- unlist(result_content)

  result_df <- as.data.frame(result_unlist,
                             stringsAsFactors = FALSE)

  result_df <- dplyr::mutate(result_df,
                             variables = rownames(result_df))

  result_df <- dplyr::select(result_df,
                             variables,
                             result_unlist)

  result_df <- tidyr::spread(result_df,
                             key = "variables",
                             value = "result_unlist")

  result_df <- tibble::as_tibble(result_df)

  return(result_df)

} # end
