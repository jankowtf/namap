#' Get name from config \lifecycle{experimental}
#'
#' Get name from config, either as a `name` or `character`.
#' Uses file path stored in environment variable `R_CONFIG_NAMES` (if set) or
#' `./config.yml)` instead
#'
#' @param x [[character]] Name identifier
#' @param type [[character]] Name type, on of `valid__name_types()`
#' @param as_character [[logical]] Return name as `name` (`FALSE`) or `character`
#'   (`TRUE`)
#'
#' @return [[name] or [character]] Desired name that can e.g. be used in
#'   `dplyr::selet(!!<return_value>)` or the like
#' @export
get_name <- function(
  x,
  type = valid__name_types(),
  mapping = list(),
  as_character = FALSE
) {
  type <- match.arg(type)

  R_CONFIG_NAMES <- Sys.getenv("R_CONFIG_NAMES", "config.yml")
  yaml_path_dir <- R_CONFIG_NAMES %>% fs::path_dir()
  yaml_path_file <- R_CONFIG_NAMES %>% fs::path_file()

  names <- if (!length(mapping)) {
    x %>%
      confx::conf_get(from = yaml_path_file, dir_from = yaml_path_dir)
  } else {
    stop("Mapping definition via explit argument not supported yet")
  }

  name <- if (type != "external_clean") {
    names[[type]]
  } else {
    names %>%
      trans__to_external_clean()
  }

  if (!as_character) {
    name %>%
      dplyr::sym()
  } else {
    name
  }
}

#' Get names from config \lifecycle{experimental}
#'
#' Get names from config, either as a list of `names` or `characters`.
#' Uses file path stored in environment variable `R_CONFIG_NAMES` (if set) or
#' `./config.yml)` instead
#'
#' @param ... [[character]] Name identifiers
#' @param type [[character]] Name type, on of `valid__name_types()`
#' @param as_character [[logical]] Return name as `name` (`FALSE`) or `character`
#'   (`TRUE`)
#'
#' @return [[list]] List of desired names (either as `names` or `character`)
#'   that can e.g. be used in `dplyr::select(!!!<return_value>)` or the like
#' @export
get_names <- function(
  ...,
  type = valid__name_types(),
  mapping = list(),
  as_character = FALSE
) {
  dots <- rlang::list2(...)
  type <- match.arg(type)

  R_CONFIG_NAMES <- Sys.getenv("R_CONFIG_NAMES", "config.yml")
  yaml_path_dir <- R_CONFIG_NAMES %>% fs::path_dir()
  yaml_path_file <- R_CONFIG_NAMES %>% fs::path_file()

  dots %>%
    purrr::map(function(.x) {
      names <- if (!length(mapping)) {
        .x %>%
          confx::conf_get(from = yaml_path_file, dir_from = yaml_path_dir)
      } else {
        stop("Mapping definition via explit argument not supported yet")
      }

      names %>%
        {
          if (type != "external_clean") {
            purrr::pluck(., type)
          } else {
            trans__to_external_clean(.)
          }
        } %>%
        {
          if (!as_character) {
            dplyr::sym(.)
          } else {
            .
          }
        }
    })
}
