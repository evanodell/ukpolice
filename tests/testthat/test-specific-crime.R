context("test-specific-crime")

test_that("specific-crime and no-location crime works", {
   no_location <- ukc_crime_no_location(force = "city-of-london",
                                        date = "2019-01")

   expect_length(no_location, 9)

   crime_id <- no_location$persistent_id[[1]]

   expect_equal(
     "734304974ca05eb149572baf1865e4b64a7e8954f6884a6511409ae59b4b477a",
     crime_id
     )

   outcome <- ukc_specific_outcome(crime_id)

   expect_length(outcome, 6)
})
