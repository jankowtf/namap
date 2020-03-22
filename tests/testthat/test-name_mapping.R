library(testthat)

context("Name mapping")

confx::conf_load(test_path())

data <- tibble::tibble(
  `Some ID` = letters[1:3],
  Date = c("2020-03-01", "2020-03-02", "2020-03-03"),
  Name = c("John", "Jim", "James"),
  Surname = c("Doe", "Due", "Deo"),
  `Some Value` = 1:3
)

# External to internal ----------------------------------------------------

test_that("Name mapping: single column, list, external -> internal", {
  is <- map_names(
    cols = confx::conf_get("cols/global/id"),
    from = "external",
    to = "internal"
  )

  should <- list(id = "Some ID")

  expect_equal(is, should)
})

test_that("Name mapping: single column, character, external -> internal", {
  is <- map_names(
    cols = "cols/global/id",
    from = "external",
    to = "internal"
  )

  should <- list(id = "Some ID")

  expect_equal(is, should)
})

test_that("Name mapping: multiple columns, list, external -> internal", {
  is <- map_names(
    cols = list(
      confx::conf_get("cols/global/id"),
      confx::conf_get("cols/global/date")
    ),
    from = "external",
    to = "internal"
  )

  should <- list(id = "Some ID", date = "Date")

  expect_equal(is, should)
})

test_that("Name mapping: multiple columns, list, external -> internal", {
  is <- map_names(
    cols = c(
      "cols/global/id",
      "cols/global/date"
    ),
    from = "external",
    to = "internal"
  )

  should <- list(id = "Some ID", date = "Date")

  expect_equal(is, should)
})

# Internal to external ----------------------------------------------------

test_that("Name mapping: single column, list, internal -> external", {
  is <- map_names(
    cols = confx::conf_get("cols/global/id"),
    from = "internal",
    to = "external"
  )

  should <- list(`Some ID` = "id")

  expect_equal(is, should)
})

test_that("Name mapping: single column, character, internal -> external", {
  is <- map_names(
    cols = "cols/global/id",
    from = "internal",
    to = "external"
  )

  should <- list(`Some ID` = "id")

  expect_equal(is, should)
})

test_that("Name mapping: multiple columns, list, internal -> external", {
  is <- map_names(
    cols = list(
      confx::conf_get("cols/global/id"),
      confx::conf_get("cols/global/date")
    ),
    from = "internal",
    to = "external"
  )

  should <- list(`Some ID` = "id", Date = "date")

  expect_equal(is, should)
})

test_that("Name mapping: multiple columns, list, internal -> external", {
  is <- map_names(
    cols = c(
      "cols/global/id",
      "cols/global/date"
    ),
    from = "internal",
    to = "external"
  )

  should <- list(`Some ID` = "id", Date = "date")

  expect_equal(is, should)
})
