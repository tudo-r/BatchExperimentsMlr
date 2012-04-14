#' Adds mlrData task as a problem.
#'
#' @param reg [\code{\link{ExperimentRegistryMlr}}]\cr
#'   Registry.
#' @param id [\code{character(1)}]\cr
#'   Id of task in mlrData. Will also be used as id of BatchExperiments problem.
#' @param rdesc [\code{\link[mlr]{ResampleDesc}} | \code{\link[mlr]{ResampleInstance}}]\cr
#'   Resampling strategy. I
#' @param measures [list of \code{\link[mlr]{Measure}}]\cr
#'   Performance measures to evaluate for task.
#'   Default are the default mlr measures for the task.
#' @return [\code{\link{ExperimentRegistryMlr}}].
#' @export
addMlrDataTask = function(reg, id, rdesc, measures) {
  env = getDataset(id=id, task="train", assign=FALSE)
  if (missing(measures))
    measures = mlr:::default.measures(env$task)
  static = list(task=env$task, rdesc=rdesc, measures=measures)
  addProblem(reg, id=id, static=static, dynamic=function(static) {
    list(
      rin = makeResampleInstance(static$rdesc, task=static$task)
    )
  })
} 