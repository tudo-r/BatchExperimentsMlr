#' Unwrap optimal hyperparameter and performance values from reduced results.
#'
#' Unwrap \code{\link[mlrTune]{OptResult}} from the \code{data.frame} returned by \code{\link{reduceResultsMlr}}.
#'
#' @param data [\code{data.frame}]\cr
#'   Result \code{data.frame} from \code{\link{reduceResultsMlr}}.
#' @param x [\code{logical(1)}]\cr
#'   Should slot \code{x} be extracted? \code{x} contains a named list of hyperparameter values, 
# (or character vector of variables?), 
#'   identified as optimal.
#' @param y [\code{logical(1)}]\cr
#'   Should slot \code{y} be extracted? \code{y} contains the performance values for optimal \code{x}.
#' @param keep [\code{logical(1)}]\cr
#'   Should \code{\link[mlrTune]{OptResult}} be kept in \code{data}? If \code{FALSE} it is removed.
#' @return [\code{data.frame}] \code{data}, possibly augmented by the optimal hyperparameter values and corresponding
#'   performance measures and \code{\link[mlrTune]{OptResult}} removed.
#' @export
unwrapOptResults = function(data, x=TRUE, y=FALSE, keep=FALSE) {
  checkArg(data, "ReducedResultsExperimentsMlr")
  checkArg(x, "logical", len=1L, na.ok=FALSE)
  checkArg(y, "logical", len=1L, na.ok=FALSE)
  checkArg(keep, "logical", len=1L, na.ok=FALSE)
  cl = class(data)
  ors = data$opt.result
  if (x) {
    # FIXME report bug in plyr
    xs = lapply(ors, function(or) if(is.null(or)) data.frame(.xxx=1) else as.data.frame(or$x))
    xs = do.call(rbind.fill, xs)
    xs$.xxx = NULL
    data = cbind(data, xs)
  }
  if (y) {
    ys = lapply(ors, function(or) if(is.null(or)) data.frame(.xxx=1) else as.data.frame(as.list(or$y)))
    ys = do.call(rbind.fill, ys)
    ys$.xxx = NULL
    colnames(ys) = sprintf("opt.%s", colnames(ys)) 
    data = cbind(data, ys)
  }
  if (!keep)
    data$opt.result = NULL
  class(data) = cl
  return(data)
}
