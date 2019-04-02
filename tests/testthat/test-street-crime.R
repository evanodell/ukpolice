context("test-street-crime")

test_that("multiplication works", {
  skip_on_cran()
  crime_poly <- ukc_street_crime(
    lat = c(52.268, 52.794, 52.130),
    lng = c(0.543, 0.238, 0.478), date = "2019-01"
  )
  expect_length(crime_poly, 9)
  expect_equal(nrow(crime_poly), 91)

  crime <- ukc_street_crime(
    lat = 51.5, lng = -0.6,
    crime_category = "bicycle-theft", date = "2019-01"
  )
  expect_length(crime, 9)
  expect_equal(nrow(crime), 8)
  expect_true(all(crime$category == "bicycle-theft"))

  street_crime_outcome2 <- ukc_street_crime_outcome(
    lat = 52, lng = 0,
    date = "2019-01"
  )
  expect_length(street_crime_outcome2, 9)

  street_crime_outcome3 <- ukc_street_crime_outcome(
    location = 802171,
    date = "2019-01"
  )
  expect_length(street_crime_outcome3, 4)
  expect_equal(street_crime_outcome3$category$code, "no-further-action")

  expect_error(ukc_street_crime(
    lat = c(52.268, 52.794, 52.130),
    lng = c(0.543, 0.238)
  ))
})
