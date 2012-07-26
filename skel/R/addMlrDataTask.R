#' Add \pkg{mlrData} task as a problem.
#'
#' Learners should be compared on the same training / test splits, therefore
#' a problem seed will always be used to synchronize resampling. 
#'
#' @param reg [\code{\link{ExperimentRegistryMlr}}]\cr
#'   Registry.
#' @param id [\code{character(1)}]\cr
#'   Id of task in \pkg{mlrData}. Will also be used as id of \pkg{BatchExperiments} problem.
#' @param resampling [\code{\link[mlr]{ResampleDesc}} | \code{\link[mlr]{ResampleInstance}}]\cr
#'   Resampling strategy.
#' @param measures [\code{\link[mlr]{Measure}} | list of \code{\link[mlr]{Measure}}]\cr
#'   Performance measures to evaluate for task.
#'   Default are the default \pkg{mlr} measures for the task.
#' @param naomit [\code{logical(1)}]\cr
#'   Should \code{\link{na.omit}} be called on the data to remove rows with missings?
#'   Default is \code{FALSE}.
#' @param seed [\code{integer(1)}]\cr
#'   Problem seed.
#'   Default is to generate a random one.
#' @return [\code{character(1)}]. Invisibly returns the id.
#' @export
addMlrDataTask = function(reg, id, resampling, measures, naomit=FALSE, seed) {
  require(mlrData)
  checkArg(id, "character", len=1, na.ok=FALSE)
  # FIXME change arg in getDataset
  if (naomit)
    nafun = na.omit
  else
    nafun = na.pass
  env = getDataset(id=id, task="train", assign=FALSE, na.action=nafun)
  addTask(reg, env$task, resampling, measures, seed)
}