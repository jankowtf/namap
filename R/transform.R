#' Clean up external name \lifecycle{experimental}
#'
#' @param names [[list]] List with name specification (`list(internal = <value>,
#'   external = <value>`)
#'
#' @return [[character]] External name
#' @export
trans__to_external_clean <- function(names) {
  names[["external"]] %>%
    snakecase::to_snake_case()
}
