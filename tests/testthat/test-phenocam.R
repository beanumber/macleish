context("test-phenocam")

test_that("Phenocam works", {
  expect_true(grepl("latest", phenocam_image_url()))
  
  skip_on_cran()
  x <- phenocam_info()
  expect_equal(nrow(x), 1)
  expect_equal(x$site, "macleish")
})
