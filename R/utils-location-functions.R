
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
  if (requireNamespace("sf", quietly = TRUE)) {
    names(poly_df) <- tolower(names(poly_df)) # for matching functions

    # check for SP
    if (inherits(poly_df, "Spatial")) {
      poly_df <- sf::st_as_sf(poly_df, crs = 4326)
    }

    if (inherits(poly_df, "sf")) {
      sf::st_crs(poly_df) <- 4326

      poly_df <- as.data.frame(sf::st_coordinates(poly_df))

      names(poly_df)[names(poly_df) == "X"] <- "lng"
      names(poly_df)[names(poly_df) == "Y"] <- "lat"
    }

    if (all(c("lat", "lng") %in% names(poly_df))) {
      poly_df2 <- poly_df[c("lat", "lng")]
    } else {
      poly_df2 <- poly_df[c(
        grep("^lat", names(poly_df)),
        grep("^lon|^lng", names(poly_df))
      )]

      names(poly_df2) <- c("lat", "lng")
    }

    poly_string <- ukc_poly_paste(
      poly_df2,
      "lng",
      "lat"
    )
  } else {
    warning("Package \"sf\" is needed to process Spatial data.",
      call. = TRUE, immediate. = TRUE
    )
  }
}
