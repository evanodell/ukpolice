context("test-neighbourhood-boundary")

test_that("multiplication works", {
  borders <- ukc_neighbourhood_boundary("dorset", "10-1")
  expect_equal(nrow(borders), 812)
  expect_length(borders, 2)



  expect_error(ukc_neighbourhood_boundary())
})
