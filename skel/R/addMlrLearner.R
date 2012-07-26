#' Add resampling of an \pkg{mlr} learner as an algorithm.
#' 
#' One resampling iteration is one job.
#' The resulting object is a list with the following items
#' \describe{
#' \item{pred [\code{\link[mlr]{Prediction}}]}{Prediction for resampling iteration.}
#' \item{measures [\code{numeric}]}{Named vector of performance measures, measures are taken from problem definition.}
#' \item{opt.result [\code{\link[mlrTune]{OptResult}}]}{Result of tuning if done, otherwise \code{NULL}.}
#' }
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
  id = learner$id
  # FIXME: remove learner prefix, dot is allowed in ids. not perfect...
  id = gsub("classif\\.", "", id)
  id = gsub("regr\\.", "", id)
  addAlgorithm(reg, id, fun=function(job, static, dynamic, ...) {
    configureMlr(on.learner.error=reg$on.learner.error, on.par.without.desc=reg$on.par.without.desc,
      show.learner.output=reg$show.learner.output)  
    task = getTask(static, dynamic)
    rin = dynamic$rin
    repl = job$repl
    train = rin$train.inds[[repl]]
    test = rin$test.inds[[repl]]
    measures = static$measures
    model = train(learner, task, subset=train)
    pred = predict(model, task, subset=test)
    ms = sapply(measures, function(m) performance(m, pred=pred, model=model, task=task))
    names(ms) = sapply(measures, function(m) m$id)
    # will be NULL if ist does not exist = no tuning was done
    opt.result = model$learner.model$opt.result
    list(pred=pred, measures=ms, opt.result=opt.result)
  })  
}
