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

# After initial git commit:
usethis::use_travis()
usethis::use_coverage()


# Package dependencies ----------------------------------------------------

renv::install("rappster/confx")
usethis::use_package("confx")

remotes::install_github("tidyverse/rlang", upgrade = "never")
remotes::install_github("r-lib/vctrs", upgrade = "never")
remotes::install_github("tidyverse/dplyr", upgrade = "never")

if (FALSE) {
  # Actual dependencies:
  # renv::install("logger")
}


# v0.0.0.9000 -------------------------------------------------------------

# 2020-03-22
usethis::use_test("name_mapping")
