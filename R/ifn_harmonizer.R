harmonize_ifn_data <- function(raw_data_path) {
  # cli::cli_inform(c(
  #   "i" = "Harmonizing ifn data for province {province}"
  # ))
  cli::cli_inform(c(
    "i" = "Harmonizing IFN data"
  ))

  provinces <- seq(1, 50) |>
    as.character() |>
    stringr::str_pad(2, "left", "0")
  versions <- c("ifn2", "ifn3", "ifn4")

  forestables::ifn_to_tibble(
    provinces, versions, folder = raw_data_path, .verbose = FALSE
  )
}
