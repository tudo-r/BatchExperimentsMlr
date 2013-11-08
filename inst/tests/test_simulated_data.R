context("simulated data")

test_that("simuls work", {
  rdesc = makeResampleDesc("CV", iters=2)
  #  no simul params
  simul = function() {
    data.frame(x1=runif(100), x2=runif(100), y=as.factor(rep(1:2, each=50)))
  }  
  reg = makeTestRegistry()
  addSimulatedData(reg, id="s", type="classif", fun=simul,  target="y", resampling=rdesc) 
  addMlrLearner(reg, learner=makeLearner("classif.rpart"))
  addExperiments(reg)
  submitJobs(reg)
  expect_true(length(findMissingResults(reg)) == 0)
  res = reduceResultsMlr(reg)
  expect_true(is.data.frame(res))
  expect_true(nrow(res) == 2 && ncol(res) == 6)
  expect_true(all(res$mmce >= 0.3 & res$mmce <= 0.7))

  #  simul with params
  simul = function(n) {
    data.frame(x1=runif(n), x2=runif(n), y=as.factor(rep(1:2, each=n/2)))
  }  
  reg = makeTestRegistry()
  addSimulatedData(reg, id="s", type="classif", fun=simul, target="y", resampling=rdesc) 
  pd = makeDesign("s", exhaustive=list(n=c(100, 200)))
  addMlrLearner(reg, learner=makeLearner("classif.rpart"))
  addExperiments(reg, prob.designs=pd)
  submitJobs(reg)
  expect_true(length(findMissingResults(reg)) == 0)
  res = reduceResultsMlr(reg)
  expect_true(is.data.frame(res))
  expect_true(nrow(res) == 4  && ncol(res) == 7)
  expect_equal(res$n, c(100, 100, 200, 200))
  expect_true(all(res$mmce >= 0.3 & res$mmce <= 0.7))
})  


test_that("simul seeding works", {
  rdesc = makeResampleDesc("Subsample", iters=1)
  simul = function() {
    data.frame(x1=runif(100), x2=runif(100), y=runif(100))
  }  
  reg = makeTestRegistry()
  addSimulatedData(reg, id="s", type="regr", fun=simul,  target="y", resampling=rdesc) 
  addMlrLearner(reg, learner=makeLearner("regr.rpart", id="rp1"))
  addMlrLearner(reg, learner=makeLearner("regr.rpart", id="rp2"))
  addExperiments(reg)
  submitJobs(reg)
  expect_true(length(findMissingResults(reg)) == 0)
  res = reduceResultsMlr(reg)
  # y and prediction must be the same
  expect_equal(res$pred[[1]]$data$truth, res$pred[[2]]$data$truth)
  expect_equal(res$pred[[1]]$data$response, res$pred[[2]]$data$response)
})  
