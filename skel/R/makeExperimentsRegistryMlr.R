#' Construct registry for \pkg{mlr} benchmark experiments.
#'
#' \pkg{BatchExperimentsMlr} will always be added to the registry packages. 
#' @param ... [any]\cr
#'   See [\code{\link{ExperimentRegistry}}].
#' @param on.learner.error [\code{character(1)}]\cr
#'   See [\code{\link[mlr]{configureMlr}}].
#'   Default is \dQuote{stop}. 
#' @param on.par.without.desc [\code{character(1)}]\cr
#'   See [\code{\link[mlr]{configureMlr}}].
#'   Default is \dQuote{stop}.
#' @param show.learner.output [\code{logical(1)}]\cr 
#'   See [\code{\link[mlr]{configureMlr}}].
#'   Default is \code{TRUE}.      
#' @return Nothing.
#' @export
#' @return [\code{\link{ExperimentRegistryMlr}}].
#' @export
#' @aliases ExperimentRegistryMlr
makeExperimentRegistryMlr = function(..., on.learner.error="stop", 
  on.par.without.desc="stop" , show.learner.output=TRUE) {
  
  args = list(...)
  ps = "BatchExperimentsMlr"
  packages = args$packages
  if (!is.null(packages)) {
    checkArg(packages, "character")
    ps = union(ps, packages)
  }
  args$packages = ps
  reg = do.call(makeExperimentRegistry, args)
  class(reg) = c("ExperimentRegistryMlr", class(reg))
  reg$on.learner.error = on.learner.error
  reg$on.par.without.desc = on.par.without.desc
  reg$show.learner.output = show.learner.output
  return(reg)
}