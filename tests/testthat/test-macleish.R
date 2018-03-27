context("macleish")

## TODO: Rename context
## TODO: Add more tests

test_that("data integrity", {
  expect_is(whately_2015, "tbl_df")
  expect_is(orchard_2015, "tbl_df")
  expect_equal(nrow(whately_2015), 6*24*365)
  expect_length(macleish_layers, 10)
  macleish_layers %>%
    sapply(FUN = sf::st_crs) %>%
    t() %>%
    as_data_frame() %>%
    bind_rows() %>%
    pull("proj4string") %>%
    unlist() %>%
    unique() %>%
    expect_equal("+proj=longlat +datum=WGS84 +no_defs")
})
