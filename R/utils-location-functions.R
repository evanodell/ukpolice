
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


utils_poly_processing <- function(poly_df) {
  # check for SP
  if (inherits(poly_df, "Spatial")) {
    if (requireNamespace("sf", quietly = TRUE)) {
      poly_df <- sf::st_as_sf(poly_df)
    } else {
      warning("Package \"sf\" is needed to process Spatial data.",
        call. = TRUE, immediate. = TRUE
      )
    }
  }

  if (inherits(poly_df, "sf")) {
    if (requireNamespace("sf", quietly = TRUE)) {
      poly_df <- as.data.frame(sf::st_coordinates(poly_df, crs = 4326))
      names(poly_df) <- c("lat", "lng")
    } else {
      warning("Package \"sf\" is needed to process simple features.",
        call. = TRUE, immediate. = TRUE
      )
    }
  }

  if (all(c("lat", "lng") %in% names(poly_df))) {
    poly_df2 <- poly_df[c("lat", "lng")]
  } else {
    poly_df2 <- poly_df[c(1:2)]
    names(poly_df2) <- c("lat", "lng")
    # might be a cleaner way to do this
  }

  poly_string <- ukc_poly_paste(
    poly_df2,
    "lng",
    "lat"
  )
}
