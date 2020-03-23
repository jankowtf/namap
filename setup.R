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
cred <- git2r::cred_ssh_key(
  "~/.ssh/id_rsa.pub",
  "~/.ssh/id_rsa"
)
repo <- git2r::repository(".git")
git2r::push(repo, credentials = cred)

# Package dependencies ----------------------------------------------------

renv::install("rappster/confx")
usethis::use_package("confx")

renv::install("snakecase")
usethis::use_package("snakecase")

remotes::install_github("tidyverse/rlang", upgrade = "never")
remotes::install_github("r-lib/vctrs", upgrade = "never")
remotes::install_github("tidyverse/dplyr", upgrade = "never")

usethis::use_package("devtools")
usethis::use_package("here")

if (FALSE) {
  # Actual dependencies:
  # renv::install("logger")
}

# v0.0.0.9000 -------------------------------------------------------------

# 2020-03-22
usethis::use_test("name_mapping")

# 2020-03-23
usethis::use_test("get")
usethis::use_test("valid")
