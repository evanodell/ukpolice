context("test-update")

test_that("empty-functions works", {
  skip_on_cran()

  x <- ukc_last_update()
  expect_true(is.character(x$date))

  crimes <- ukc_crime_category()
  expect_length(crimes, 2)
  expect_true(nrow(crimes) == 15)
  expect_true("drugs" %in% crimes$url)

  available <- ukc_available()

  expect_s3_class(available, "data.frame")
})
