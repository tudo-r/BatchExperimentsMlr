addProblemChecks = function(reg, type, resampling, measures, seed) {
  checkArg(reg, "ExperimentRegistryMlr")
  checkArg(type, choices=c("classif", "regr"))
  if (!(is(resampling, "ResampleDesc") || is(resampling, "ResampleInstance")))
    stop("'resampling' must be of class 'ResampleDesc' or 'ResampleInstance'!")
  if (missing(measures)) {
    measures = switch(type,
      classif = list(mmce),
      regr = list(mse)
    )
  } else {
    if (is(measures, "Measure"))
      measures = list(measures)
    checkListElementClass(measures, "Measure")
  }
  if (missing(seed)) {
    seed = BatchJobs:::getRandomSeed()
  } else {
    seed = convertInteger(seed)
    checkArg(seed, "integer", len=1L, lower=1L, na.ok=FALSE)
  }
  return(list(measures=measures, seed=seed))
}
