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
addMlrDataTask(reg, id="Iris", resampling=rdesc) 
addMlrLearner(reg, learner=makeLearner("classif.rpart"))
addExperimentsMlr(reg)

#p = getProblem(reg, "Iris")
#a = getAlgorithm(reg, "rpart")
#j = getJob(reg, 1)
#dyn = p$dynamic(p$static)
#z = a$fun(j, p$static, dyn)

submitJobs(reg)
data = reduceResultsMlr(reg)