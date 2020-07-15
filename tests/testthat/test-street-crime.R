context("test-street-crime")

test_that("street crime works", {
  skip_on_cran()

  crime_lat_list <- ukc_street_crime(
    lat = c(52.268, 52.794, 52.130),
    lng = c(0.543, 0.238, 0.478), date = "2019-01"
  )

  crime <- ukc_street_crime(
    lat = 51.5, lng = -0.6,
    crime_category = "bicycle-theft", date = "2019-01"
  )

  expect_true(all(crime$category == "bicycle-theft"))

  street_crime_outcome2 <- ukc_street_crime_outcome(
    lat = 52, lng = 0,
    date = "2019-01"
  )

  street_crime_outcome3 <- ukc_street_crime_outcome(
    location = 802171,
    date = "2019-01"
  )

  expect_error(ukc_street_crime(
    lat = c(52.268, 52.794, 52.130),
    lng = c(0.543, 0.238)
  ))
})
