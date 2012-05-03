#' Reduce results into standard data.frame
#' @param reg [\code{\link{ExperimentRegistryMlr}}]\cr
#'   Experiment registry.
#' @return [\code{data.frame}]. Contains everything implied by \code{\link{reduceResultsSimple}} and
#'   all measures defined in added problems.
#' @export
reduceResultsMlr = function(reg, ids) {
  checkArg(reg, "ExperimentRegistryMlr")
  # FIXME: maybe include train measures
  res = reduceResultsExperiments(reg, ids, 
    fun=function(job, res) {
      d = data.frame(pred=I(list(res$pred)), opt.result=I(list(res$opt.result)))
      cbind(d, as.data.frame(as.list(res$measures)))
  })
  class(res) = c("ReducedResultsBatchExperimentsMlr", class(res))
  return(res)
}  


print.ReducedResultsBatchExperimentsMlr = function(x, ...) {
  x$pred = "<yes>"
  x$opt.result = ifelse(is.null(x$opt.result), "<yes>", "<no>")
  print.data.frame(x)
}
