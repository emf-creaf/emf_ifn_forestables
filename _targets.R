# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)
library(crew)
library(fs)

# Set target options:
tar_option_set(
  packages = c("forestables", "cli", "purrr", "dplyr", "future", "stringr", "glue"),
  format = "qs",
  memory = "transient",
  iteration = "list"
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()

# future plan. forestables allows parallelization (uses internally furrr) so
# we establish a plan for forestables
future::plan(future.callr::callr, workers = 6)

# initial data
# When changed, all targets are invalidated and IFN data is downloaded again
# and processed
data_version_path <- file.path("data-raw", "20250708")

# check the folder exists, create if not
if (!fs::dir_exists(data_version_path)) {
  fs::dir_create(data_version_path)
}

# emf_ifn_forestables target list
list(
  # download target, if needed
  tar_target(downloaded_path, get_ifn_data(data_version_path)),
  # harmonization target
  tar_target(
    harmonized, harmonize_ifn_data(downloaded_path)
  ),
  # writing target
  tar_target(
    ifn_files, write_ifn_data(harmonized)
  )
)