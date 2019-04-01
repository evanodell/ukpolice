context("test-stop-and-search")

test_that("stop_and_search functions work", {
  ss_no_location <- ukc_stop_search_no_location(
    force = "city-of-london",
    date = "2019-01-01"
  )

  expect_length(ss_no_location, 16)
  expect_true("Arrest" %in% ss_no_location$outcome)
  expect_true("Female" %in% ss_no_location$gender)

  ss_force <- ukc_stop_search_force(force = "city-of-london")

  expect_error(ukc_stop_search_no_location())
  expect_error(ukc_stop_search_force())


  ukc_stop_search2 <- ukc_stop_search_location(
    lat = c(52.268, 53.194, 52.130),
    lng = c(0.543, 0.238, 0.478), date = as.Date("2019-01-01")
  )

  expect_length(ukc_stop_search2, 16)
  expect_equal(nrow(ukc_stop_search2), 5)

  ukc_stop_search3 <- ukc_stop_search_location(
    location = 1142484,
    date = "2019-01"
  )

  expect_length(ukc_stop_search3, 16)
  expect_equal(nrow(ukc_stop_search3), 1)
})
