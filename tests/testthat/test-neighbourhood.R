context("test-neighbourhood")

test_that("neighbourhood-returns works", {
  places1 <- ukc_neighbourhoods("dorset")
  places2 <- ukc_neighbourhood_specific("DORSET")


  expect_equal(places1, places2)

  expect_error(ukc_neighbourhood_specific())
  expect_error(ukc_neighbourhoods())
  expect_error(ukc_neighbourhood_events())
  expect_error(ukc_neighbourhood_team())
  expect_error(ukc_neighbourhood_priorities())



  places4 <- ukc_neighbourhood_specific("dorset", "10-1")

  expect_equal(
    places4$name,
    "Northbourne and Wallisdown Safer Neighbourhood Team"
  )

  neighbour_location <- ukc_neighbourhood_location(lat = 51.500617,
                                                   lng = -0.124629)

  expect_equal(neighbour_location$neighbourhood, "00BK17N")

  expect_error(ukc_neighbourhood_location())

  places3 <- ukc_neighbourhood_team("dorset")
  places5 <- ukc_neighbourhood_events("thames-valley")
  places6 <- ukc_neighbourhood_priorities("durham")

  places3x <- ukc_neighbourhood_team("dorset", "10-13")
  places5x <- ukc_neighbourhood_events("thames-valley", "N449")
  places6x <- ukc_neighbourhood_priorities("durham", "107")

})
