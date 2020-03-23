env__handle_name_type <- function(
  type = valid__name_types(),
  was_missing
) {
  # was_missing <- missing(type)
  # type <- match.arg(type)

  type_envvar <- Sys.getenv("R_CONFIG_NAMES_TYPE")
  if (type_envvar != "" && was_missing) {
    Sys.getenv("R_CONFIG_NAMES_TYPE")
  } else {
    type
  }
}
