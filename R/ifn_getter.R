get_ifn_data <- function(path) {
  download_res <- forestables::download_inventory("IFN", destination = path)
  
  # If something went wrong, abort
  if (isFALSE(download_res)) {
    cli::cli_abort("Download failed")
  }

  return(path)
}