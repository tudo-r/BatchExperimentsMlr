addExperimentsMlr = function(reg, prob.designs, algo.designs, skip.defined = FALSE) {
  checkArg(reg, cl = "ExperimentRegistryMlr")
  if (missing(prob.designs)) {
    prob.designs = lapply(getProblemIds(reg), makeDesign)
  } else if (is(prob.designs, "Design")) {
    prob.designs = list(prob.designs)
  }
  if (missing(algo.designs)) {
    algo.designs = lapply(getAlgorithmIds(reg), makeDesign)
  }

  if (is(prob.designs, "Design"))
    prob.designs = list(prob.designs)
  for (pd in prob.designs) {
    if (is(pd, "character"))
      pid = pd
    else 
      pid = pd$id
    resampling = getProblem(reg, id=pid)$static$resampling  
    iters = if (is(resampling, "ResampleDesc"))
      resampling@iters
    else
      resampling@rdesc@iters     
    addExperiments(reg, pid, algo.designs, iters, skip.defined) 
  }
}
