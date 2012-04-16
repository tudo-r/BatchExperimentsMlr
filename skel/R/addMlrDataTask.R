#' Add mlrData task as a problem.
#'
#' Learners should be compared on the same training / test splits, therefore
#' a problem seed will always be used to synchronize resampling. 
#'
#' @param reg [\code{\link{ExperimentRegistryMlr}}]\cr
#'   Registry.
#' @param id [\code{character(1)}]\cr
#'   Id of task in mlrData. Will also be used as id of BatchExperiments problem.
#' @param resampling [\code{\link[mlr]{ResampleDesc}} | \code{\link[mlr]{ResampleInstance}}]\cr
#'   Resampling strategy.
#' @param measures [\code{\link[mlr]{Measure}} | list of \code{\link[mlr]{Measure}}]\cr
#'   Performance measures to evaluate for task.
#'   Default are the default mlr measures for the task.
#' @param seed [\code{integer(1)}]\cr
#'   Problem seed.
#'   Default is to generate a random one.
#' @return [\code{character(1)}]. Invisibly returns the id.
#' @export
addMlrDataTask = function(reg, id, resampling, measures, seed) {
  checkArg(id, "character", len=1, na.ok=FALSE)
  env = getDataset(id=id, task="train", assign=FALSE)
  addTask(reg, env$task, resampling, measures, seed)
}