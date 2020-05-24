context("test-neighbourhood-boundary")

test_that("neighbourhood boundaries work", {
  # skip_on_cran()
  borders <- ukc_neighbourhood_boundary("dorset", "55.CB3001")
  expect_length(borders, 2)

  expect_error(ukc_neighbourhood_boundary())
})
