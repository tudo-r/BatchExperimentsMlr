#' Reduce results into standard \code{data.frame}.
#' @param reg [\code{\link{ExperimentRegistryMlr}}]\cr
#'   Experiment registry.
#' @param ids [\code{integer}]\cr
#'   Ids of selected experiments. 
#'   Default is all jobs for which results are available.
#' @param strings.as.factors [\code{logical(1)}]
#'   Should all character columns in result be converted to factors?
#'   See \code{\link{reduceResultsExperiments}}.
#'   Default is \code{default.stringsAsFactors()}.
#' @param block.size [\code{integer(1)}]
#'   Results will be fetched in blocks of size \code{block.size}.
#'   See \code{\link{reduceResultsExperiments}}.
#'   Default is 100.
#' @return [\code{data.frame}]. Contains everything implied by \code{\link{reduceResultsExperiments}} and
#'   all measures defined in added problems.
#' @export
reduceResultsMlr = function(reg, ids, strings.as.factors=default.stringsAsFactors(), block.size=100) {
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


#' @method print ReducedResultsExperimentsMlr
#' @S3method print ReducedResultsExperimentsMlr
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
