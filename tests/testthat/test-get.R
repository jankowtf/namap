library(testthat)

# Single ------------------------------------------------------------------

context("Get single")

test_that("Get name, as symbol", {
  is <- get_name(
    "cols/global/id"
  )

  should <- "id" %>% dplyr::sym()

  expect_identical(is, should)
})

test_that("Get name, as character", {
  is <- get_name(
    "cols/global/id",
    as_character = TRUE
  )

  should <- "id"

  expect_identical(is, should)
})

# Multiple ----------------------------------------------------------------

context("Get multiple")

test_that("Get names, as symbol", {
  is <- get_names(
    "cols/global/id",
    "cols/global/date",
    "cols/global/name"
  )

  should <- list("id", "date", "name") %>% dplyr::syms()

  expect_identical(is, should)
})

test_that("Get names, as character", {
  is <- get_names(
    "cols/global/id",
    "cols/global/date",
    "cols/global/name",
    as_character = TRUE
  )

  should <- list("id", "date", "name")

  expect_identical(is, should)
})
