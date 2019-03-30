context("test-forces")

test_that("forces retrieval", {
  forcesa <- ukc_forces()
  expect_length(forcesa, 2)
  expect_equal(nrow(forcesa), 44)
  expect_equal(names(forcesa), c("id", "name"))
})
