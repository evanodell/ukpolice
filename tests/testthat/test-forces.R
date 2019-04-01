context("test-forces")

test_that("forces retrieval", {
  skip_on_cran()
  forcesa <- ukc_forces()
  expect_length(forcesa, 2)
  expect_equal(nrow(forcesa), 44)
  expect_equal(names(forcesa), c("id", "name"))

  forcesb <- ukc_force_details("city-of-london")
  expect_length(forcesb, 6)
  expect_equal(nrow(forcesb), 5)
  expect_true(all(c("description", "engagement_methods") %in% names(forcesb)))

  forcesc <- ukc_officers("leicestershire")

  expect_length(forcesc, 4)
  expect_equal(nrow(forcesb), 5)
  expect_true(all(c("contact_details", "bio") %in% names(forcesc)))
})
