library(testthat)

context("Valid")

test_that("Valid name types", {
  is <- valid__name_types()

  should <- c("internal", "external", "external_clean")

  expect_identical(is, should)
})
