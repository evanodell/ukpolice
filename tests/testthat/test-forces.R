context("test-forces")

test_that("forces retrieval", {
  # skip_on_cran()
  forcesa1 <- ukc_forces()
  expect_length(forcesa1, 2)
  expect_equal(nrow(forcesa1), 44)
  expect_equal(names(forcesa1), c("id", "name"))

  forcesa2 <- ukc_force_details()
  expect_equal(forcesa2, forcesa1)

  forcesb <- ukc_force_details("city-of-london")
  expect_length(forcesb, 6)
  expect_equal(nrow(forcesb), 5)
  expect_true(all(c("description", "engagement_methods") %in% names(forcesb)))

  forcesc <- ukc_officers("leicestershire")

  expect_length(forcesc, 4)
  expect_equal(nrow(forcesc), 4)
  expect_true(all(c("bio") %in% names(forcesc)))

  expect_message(
    ukc_force_details("safdsdf"),
    "Request returned error code: 404"
  )
})
