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
# }
ukc_poly_paste <- function(data,
                           lng,
                           lat) {
  poly_paste <- paste(paste(data$lat, data$lng, sep = ","), collapse = ":")

  poly_paste
}
