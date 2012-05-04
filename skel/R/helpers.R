getResamplingInstance = function(resampling, size) {
  if (is(resampling, "ResampleDesc"))
    makeResampleInstance(resampling, size=size)
  else 
    resampling
}

getTask = function(static, dynamic) {
  if (is.null(static$task))
    dynamic$task
  else
    static$task
}

makeTask = function(type, data, target) {
  if (type == "classif") {
    makeClassifTask(data=data, target=target)
  } else {
    makeRegrTask(data=data, target=target)
  }
}