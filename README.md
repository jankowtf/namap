
<!-- README.md is generated from README.Rmd. Please edit that file -->

# namap

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/rappster/namap.svg?branch=master)](https://travis-ci.com/rappster/namap)
[![Codecov test
coverage](https://codecov.io/gh/rappster/namap/branch/master/graph/badge.svg)](https://codecov.io/gh/rappster/namap?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of namap is to facilitate systematic column name management.

## Installation

``` r
remotes::install_github("namap")
```

## Usage (work in progress)

### Example data

``` r
library(magrittr)

data <- tibble::tibble(
  `Some ID` = letters[1:3],
  Date = c("2020-03-01", "2020-03-02", "2020-03-03"),
  Name = c("John", "Jim", "James"),
  Surname = c("Doe", "Due", "Deo"),
  `Some Value` = 1:3
)
```

### Rename based on mapping specification

From (messy) external to clean internal names:

``` r
cols <- list(
  list(external = "Some ID", internal = "id"),
  list(external = "Date", internal = "date"),
  list(external = "Name", internal = "name"),
  list(external = "Surname", internal = "surname"),
  list(external = "Some Value", internal = "value")
)

col_mapping <- namap::map_names(
  cols = cols,
  from = "external",
  to = "internal"
)

date_renamed <- data %>% 
  dplyr::rename(!!!col_mapping)
date_renamed
#> # A tibble: 3 x 5
#>   id    date       name  surname value
#>   <chr> <chr>      <chr> <chr>   <int>
#> 1 a     2020-03-01 John  Doe         1
#> 2 b     2020-03-02 Jim   Due         2
#> 3 c     2020-03-03 James Deo         3
```

From internal to external names:

``` r
col_mapping <- namap::map_names(
  cols = cols,
  from = "internal",
  to = "external"
)

date_renamed %>%  
  dplyr::rename(!!!col_mapping)
#> # A tibble: 3 x 5
#>   `Some ID` Date       Name  Surname `Some Value`
#>   <chr>     <chr>      <chr> <chr>          <int>
#> 1 a         2020-03-01 John  Doe                1
#> 2 b         2020-03-02 Jim   Due                2
#> 3 c         2020-03-03 James Deo                3
```

### Usage together with `{confx}`

If you use this package in conjunction with
[confx](https://github.com/rappster/confx), the name mapping
specification could be part of a YAML file (e.g. `./config.yml`):

    default:
      cols:
        id:
          internal: id
          external: "Some ID"
        date:
          internal: date
          external: Date
        name:
          internal: name
          external: Name
        surname:
          internal: surname
          external: Surname
        value:
          internal: value
          external: (Some) value

You could then call `map_names()` in the following way:

``` r
cols <- list(
  confx::conf_get("cols/id"),
  confx::conf_get("cols/date"),
  confx::conf_get("cols/name"),
  confx::conf_get("cols/surname"),
  confx::conf_get("cols/value")
)

col_mapping <- namap::map_names(
  cols = cols,
  from = "external",
  to = "internal"
)
```

Or even simpler:

``` r
cols <- c(
  "cols/id",
  "cols/date",
  "cols/name",
  "cols/surname",
  "cols/value"
)

col_mapping <- namap::map_names(
  cols = cols,
  from = "external",
  to = "internal"
)
```
