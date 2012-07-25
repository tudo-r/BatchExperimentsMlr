#fixme: dont export but use :::, tests will only work noninteractive

#' @export
getResamplingInstance = function(resampling, size) {
  if (is(resampling, "ResampleDesc"))
    makeResampleInstance(resampling, size=size)
  else 
    resampling
}

#' @export
getTask = function(static, dynamic) {
  if (is.null(static$task))
    dynamic$task
  else
    static$task
}

#' @export
makeTask = function(type, data, target) {
  if (type == "classif") {
    makeClassifTask(data=data, target=target)
  } else {
    makeRegrTask(data=data, target=target)
  }
}