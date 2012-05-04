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
  class(res) = c("ReducedResultsExperimentsMlr", class(res))
  return(res)
}  


print.ReducedResultsExperimentsMlr = function(x, ...) {
  if (nrow(x) > 0) {
    cns = colnames(x)
    if ("pred" %in% cns)
      x$pred = "<yes>"
    if ("opt.result" %in% cns)
      x$opt.result = ifelse(sapply(x$opt.result, is.null), "<no>", "<yes>")
  }
  print.data.frame(x)
}
