#' Script to call the starting function of brick
#'
#' Load BRICK and start the model  by calling startModel
#'
#' This function loads the package brick, reads in the arguments
#' passed via the command line and calls the startModel function.
#'
#' @author Ricarda Rosemann
#'

library(devtools)
load_all("../brick")

# Only if this file is run directly via Rscript startOutside.R, but not if this file
# is sourced, actually run
if (sys.nframe() == 0L) {
  # We assume here that our working directory is an output directory

  config <- NULL
  path <- NULL
  outputFolder <- "output"
  args <- commandArgs()
  for (k in seq_along(args)) {
    if (args[k] == "-c") {
      config <- args[k + 1]
    } else if (args[k] == "-p") {
      path <- args[k + 1]
    } else if (args[k] == "-o") {
      outputFolder <- args[k + 1]
    }
  }

  startModel(config = config, path = path,
    outputFolder = outputFolder)
}