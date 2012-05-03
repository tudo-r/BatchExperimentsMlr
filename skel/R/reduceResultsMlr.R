#' Reduce results into standard data.frame
#' @param reg [\code{\link{ExperimentRegistryMlr}}]\cr
#'   Experiment registry.
#' @return [\code{data.frame}]. Contains everything implied by \code{\link{reduceResultsSimple}} and
#'   all measures defined in added problems.
#' @export
reduceResultsMlr = function(reg, ids) {
  checkArg(reg, "ExperimentRegistryMlr")
  # aggr is:
  # FIXME: maybe include train measures
  reduceResultsExperiments(reg, ids, 
    fun=function(job, res) {
      d = data.frame(pred=I(list(res$pred)), opt.result=I(list(res$opt.result)))
      cbind(d, as.data.frame(as.list(res$measures)))
  })
}  

