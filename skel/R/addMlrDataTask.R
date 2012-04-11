#' Adds mlrData task as a problem
addMlrDataTask = function(reg, id, rdesc, measures) {
  env = mlrData:::getDataset(id=id, task="train", assign=FALSE)
  if (missing(measures))
    measures = mlr:::default.measures(env$task)
  static = list(task=env$task, rdesc=rdesc, measures=measures)
  addProblem(reg, id=id, static=static, dynamic=function(static) {
    list(
      rin = makeResampleInstance(static$rdesc, task=static$task)
    )
  })
} 