#' Add an arbitrary \pkg{mlr} task as a problem.
#'
#' Learners should be compared on the same training / test splits, therefore
#' a problem seed will always be used to synchronize resampling. 
#'
#' @param reg [\code{\link{ExperimentRegistryMlr}}]\cr
#'   Registry.
#' @param task [\code{\link[mlr]{SupervisedTask}}]\cr
#'   Learn task.
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
addMlrTask = function(reg, task, resampling, measures, naomit=FALSE, seed) {
  # FIXME: test this
  if (naomit) {
    data = getTaskData(task)
    data = na.omit(data)
    mlr:::changeData(task, data)
  }
  addTask(reg, task, resampling, measures, seed)
}
