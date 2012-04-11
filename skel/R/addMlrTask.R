#' Adds an arbitrary mlr task as a problem
addMlrTask = function(reg, task, rdesc, measures) {
  task = mlr:::makeClassifTask(id=id, data=data, target=target)
  static = list(task=task, rdesc=rdesc)
  addProblem(reg, id=id, static=static, dynamic = function(static) {
    list(
      rin = makeResampleInstance(static$rdesc, task=static$task)
    )
  })
}