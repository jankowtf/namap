#' Map column names from/to internal/external value \lifecycle{experimental}
#'
#' @param cols Mapping information. The actual value depends on the method to be
#'   used (`namap::map_names.list()` and
#'   `namap::map_names.character()`)
#'   `confx::conf_get()`
#' @param from [[character]] List element from `cols` arg to describe the source
#'   of the mapping
#' @param to [[character]] List element from `cols` arg to describe the target
#'   of the mapping
#'
#' @return [[list]] List that can be used in conjunctin with the `!!!` in
#'   functions such as `dplyr::rename()` or `dplyr::select()`. The structure is
#'   `list(<to> = "<from>")`
#' @export
map_names <- function(
  cols,
  from,
  to
) {
  UseMethod("map_names", cols)
}

#' Map column names from/to internal/external value \lifecycle{experimental}
#'
#' @param cols [[list]] List containing the mapping information (`list(internal
#'   = <value>, external = <value>)`) or list of such lists for multiple
#'   columns. It is suggested that this is read from a YAML config file via
#'   `confx::conf_get()`
#' @param from [[character]] List element from `cols` arg to describe the source
#'   of the mapping
#' @param to [[character]] List element from `cols` arg to describe the target
#'   of the mapping
#'
#' @return [[list]] List that can be used in conjunctin with the `!!!` in
#'   functions such as `dplyr::rename()` or `dplyr::select()`. The structure is
#'   `list(<to> = "<from>")`
#' @export
map_names.list <- function(
  cols,
  from = "external",
  to = "internal"
) {
  # Wrap into list if single column data:
  if (cols %>%
      names() %>%
      # is.null() %>%
      purrr::negate(is.null)() %>%
      all()
  ) {
    cols <- list(cols)
  }

  cols %>%
    purrr::map(~
        list(.x[[from]]) %>%
          purrr::set_names(.x[[to]])) %>%
    purrr::flatten()
}

#' Map column names from/to internal/external value \lifecycle{experimental}
#'
#' @param cols [[list]] List containing the mapping information (`list(internal
#'   = <value>, external = <value>)`) or list of such lists for multiple
#'   columns. It is suggested that this is read from a YAML config file via
#'   `confx::conf_get()`
#' @param from [[character]] List element from `cols` arg to describe the source
#'   of the mapping
#' @param to [[character]] List element from `cols` arg to describe the target
#'   of the mapping
#'
#' @return [[list]] List that can be used in conjunctin with the `!!!` in
#'   functions such as `dplyr::rename()` or `dplyr::select()`. The structure is
#'   `list(<to> = "<from>")`
#' @export
map_names.character <- function(
  cols,
  from = "external",
  to = "internal"
) {
  cols <- cols %>%
    purrr::map(~.x %>% confx::conf_get())

  cols %>%
    map_names(
      from = from,
      to = to
    )
}
