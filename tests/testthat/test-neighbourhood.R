context("test-neighbourhood")

test_that("neighbourhood-returns works", {
  places1 <- ukc_neighbourhoods("dorset")
  places3 <- ukc_neighbourhood_specific("DORSET")

  expect_equal(places1, places3)

  places4 <- ukc_neighbourhood_specific("dorset", "10-1")

  expect_equal(
    places4$name,
    "Northbourne and Wallisdown Safer Neighbourhood Team"
  )
})