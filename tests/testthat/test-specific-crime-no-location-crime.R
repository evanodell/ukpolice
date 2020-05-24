context("test-specific-crime")

test_that("specific-crime and no-location crime", {
  # skip_on_cran()
  no_location <- ukc_crime_no_location(
    force = "city-of-london",
    date = "2019-01"
  )

  expect_true(all(is.na(no_location$location)))

  expect_true(
    "a832abdef7dc2a9a794ca3ce9730e541619c316e6cc87132334a50ec7762b8ae" %in%
      no_location$persistent_id
  )

  outcome <- ukc_specific_outcome(
    "a832abdef7dc2a9a794ca3ce9730e541619c316e6cc87132334a50ec7762b8ae"
  )

  expect_length(outcome, 2)

  outcome2 <- ukc_specific_outcome(
    "590d68b69228a9ff95b675bb4af591b38de561aa03129dc09a03ef34f537588c"
  )

  expect_length(outcome2, 2)
  expect_true(is.list(outcome2))


  expect_message(
    ukc_specific_outcome("asdffsda"),
    "Request returned error code: 404"
  )

  no_location2 <- ukc_crime_no_location(
    force = "city-of-london",
    date = "2019-01",
    crime_category = "drugs"
  )

  expect_true(all(no_location2$category == "drugs"))

  expect_error(ukc_crime_no_location())
  expect_error(ukc_specific_outcome())
})
