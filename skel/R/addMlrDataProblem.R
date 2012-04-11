
addMlrProblem = function(reg, id, data, target, rdesc) {
  task = mlr:::makeClassifTask(id=id, data=data, target=target)
  static = list(task=task, rdesc=rdesc)
  addProblem(reg, id=id, static=static, dynamic = function(static) {
    list(
      rin = makeResampleInstance(static$rdesc, task=static$task)
    )
  })
}

addMlrDataProblem = function(reg, id, rdesc) {
  env = mlrData:::getDataset(id=id, task="train", assign=FALSE)
  static = list(task=env$task, rdesc=rdesc)
  addProblem(reg, id=id, static=static, dynamic = function(static) {
    list(
      rin = makeResampleInstance(static$rdesc, task=static$task)
    )
  })
} 