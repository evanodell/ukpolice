context("test-stop-and-search")

test_that("stop_and_search functions work", {
  ss_no_location <- ukc_stop_search_no_location(force = "city-of-london",
                                                date = "2019-01-01")

  expect_length(ss_no_location, 16)
  expect_true("Arrest" %in% ss_no_location$outcome)
  expect_true("Female" %in% ss_no_location$gender)

})
