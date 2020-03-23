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
  as_character = FALSE
) {
  type <- match.arg(type)

  names <- x %>%
    confx::conf_get(from = Sys.getenv("R_CONFIG_NAMES", "config.yml"))

  name <- names[[type]]

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
  as_character = FALSE
) {
  dots <- rlang::list2(...)
  type <- match.arg(type)

  dots %>%
    purrr::map(~.x %>%
        confx::conf_get(from = Sys.getenv("R_CONFIG_NAMES", "config.yml")) %>%
        purrr::pluck(type) %>%
        {
          if (!as_character) {
            dplyr::sym(.)
          } else {
            .
          }
        }
    )
}
