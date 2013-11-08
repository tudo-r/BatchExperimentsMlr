#' Add simulated data as a problem.
#'
#' Learners should be compared on the same training / test splits, therefore
#' a problem seed will always be used to synchronize resampling. 
#'
#' @param reg [\code{\link{ExperimentRegistryMlr}}]\cr
#'   Registry.
#' @param id [\code{character(1)}] \cr
#'   Name of problem.
#' @param type [\code{character(1)}] \cr
#'   Type of learn task, either \code{"classif"} for classification or \code{"regr"} for regression.
#' @param fun [\code{function}] \cr
#'   Function for data generation.
#' @param target [\code{character(1)}] \cr
#'   Name of target variable.
#' @param resampling [\code{\link[mlr]{ResampleDesc}} | \code{\link[mlr]{ResampleInstance}}]\cr
#'   Resampling strategy.
#' @param measures [\code{\link[mlr]{Measure}} | list of \code{\link[mlr]{Measure}}]\cr
#'   Performance measures to evaluate for task.
#'   Default are the default \pkg{mlr} measures for the task.
#' @param seed [\code{integer(1)}]\cr
#'   Problem seed.
#'   Default is to generate a random one.
#' @return [\code{character(1)}]. Invisibly returns the id.
#' @export
addSimulatedData = function(reg, id, type, fun, target, resampling, measures, seed) {
  x = addProblemChecks(reg, type, resampling, measures, seed)
  checkArg(fun, "function")
  checkArg(target, "character", len=1L, na.ok=FALSE)

  static = list(type=type, resampling=resampling, measures=x$measures, fun=fun, target=target)
  addProblem(reg, id=id, seed=x$seed, static=static, dynamic=function(static, ...) {
    data = static$fun(...)
    task = makeTask(static$type, data, static$target)
    rin = getResamplingInstance(static$resampling, nrow(data))
    list(rin = rin, task=task)
  })
}
