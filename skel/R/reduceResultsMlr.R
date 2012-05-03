#' Reduce results into standard data.frame
#' @param reg [\code{\link{ExperimentRegistryMlr}}]\cr
#'   Experiment registry.
#' @return [\code{data.frame}]. Contains everything implied by \code{\link{reduceResultsSimple}} and
#'   all measures defined in added problems.
#' @export
reduceResultsMlr = function(reg, ids) {
  checkArg(reg, "ExperimentRegistryMlr")
  reduceResultsSimple(reg, ids, fun=function(job, res) res)
}  
