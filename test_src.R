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


  data = iris
  data[,1] = 1
  data[,2] = 2
  task = makeClassifTask(data=data, target="Species")
  rdesc = makeResampleDesc("Holdout")
  addMlrTask(reg, task=task, resampling=rdesc) 
  lrn = makeLearner("classif.qda")
  addMlrLearner(reg, learner=lrn)
  addExperiments(reg)
  submitJobs(reg)

  reg = makeTestRegistry(on.learner.error="quiet")
  addMlrTask(reg, task=task, resampling=rdesc) 
  addMlrLearner(reg, learner=lrn)
  addExperiments(reg)
  submitJobs(reg)
  expect_equal(finDone(reg), 1L)
  