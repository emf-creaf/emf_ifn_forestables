write_ifn_data <- function(harmonized_data) {
  harmonized_data |>
    dplyr::group_by(version, province_code) |>
    dplyr::group_map(
      .f = \(group_data, group_info) {
        file_name <- file.path(
          Sys.getenv("IFN_DATA_ROOT"),
          glue::glue("{group_info[['version']]}_{group_info[['province_code']]}.rds")
        )
        saveRDS(group_data, file_name)
        return(file_name)
      }
    ) |>
    purrr::flatten_chr()
}