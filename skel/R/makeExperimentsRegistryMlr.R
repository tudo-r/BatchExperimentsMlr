#' Construct registry for mlr benchmark experiments.
#'
#' BatchExperimentsMlr will always be added to the registry packages. 
#' @param ... See [\code{\link{ExperimentRegistry}}].
#' @return [\code{\link{ExperimentRegistryMlr}}].
#' @export
#' @aliases ExperimentRegistryMlr
makeExperimentRegistryMlr = function(...) {
  args = list(...)
  ps = "BatchExperimentsMlr"
  packages = args$packages
  if (!is.null(packages)) {
    checkArg(packages, "character")
    ps = union(ps, packages)
  }
  args$packages = ps
  reg = do.call(makeExperimentRegistry, args)
  class(reg) = c(class(reg), "ExperimentRegistryMlr")
  return(reg)
}