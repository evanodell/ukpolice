
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
