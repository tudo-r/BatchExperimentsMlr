context("experiments")

test_that("simple experiments work", {
  reg = makeTestRegistry()
  rdesc = makeResampleDesc("CV", iters=2)
  # 1 task, 1 learner, 1 measure
  addMlrDataTask(reg, id="Iris", resampling=rdesc) 
  addMlrLearner(reg, learner=makeLearner("classif.rpart"))
  addExperiments(reg)
  submitJobs(reg)
  expect_true(length(findMissingResults(reg)) == 0)
  res = reduceResultsMlr(reg)
  expect_true(is.data.frame(res))
  expect_true(nrow(res) == 2 && ncol(res) == 6)
  expect_true(all(res$mmce >= 0 & res$mmce <= 0.1))
  
  reg = makeTestRegistry()
  # 2 tasks, 2 learners, 1 measure
  addMlrDataTask(reg, id="Iris", resampling=rdesc) 
  addMlrDataTask(reg, id="Ionosphere", resampling=rdesc) 
  addMlrLearner(reg, learner=makeLearner("classif.rpart"))
  addMlrLearner(reg, learner=makeLearner("classif.lda"))
  addExperiments(reg)
  submitJobs(reg)
  expect_true(length(findMissingResults(reg)) == 0)
  res = reduceResultsMlr(reg)
  expect_true(is.data.frame(res))
  expect_true(nrow(res) == 8 && ncol(res) == 6)
  expect_true(all(res$mmce >= 0 & res$mmce <= 0.2))

  reg = makeTestRegistry()
  # 2 tasks, 1 learner, different measures
  addMlrDataTask(reg, id="Iris", resampling=rdesc, measures=list(mmce, ber)) 
  addMlrDataTask(reg, id="Ionosphere", resampling=rdesc, measures=mmce) 
  addMlrLearner(reg, learner=makeLearner("classif.rpart"))
  addExperiments(reg)
  submitJobs(reg)
  expect_true(length(findMissingResults(reg)) == 0)
  res = reduceResultsMlr(reg)
  expect_true(is.data.frame(res))
  expect_true(nrow(res) == 4 && ncol(res) == 7)
  expect_true(all(res$mmce >= 0 & res$mmce <= 0.2))
  expect_true(all(res$ber[1:2] >= 0 & res$ber[1:2] <= 0.1))
  expect_true(all(is.na(res$ber[3:4])))
})  


test_that("problem seed / same resampling works", {
  reg = makeTestRegistry()
  rdesc = makeResampleDesc("Holdout")
  addMlrDataTask(reg, id="Iris", resampling=rdesc) 
  lrn1 = makeLearner(id="rp1", cl="classif.rpart", predict.type="prob")
  lrn2 = makeLearner(id="rp2", cl="classif.rpart", predict.type="prob")
  addMlrLearner(reg, learner=lrn1)
  addMlrLearner(reg, learner=lrn2)
  addExperiments(reg)
  submitJobs(reg)
  p1 = loadResult(reg, 1)$pred$data$prob.setosa
  p2 = loadResult(reg, 2)$pred$data$prob.setosa
  expect_equal(p1, p2)
})  
  
test_that("learners with errors work", {
  data = iris
  data[,1] = 1
  data[,2] = 2
  task = makeClassifTask(data=data, target="Species")
  rdesc = makeResampleDesc("Holdout")
  lrn = makeLearner("classif.qda")

  reg = makeTestRegistry()
  addMlrTask(reg, task=task, resampling=rdesc) 
  addMlrLearner(reg, learner=lrn)
  addExperiments(reg)
  submitJobs(reg)
  expect_equal(findErrors(reg), 1L)

  reg = makeTestRegistry(on.learner.error="quiet")
  addMlrTask(reg, task=task, resampling=rdesc) 
  addMlrLearner(reg, learner=lrn)
  addExperiments(reg)
  submitJobs(reg)
  expect_equal(findDone(reg), 1L)
})   