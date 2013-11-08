context("tune")

test_that("tune", {
  library(mlrTune)
  library(mlrChains)
  reg = makeTestRegistry()
  rdesc = makeResampleDesc("CV", iters=2)
  addMlrDataTask(reg, id="Iris", resampling=rdesc) 
  addMlrLearner(reg, learner=makeLearner("classif.rpart"))
  lrn = makeLearner("classif.svm")
  ps = makeParamSet(
    makeNumericParam("cost", lower=0.1, upper=10),
    makeNumericParam("gamma", lower=0.001, upper=0.1)
  )
  ctrl = makeTuneControlCMAES(start=c(cost=5, gamma=0.05), maxit=10)
  inner = makeResampleDesc("Holdout")
  lrn = makeTuneWrapper(lrn, par.set=ps, control=ctrl, resampling=inner)
  addMlrLearner(reg, learner=lrn)  
  addExperiments(reg)
  submitJobs(reg)
  res = reduceResultsMlr(reg)
  expect_true(is.data.frame(res))
  expect_true(nrow(res) == 4 && ncol(res) == 6)
  expect_true(all(res$mmce >= 0 & res$mmce <= 0.1))
  expect_equal(sapply(res$opt.result, is.null), c(TRUE, TRUE, FALSE, FALSE))
  
  res2 = unwrapOptResults(res)
  expect_true(nrow(res2) == 4 && ncol(res2) == 7)
  expect_true(all(is.na(res2$cost[1:2])))
  expect_true(all(is.na(res2$gamma[1:2])))
  expect_true(all(res2$cost[3:4] >= 0.1 & res2$mmce[3:4] <= 10))
  expect_true(all(res2$gamma[3:4] >= 0.001 & res2$gamma[3:4] <= 0.1))

  res2 = unwrapOptResults(res, keep=TRUE)
  expect_true(nrow(res2) == 4 && ncol(res2) == 8)

  res2 = unwrapOptResults(res, y=TRUE, keep=TRUE)
  expect_true(nrow(res2) == 4 && ncol(res2) == 9)
})  
