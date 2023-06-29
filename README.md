# brickClusterstart

Repo to start the PIAM package brick on the cluster via SLURM.

## Usage

In an R session, first source the file "startOutSLURM.R" and then run the function "startOutSLURM". Optionally, the same parameters as in the function startModel of brick can be passed.

In the current version, the implementation assumes that the user (potentially a brick developer) works in the brick directory; thus brick is called via devtools::load_all(). Furthermore, it is assumed that the repos for brick and brickClusterstart are in the same folder.

Currently, the R working directory needs to be set to the brick directory (via "setwd()")
