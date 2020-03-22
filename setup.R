renv::activate()
renv::upgrade()

renv::install("devtools")
renv::install("rmarkdown")

usethis::use_testthat()
usethis::use_readme_rmd()
usethis::use_news_md()

usethis::use_roxygen_md()
# Run once:
if (FALSE) {
  renv::install("roxygen2md")
  roxygen2md::roxygen2md()
  renv::remove("roxygen2md")
}

renv::install("r-lib/usethis")
usethis::use_lifecycle()

usethis::use_travis()
usethis::use_coverage()


# Actual dependencies:
  renv::install("rappster/confx")
  # renv::install("dplyr")
  remotes::install_github("tidyverse/dplyr", upgrade = "never")
  # renv::install("logger")

  # Typically needed/good idea:
  renv::install("config")
  renv::install("fs")
  renv::install("purrr")
  renv::install("tidyr")
  renv::install("confx")

  # usethis::use_package("here")
  usethis::use_package("gargle")
  usethis::use_package("googleway")
  usethis::use_package("readxl")
  usethis::use_package("writexl")
  usethis::use_package("dplyr")
  usethis::use_package("janitor")
  usethis::use_package("confx")
  usethis::use_package("logger")
  usethis::use_package("shiny")

  usethis::use_package("magrittr")
  usethis::use_package("config")
  usethis::use_package("confx")
  usethis::use_package("fs")
  usethis::use_package("purrr")
  usethis::use_package("tidyr")
  usethis::use_package("stringr")

  if (FALSE) {
    renv::install("mongolite")
    usethis::use_package("mongolite")

    renv::install("curl")
    usethis::use_package("curl")

    renv::install("jsonlite")
    usethis::use_package("jsonlite")

    renv::install("lubridate")
    usethis::use_package("lubridate")

    renv::install("hms")
    usethis::use_package("hms")

    renv::install("future")
    usethis::use_package("future")

    renv::install("future.callr")
    usethis::use_package("future.callr")


    # renv::install("plumber")
    renv::install("rstudio/plumber")
    usethis::use_package("plumber")
    renv::install("rstudio/swagger")

    # Try to get rid of these:
    renv::install("stringi", rebuild = TRUE)
    usethis::use_package("stringi")
    renv::install("rappster/httpeasy", rebuild = TRUE)
    usethis::use_package("httpeasy")
    usethis::use_package("devtools")
  }

  # Because of broken symlinks
  renv::install(c(
    "arrow",
    "base64enc",
    "bit",
    "bit64",
    "codetools",
    "dplyr",
    "highr",
    "knitr",
    "lattice",
    "plyr",
    "reshape2",
    "rmarkdown",
    "DavisVaughan/slide",
    "sodium",
    "swagger",
    "sodium",
    "swagger",
    "tidyr",
    "tidyselect",
    "tinytex",
    "warp",
    "xfun"
  ))
