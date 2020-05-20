context("test-crime-at-location")

test_that("crime at location", {
  x <- ukc_crime_location(lat = 52, lng = 0)
  expect_true(length(x) == 13)

  y <- ukc_crime_location(location = 802171)

  expect_error(ukc_crime_location())
  expect_error(ukc_crime_location(lat = 52, lng = c(0, 0.5)))
})
