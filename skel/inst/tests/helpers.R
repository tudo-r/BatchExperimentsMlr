makeTestRegistry = function(on.learner.error="stop") {
  if(unlink("runit_files", recursive=TRUE) != 0)
    stop("Could not delete runit_files!")
  makeExperimentRegistryMlr(
    id = "foo",
    seed = 1,
    file.dir = "runit_files",
    on.learner.error=on.learner.error
  )
}
