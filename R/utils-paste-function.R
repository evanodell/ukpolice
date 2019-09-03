# Format long/lat numbers into the right string
#
# `ukc_poly_paste` takes a dataframe of longitude and latitude and pastes
#   them into the correct format required for the ukpolice API
#
# @param data a dataframe
# @param long character
# @param lat character
#
# @return character vector: "lat_1,long_1:lat_2,long_2:...,lat_n,long_n"
#
# @examples
#
# \dontrun{
# ukc_poly_paste(york, "long", "lat")
#}
ukc_poly_paste <- function(data,
                           long,
                           lat){
  #
  # create rowise paste of long and lat, sperated by a comma
  poly_paste <- dplyr::mutate(data,
                              chull_paste = paste(lat,
                                                  long,
                                                  sep = ","))

  # paste together each row, separate by a colon
  return(paste(poly_paste$chull_paste, collapse = ":"))

}


# Compute convex hull of long/lat points
#
# `ukc_geo_chull` computes the convex hull of some lon/lat points, returning
#   a dataframe of the polygon position.
#
# @param data a dataframe
# @param long longitude, a character naming the long name
# @param lat latitude, a character naming the lat name
#
# @return a dataframe with the positions for the polygon.
#
# @examples
# ukc_geo_chull(york,
#               "long",
#               "lat")
# @export
# ukc_geo_chull <- function(data,
#                           long,
#                           lat){
#
#   if (is.data.frame(data) == FALSE){
#     stop("Input must be a data.frame", call. = FALSE)
#   } else if ( (is.character(long) | is.character(lat)) == FALSE) {
#     stop("Long or Lat must be characters")
#   }
#
#   # long_name <- deparse(substitute(long))
#   # lat_name <- deparse(substitute(lat))
#
#   # data_chull <- data[grDevices::chull(data[[long_name]], data[[lat_name]]), ]
#   chull_long_lat <- grDevices::chull(data[[long]], data[[lat]])
#   data_chull <- data[chull_long_lat, ]
#
#   # unsure if I really need to subset the data...
#   # data_chull <- dplyr::select_(data_chull,
#   #                              long_name,
#   #                              lat_name)
#
#   return(data_chull)
# }

