context("test-mass-gis")

test_that("Mass GIS works", {
  elevation <- mass_gis()
  expect_is(elevation, "sf")
  expect_equal(nrow(elevation), 50395)
  expect_equal(max(elevation$CONTOUR_FT), 3360)
  
  expect_warning(macleish_elevation <- macleish_intersect(elevation), "spatially")
  
  expect_equal(nrow(macleish_elevation), 13)
})
