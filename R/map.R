#' Map column names from/to internal/external value \lifecycle{experimental}
#'
#' @param mapping Mapping information. The actual value depends on the method to be
#'   used (`namap::map_names.list()` and
#'   `namap::map_names.character()`)
#'   `confx::conf_get()`
#' @param from [[character]] List element from `mapping` arg to describe the source
#'   of the mapping
#' @param to [[character]] List element from `mapping` arg to describe the target
#'   of the mapping
#'
#' @return [[list]] List that can be used in conjunctin with the `!!!` in
#'   functions such as `dplyr::rename()` or `dplyr::select()`. The structure is
#'   `list(<to> = "<from>")`
#' @export
map_names <- function(
  mapping,
  from,
  to
) {
  UseMethod("map_names", mapping)
}

#' Map column names from/to internal/external value \lifecycle{experimental}
#'
#' @param mapping [[list]] List containing the mapping information (`list(internal
#'   = <value>, external = <value>)`) or list of such lists for multiple
#'   columns. It is suggested that this is read from a YAML config file via
#'   `confx::conf_get()`
#' @param from [[character]] List element from `mapping` arg to describe the source
#'   of the mapping
#' @param to [[character]] List element from `mapping` arg to describe the target
#'   of the mapping
#'
#' @return [[list]] List that can be used in conjunctin with the `!!!` in
#'   functions such as `dplyr::rename()` or `dplyr::select()`. The structure is
#'   `list(<to> = "<from>")`
#' @export
map_names.list <- function(
  mapping,
  from = "external",
  to = "internal"
) {
  # Wrap into list if single column data:
  if (mapping %>%
      names() %>%
      # is.null() %>%
      purrr::negate(is.null)() %>%
      all()
  ) {
    mapping <- list(mapping)
  }

  mapping %>%
    purrr::map(~
        list(.x[[from]]) %>%
          purrr::set_names(.x[[to]])) %>%
    purrr::flatten()
}

#' Map column names from/to internal/external value \lifecycle{experimental}
#'
#' @param mapping [[list]] List containing the mapping information (`list(internal
#'   = <value>, external = <value>)`) or list of such lists for multiple
#'   columns. It is suggested that this is read from a YAML config file via
#'   `confx::conf_get()`
#' @param from [[character]] List element from `mapping` arg to describe the source
#'   of the mapping
#' @param to [[character]] List element from `mapping` arg to describe the target
#'   of the mapping
#'
#' @return [[list]] List that can be used in conjunctin with the `!!!` in
#'   functions such as `dplyr::rename()` or `dplyr::select()`. The structure is
#'   `list(<to> = "<from>")`
#' @export
map_names.character <- function(
  mapping,
  from = "external",
  to = "internal"
) {
  mapping <- mapping %>%
    purrr::map(~.x %>% confx::conf_get(
      from = Sys.getenv("R_CONFIG_NAMES", "config.yml"))
    )

  mapping %>%
    map_names(
      from = from,
      to = to
    )
}
