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