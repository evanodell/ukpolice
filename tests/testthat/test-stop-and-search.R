context("test-stop-and-search")

test_that("stop_and_search functions work", {
  ss_no_location <- ukc_stop_search_no_location(
    force = "city-of-london",
    date = "2019-01-01"
  )

  expect_true("Arrest" %in% ss_no_location$outcome)
  expect_true("Female" %in% ss_no_location$gender)

  ss_force <- ukc_stop_search_force(force = "city-of-london")

  expect_error(ukc_stop_search_no_location())
  expect_error(ukc_stop_search_force())

  ukc_stop_search2 <- ukc_stop_search_coord(
    lat = c(52.268, 53.194, 52.130),
    lng = c(0.543, 0.238, 0.478), date = as.Date("2019-01-01")
  )

  expect_equal(nrow(ukc_stop_search2), 5)

  expect_warning(
    ukc_stop_search3 <- ukc_stop_search_location(
      location = 1142484,
      date = "2019-01"
    )
  )
  expect_equal(nrow(ukc_stop_search3), 1)

  poly_df_4 <- data.frame(
    lat = c(52.268, 52.794, 52.130, 52.000),
    long = c(0.543, 0.238, 0.478, 0.400)
  )

  ukc_data_poly_4 <- ukc_stop_search_poly(
    poly_df = poly_df_4,
    date = "2020-03-27"
  )

  expect_true(is.data.frame(ukc_data_poly_4))


  # test SF -----------------------------------------------------------------

  poly_sf <- sf::st_as_sf(poly_df_4, coords = c("lat", "long"))

  ukc_data_poly_sf <- ukc_stop_search_poly(
    poly_df = poly_sf,
    date = "2020-03-27"
  )

  expect_equal(ukc_data_poly_sf, ukc_data_poly_4)

  dat_orig <- data.frame(
    lat = c(52.268, 52.794, 52.130, 52.000),
    lng = c(0.543, 0.238, 0.478, 0.400),
    x = c("one", "two", "three", "four"),
    y = c("four", "three", "two", "one")
  )
  dat_2 <- sp::SpatialPointsDataFrame(
    dat_orig[, c("lat", "lng")],
    dat_orig[, 3:4]
  )

  # test SP -----------------------------------------------------------------

  ukc_data_poly_sp <- ukc_stop_search_poly(dat_2, date = "2020-03-27")

  expect_equal(ukc_data_poly_sp, ukc_data_poly_sf)

  ss_location <- ukc_stop_search_loc(883407, date = "2019-11")

  expect_s3_class(ss_location, "data.frame")

  expect_error(ukc_stop_search_loc())
})
