addMlrLearner = function(reg, learner) {
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

