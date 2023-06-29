#' Initiate and submit to SLURM
#'
#' Initiate the output path, set the SLURM configuration and submit all computations to SLURM
#'
#' @author Ricarda Rosemann
#'
#' @param config run configurations
#' @param path character vector with folders to run the model in
#' @param outputFolder directory of output folder
#' @param tasks32 whether run should use 32 parallel tasks
#' @export
#'
library(devtools)

load_all("../brick")

startOutSLURM <- function(config = NULL,
                       path = NULL,
                       outputFolder = "output", tasks32 = FALSE) {

  cfg <- readConfig(config)

  if (tasks32) {
    slurmConfig <- paste("--qos=short --nodes=1 --tasks-per-node=32",
                          "--constraint=broadwell --time=01:00:00")
  } else {
    slurmConfig <- "--qos=priority --nodes=1 --tasks-per-node=16"
  }
  title <- cfg[["title"]]

  argString <- ""
  if (!is.null(config)) {
    argString <- paste(argString, "-c", config)
  }
  if (!is.null(path)) {
    argString <- paste(argString, "-p", path)
  }
  argString <- paste(argString, "-o", outputFolder)

  exitCode <- system(paste0("sbatch --job-name=",
                              title,
                              " --output=log.txt",
                              " --mail-type=END",
                              " --comment=BRICK",
                              " --wrap=\"Rscript ../brickClusterstart/startOutside.R",
                              argString, " \" ",
                              slurmConfig))
  Sys.sleep(1)

  if (exitCode > 0) {
    print("Executing startModel failed.")
  }

}