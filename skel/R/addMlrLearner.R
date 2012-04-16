#' Add resampling of an mlr learner as an algorithm.
#'
#' The id of the learner is used as id for the algorithm, but 
#' \dQuote{classif.} or \dQuote{regr.} is removed.
#'
#' @param reg [\code{\link{ExperimentRegistryMlr}}]\cr
#'   Registry.
#' @param learner [\code{\link[mlr]{Learner}}]\cr
#'   Learner.
#' @return [\code{character(1)}]. Invisibly returns the id.
#' @export
addMlrLearner = function(reg, learner) {
  checkArg(reg, "ExperimentRegistryMlr")
  checkArg(learner, "Learner")
  id = learner@id
  # FIXME: remove learner prefix, dot is allowed in ids. not perfect...
  id = str_replace(id, "classif\\.", "")
  id = str_replace(id, "regr\\.", "")
  addAlgorithm(reg, id, fun=function(static, dynamic, ...) {
    if (is.null(static$task))
      task = dynamic$task
    else
      task = static$task
    resample(learner, task=task, resampling=dynamic$rin, measures=static$measures)
  })  
}

