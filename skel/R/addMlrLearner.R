addMlrLearner = function(reg, id) {
  addAlgorithm(reg, id, fun=function(static, dynamic, ...) {
    id = sprintf("classif.%s", id)
    lrn = makeLearner(id)  
    resample(lrn, task=static$task, resampling=dynamic$rin)
  })  
}

addMlrTunedLearner = function(reg, id, par.set, control, rdesc) {
  addAlgorithm(reg, id, fun=function(static, dynamic, ...) {
    id = sprintf("classif.%s", id)
    lrn = makeLearner(id)
    lrn = makeTuneWrapper(lrn, par.set=par.set, resampling=rdesc, control=control)    
    resample(lrn, task=static$task, resampling=dynamic$rin)
  })  
}

addAllLearners = function(reg, tuner) {

}