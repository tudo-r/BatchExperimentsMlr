#' @method addExperiments ExperimentRegistryMlr
#' @S3method addExperiments ExperimentRegistryMlr
addExperiments.ExperimentRegistryMlr = function(reg, prob.designs, algo.designs, repls, skip.defined = FALSE) {
  if (!missing(repls))
    stop("'repls' should not be used here, replications are specified via resampling iterations!")
  if (missing(prob.designs)) {
    prob.designs = lapply(getProblemIds(reg), makeDesign)
  } else if (is(prob.designs, "Design")) {
    prob.designs = list(prob.designs)
  }

  for (pd in prob.designs) {
    if (is(pd, "character"))
      pid = pd
    else 
      pid = pd$id
    resampling = getProblem(reg, id=pid)$static$resampling  
    iters = if (is(resampling, "ResampleDesc"))
      resampling$iters
    else
      resampling$rdesc$iters     
    BatchExperiments:::addExperiments.ExperimentRegistry(reg, pd, algo.designs, iters, skip.defined) 
  }
}
