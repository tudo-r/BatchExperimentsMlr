source("skel/inst/tests/helpers.R")
library(methods)
library(devtools)
library(testthat)
library(BatchExperiments)

conf = BatchJobs:::getBatchJobsConf()
conf$cluster.functions = BatchJobs:::makeClusterFunctionsUnitTests()
conf$mail.start = "none"
conf$mail.done = "none"
conf$mail.error = "none"

load_all("skel")

reg = makeTestRegistry()
rdesc = makeResampleDesc("CV", iters=2)

#addMlrDataTask(reg, id="Iris", resampling=rdesc) 
simul = function() {
  data.frame(x1=runif(100), x2=runif(100), y=runif(100))
}  
#addSimulatedData(reg, id="s", type="classif", fun=simul, target="y", resampling=rdesc) 
addSimulatedData(reg, id="s", type="regr", fun=simul,  target="y", resampling=rdesc) 

#addMlrLearner(reg, learner=makeLearner("classif.rpart"))
addMlrLearner(reg, learner=makeLearner("regr.rpart", id="rp1"))
addMlrLearner(reg, learner=makeLearner("regr.rpart", id="rp2"))

#pd = makeDesign("s", exhaustive=list(n=c(100, 200)))

addExperiments(reg, prob.designs="s")
submitJobs(reg)
data = reduceResultsMlr(reg)