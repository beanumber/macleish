context("macleish")

## TODO: Rename context
## TODO: Add more tests

test_that("data integrity", {
  expect_is(whately_2015, "tbl_df")
  expect_is(orchard_2015, "tbl_df")
  expect_equal(nrow(whately_2015), 6*24*365)
  expect_length(macleish_layers, 12)
  epsg <- macleish_layers %>%
    purrr::map(sf::st_crs) %>%
    purrr::map_int(`$`, "epsg")
  expect_true(all(epsg == 4326))
  
})
