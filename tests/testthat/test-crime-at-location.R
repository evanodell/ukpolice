context("test-crime-at-location")

test_that("crime at location", {
  skip_on_cran()

  x <- ukc_crime_location(lat = 52, lng = 0)
  expect_s3_class(x, "tbl_df")
  expect_true("On or near Windmill Close" %in% x$street_name)

  y <- ukc_crime_location(location = 884227, date = "2020-08")
  expect_s3_class(y, "tbl_df")
  expect_true("Force" %in% y$crime_type)

  expect_error(ukc_crime_location())
  expect_error(ukc_crime_location(lat = 52, lng = c(0, 0.5)))


  poly_df_3 <- data.frame(
    lat = c(52.268, 52.794, 52.130),
    lng = c(0.543, 0.238, 0.478)
  )

  z <- ukc_crime_poly(poly_df_3, date = "2020-01")
  expect_s3_class(z, "data.frame")
  expect_true("anti-social-behaviour" %in% z$category)


  crime_loc <- ukc_crime_loc(883407, date = "2019-11")
  expect_s3_class(crime_loc, "data.frame")


  crime_coord <- ukc_crime_coord(52.1, 0.23, date = "2019-12")
  expect_s3_class(crime_coord, "data.frame")


  expect_error(ukc_stop_search_loc(ukc_crime_loc))

  expect_error(
    ukc_crime_coord(c(51, 52), c(1, 2))
  )
})
