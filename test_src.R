source("skel/inst/tests/helpers.R")
library(methods)
library(devtools)
library(testthat)
library(BatchExperiments)
library(mlrChains)

conf = BatchJobs:::getBatchJobsConf()
conf$cluster.functions = BatchJobs:::makeClusterFunctionsUnitTests()
conf$mail.start = "none"
conf$mail.done = "none"
conf$mail.error = "none"

load_all("skel")

reg = makeTestRegistry()
rdesc = makeResampleDesc("CV", iters=2)

addMlrDataTask(reg, id="Iris", resampling=rdesc) 
#simul = function() {
#  data.frame(x1=runif(100), x2=runif(100), y=runif(100))
#}  
#addSimulatedData(reg, id="s", type="classif", fun=simul, target="y", resampling=rdesc) 
#addSimulatedData(reg, id="s", type="regr", fun=simul,  target="y", resampling=rdesc) 

addMlrLearner(reg, learner=makeLearner("classif.rpart"))
#addMlrLearner(reg, learner=makeLearner("regr.rpart", id="rp1"))
#addMlrLearner(reg, learner=makeLearner("regr.rpart", id="rp2"))
lrn = makeLearner("classif.svm")
ps = makeParamSet(
  makeNumericParam("cost", lower=0.1, upper=10),
  makeNumericParam("gamma", lower=0.1, upper=10)
)
ctrl = makeTuneControlCMAES(start=c(1,1), maxit=10)
inner = makeResampleDesc("Holdout")
lrn = makeTuneWrapper(lrn, par.set=ps, control=ctrl, resampling=inner)
addMlrLearner(reg, learner=lrn)

#pd = makeDesign("s", exhaustive=list(n=c(100, 200)))

#addExperiments(reg)
#submitJobs(reg)
#data = reduceResultsMlr(reg)

print(data)
data2 = unwrapOptResults(data, y=T, keep=T)
print(data2)
print(ddply(data, getResultVars(data), summarise, mm=mean(mmce)))
print(ddply(data, getResultVars(data), summarise, mm=mean(mmce)))
