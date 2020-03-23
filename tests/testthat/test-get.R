library(testthat)

# Single ------------------------------------------------------------------

context("Get single")

test_that("Get name, as name", {
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

# Single external ---------------------------------------------------------

context("Get single, external")

test_that("Get name, as name", {
  is <- get_name(
    "cols/global/id",
    type = "external"
  )

  should <- "Some ID" %>% dplyr::sym()

  expect_identical(is, should)
})

test_that("Get name, as name", {
  is <- get_name(
    "cols/global/id",
    type = "external",
    as_character = TRUE
  )

  should <- "Some ID"

  expect_identical(is, should)
})

# Single external clean ---------------------------------------------------

context("Get single, external, clean")

test_that("Get name, as name", {
  is <- get_name(
    "cols/global/id",
    type = "external_clean"
  )

  should <- "some_id" %>% dplyr::sym()

  expect_identical(is, should)
})

test_that("Get name, as name", {
  is <- get_name(
    "cols/global/id",
    type = "external_clean",
    as_character = TRUE
  )

  should <- "some_id"

  expect_identical(is, should)
})

# Multiple ----------------------------------------------------------------

context("Get multiple")

test_that("Get names, as name", {
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

# Multiple external -------------------------------------------------------

context("Get multiple, external")

test_that("Get names, as name", {
  is <- get_names(
    "cols/global/id",
    "cols/global/date",
    "cols/global/name",
    type = "external"
  )

  should <- list("Some ID", "Date", "Name") %>% dplyr::syms()

  expect_identical(is, should)
})

test_that("Get names, as character", {
  is <- get_names(
    "cols/global/id",
    "cols/global/date",
    "cols/global/name",
    type = "external",
    as_character = TRUE
  )

  should <- list("Some ID", "Date", "Name")

  expect_identical(is, should)
})

# Multiple external clean -------------------------------------------------

context("Get multiple, external, clean")

test_that("Get names, as name", {
  is <- get_names(
    "cols/global/id",
    "cols/global/date",
    "cols/global/name",
    type = "external_clean"
  )

  should <- list("some_id", "date", "name") %>% dplyr::syms()

  expect_identical(is, should)
})

test_that("Get names, as character", {
  is <- get_names(
    "cols/global/id",
    "cols/global/date",
    "cols/global/name",
    type = "external_clean",
    as_character = TRUE
  )

  should <- list("some_id", "date", "name")

  expect_identical(is, should)
})
