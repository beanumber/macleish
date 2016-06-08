context("macleish")

## TODO: Rename context
## TODO: Add more tests

test_that("data integrity", {
  expect_is(whately_2015, "tbl_df")
  expect_is(orchard_2015, "tbl_df")
  expect_equal(nrow(whately_2015), 6*24*365)
  expect_length(macleish_layers, 10)
  expect_equal(unique(sapply(macleish_layers, sp::proj4string)), "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
})
