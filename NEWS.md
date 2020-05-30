
# ukpolice 0.2.1

* Fix error occuring on Solaris platform

* Fix error when testing `ukc_stop_search_poly()` caused by comparing responses
  covering different dates.


# ukpolice 0.2.0

* Added Nick Tierney as author, with new `ukc_poly_*` functions, which accept
  `sf` and `sp` objects as well as dataframes of lat/long pairs.

* Deprecated `ukc_crime_location()` in favour of `ukc_crime_coord()` and
  `ukc_crime_loc()`, for consistent function names.
  
* Now using the `httr` for better messages and handling of requests.


# ukpolice 0.1.4

* Changed \donttest to \dontrun to avoid CRAN errors and overburdening the API.

* Misc bug fixes.

# ukpolice 0.1.3

* Remove vignette section causing errors on CRAN.

* Adding in `ukc_available()` function.

* Documentation improvements.

## Code Changes

* Revision to structure of location based searches

# ukpolice 0.1.2

 * Preventing tests from running on CRAN and hammering the API.
 
# ukpolice 0.1.1

 * Replacing  \dontrun{} with \donttest{} in Rd. 
 
 * Fixing minor bug in date handling.

# ukpolice 0.1.0

* Initial release of `ukpolice` package.
