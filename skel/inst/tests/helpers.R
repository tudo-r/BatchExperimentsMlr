makeTestRegistry = function() {
  if(unlink("runit_files", recursive=TRUE) != 0)
    stop("Could not delete runit_files!")
  makeExperimentRegistryMlr(
    id = "foo",
    seed = 1,
    file.dir = "runit_files"
  )
}
