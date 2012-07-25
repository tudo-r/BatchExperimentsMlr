addTask = function(reg, task, resampling, measures, seed) {
  type = task$task.desc$type
  x = addProblemChecks(reg, type, resampling, measures, seed)
  static = list(type=type, resampling=resampling, measures=x$measures, task=task)
  addProblem(reg, id=task$task.desc$id, seed=x$seed, static=static, dynamic=function(static) {
    rin = getResamplingInstance(static$resampling, static$task.desc$size)
    list(rin = rin)
  })
}