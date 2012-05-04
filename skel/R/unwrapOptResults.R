unwrapOptResults = function(data, x=TRUE, y=FALSE, keep=FALSE) {
  checkArg(data, "ReducedResultsExperimentsMlr")
  checkArg(x, "logical", len=1L, na.ok=FALSE)
  checkArg(y, "logical", len=1L, na.ok=FALSE)
  checkArg(keep, "logical", len=1L, na.ok=FALSE)
  cl = class(data)
  ors = data$opt.result
  if (x) {
    # FIXME report bug in plyr
    xs = lapply(ors, function(or) if(is.null(or)) data.frame(.xxx=1) else as.data.frame(or@x))
    xs = do.call(rbind.fill, xs)
    xs$.xxx = NULL
    data = cbind(data, xs)
  }
  if (y) {
    ys = lapply(ors, function(or) if(is.null(or)) data.frame(.xxx=1) else as.data.frame(as.list(or@y)))
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