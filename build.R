
# Package infos -----------------------------------------------------------

# package_name <- devtools::as.package(".")$package

# Manage renv cache -------------------------------------------------------

# renv_cache <- here::here("renv/cache")
renv_cache <- "renv/cache"
dir.create(renv_cache, recursive = TRUE, showWarnings = FALSE)

Sys.setenv(RENV_PATHS_CACHE = normalizePath(renv_cache))
# Sys.getenv("RENV_PATHS_CACHE")

reinstall_deps <- as.logical(Sys.getenv("RENV_REINSTALL_DEPENDENCIES", FALSE))
# reinstall_deps <- TRUE

# force_cache_update <- TRUE
force_cache_update <- FALSE
ignore_dev_packages <- TRUE

# Install dependencies ----------------------------------------------------

if (reinstall_deps) {
  Sys.setenv(R_CONFIG_COLS = "config_cols.yml")
  Sys.setenv(R_CONFIG_COL_TYPE = "external_clean")

  # Dev packages ignored in snap shots:
  renv::install("devtools")
  # renv::install("reprex")
  # renv::install("here")

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
}

# Dependencies ------------------------------------------------------------

library("magrittr")

# Package infos -----------------------------------------------------------

package_name <- devtools::as.package(".")$package

# Ignore dependencies -----------------------------------------------------

# {here} currently needed by {confx} and the others by {devtools} which is on
# the hit list
if (ignore_dev_packages) {
  renv::settings$ignored.packages(c(
    "devtools",
    "here",
    "reprex",
    "roxygen2",
    "testthat",
    "usethis",
    "rmarkdown"
  ))
} else {
  renv::settings$ignored.packages(character())
}
print(renv::settings$ignored.packages())
# TODO-20200305-1: Resolve undesired dependency on {devtools}

# Populate inst directory -------------------------------------------------

# Ensure clean dir to start with:
fs::dir_ls("inst/api", all = TRUE) %>%
  purrr::walk(~.x %>% fs::file_delete())
fs::file_copy("R/api_server_prod.R", "inst/api/api_server.R", overwrite = TRUE)
fs::file_copy("start_internal.R", "inst/api/start_api_server.R", overwrite = TRUE)

# Ensure built package is not contained in renv.lock ----------------------

renv::remove(devtools::as.package(".")$package)

# Build -------------------------------------------------------------------

fs::dir_create("renv/local") %>%
# Ensure clean dir to start with:
  fs::dir_ls(all = TRUE) %>%
  purrr::walk(~.x %>% fs::file_delete())
usethis::use_build_ignore(c("data", "renv"))
devtools::document()
devtools::build(path = "renv/local")
# install.packages(paste0(package_name, ".tar.gz"), repos = NULL, type="source")
# renv::install(list.files(pattern = paste0(package_name, ".*\\.tar\\.gz")))

# Create snapshot ---------------------------------------------------------

# Important for making execution via bash shell possible!
# Script renv/activate.R needs to be executed again in order to make snapshoting
# work
if (file.exists("renv/activate.R")) {
  source("renv/activate.R")
}

renv::snapshot(confirm = FALSE)

file <- "renv.lock"
renv_lock_hash_current <- digest::digest(readLines(file))

# Copy snapshot to cache builder dir --------------------------------------

# file <- "../cache_builder/renv.lock"
file <- "renv/renv.lock"
renv_lock_hash_cached <- if (file.exists(file)) {
  digest::digest(readLines(file))
} else {
  ""
}

if (renv_lock_hash_current != renv_lock_hash_cached ||
    force_cache_update
) {
  message("Updating cached renv.lock")
  # fs::file_copy("renv.lock", "../cache_builder/renv.lock", overwrite = TRUE)
  fs::file_copy("renv.lock", "renv/renv.lock", overwrite = TRUE)
  # fs::dir_create("../cache_builder/renv")
  # fs::file_copy("renv/activate.R", "../cache_builder/renv/activate.R", overwrite = TRUE)
  # fs::file_copy("renv/settings.dcf", "../cache_builder/renv/settings.dcf", overwrite = TRUE)
  # fs::dir_copy("renv/local", "../cache_builder/renv/local", overwrite = TRUE)
} else {
  message("Cached renv.lock up to date")
}

package_record <- list(list(
  Package = package_name,
  Version = devtools::as.package(".")$version,
  Source = "Filesystem"
))
names(package_record) <- package_name
renv::record(package_record)

# Preps for Docker --------------------------------------------------------

dir.create("renv/cache_docker", recursive = TRUE, showWarnings = FALSE)
