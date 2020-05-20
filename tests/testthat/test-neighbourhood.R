context("test-neighbourhood")

test_that("neighbourhood-returns", {
  # skip_on_cran()
  places1 <- ukc_neighbourhoods("dorset")
  places2 <- ukc_neighbourhood_specific("DORSET")
  places3 <- ukc_neighbourhood_boundary("dorset")

  expect_equal(places1, places2)
  expect_equal(places1, places3)

  expect_error(ukc_neighbourhood_specific())
  expect_error(ukc_neighbourhoods())
  expect_error(ukc_neighbourhood_events())
  expect_error(ukc_neighbourhood_team())
  expect_error(ukc_neighbourhood_priorities())

  places4 <- ukc_neighbourhood_specific("dorset", "55.CB3001")

  neighbour_location <- ukc_neighbourhood_location(
    lat = 51.500617,
    lng = -0.124629
  )

  expect_equal(neighbour_location$neighbourhood, "00BK17N")

  expect_error(ukc_neighbourhood_location())

  expect_error(ukc_neighbourhood_location(lat = c(51, 51), lng = 2))

  places5 <- ukc_neighbourhood_team("dorset")
  places6 <- ukc_neighbourhood_events("leicestershire")
  places7 <- ukc_neighbourhood_priorities("durham")

  places5x <- ukc_neighbourhood_team("dorset", "55.CB3001")
  places6x <- ukc_neighbourhood_events("thames-valley", "N449")
  places7x <- ukc_neighbourhood_priorities("durham", "CLS1")
})
