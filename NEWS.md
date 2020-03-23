# namap 0.0.0.9005

External clean in `map_names()`

--------------------------------------------------------------------------------

# namap 0.0.0.9004

R_CONFIG_NAMES_TYPE

- New environment variable to control default name type
- Input validation for `from` and `to` based on `valid__name_types()` in
`map_names()`

--------------------------------------------------------------------------------

# namap 0.0.0.9003

Added necessary dependencies to DESCRIPTION file

- `{devtools}` and `{here}` as currently still needed by `{confx}`

--------------------------------------------------------------------------------

# namap 0.0.0.9002

Automatic cleaning of external names

- Automatic cleaning of external names (`$external_clean`)
- Created function `trans__to_external_clean()`
- Started to flexiblize location of YAML file (WIP)

--------------------------------------------------------------------------------

# namap 0.0.0.9001

- Added function `get_name()`
- Added function `get_names()`

--------------------------------------------------------------------------------

# namap 0.0.0.9000

- Original commit
- Added function `map_names()` including unit test
- Update `README.Rmd`
