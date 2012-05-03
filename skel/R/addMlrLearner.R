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
  # FIXME: we need the iteration 
  id = str_replace(id, "classif\\.", "")
  id = str_replace(id, "regr\\.", "")
  addAlgorithm(reg, id, fun=function(repl, static, dynamic, ...) {
      if (is.null(static$task))
        task = dynamic$task
      else
        task = static$task
      rin = dynamic$rin
      train = rin@train.inds[[repl]]
      test = rin@test.inds[[repl]]
      measures = static$measures
      model = train(learner, task, subset=train)
      pred = predict(model, task, subset=test)
      ms = sapply(measures, function(m) performance(m, pred=pred, model=model, task=task))
      names(ms) = sapply(measurees function(m) m@id)
      #FIXME: set this NULL if it does not exist
      #opt.result = model()
      res = list(pred=pred, opt.result=opt.result, )
      c(res, as.list(ms))
    })  
}
