addTask = function(reg, task, resampling, measures, seed) {
  checkArg(reg, "ExperimentRegistryMlr")
  checkArg(task, "LearnTask")
  if (!(is(resampling, "ResampleDesc") || is(resampling, "ResampleInstance")))
    stop("'resampling' must be of class 'ResampleDesc' or 'ResampleInstance'!")
  if (missing(measures)) {
    measures = mlr:::default.measures(task)
  } else {
    if (is(measures, "Measure"))
      measures = list(measures)
    checkArg(measures, "list")
    checkListElementClass(measures, "Measure")
  }
  if (missing(seed)) {
    seed = BatchJobs:::getRandomSeed()
  }
  else {
    seed = convertInteger(seed)
    checkArg(seed, "integer", len=1L, lower=1L, na.ok=FALSE)
  }
  static = list(task=task, resampling=resampling, measures=measures)
  addProblem(reg, id=task@desc@id, seed=seed, static=static, dynamic=function(static) {
    if (is(static$resampling, "ResampleDesc"))
      rin = makeResampleInstance(static$resampling, task=static$task)
    else 
      rin = resampling
    list(
      rin = rin
      )
  })
}