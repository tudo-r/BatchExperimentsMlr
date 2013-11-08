\name{addMlrDataTask}
\alias{addMlrDataTask}
\title{Add \pkg{mlrData} task as a problem.}
\usage{
  addMlrDataTask(reg, id, resampling, measures, seed, ...)
}
\arguments{
  \item{reg}{[\code{\link{ExperimentRegistryMlr}}]\cr
  Registry.}

  \item{id}{[\code{character(1)}]\cr Id of task in
  \pkg{mlrData}. Will also be used as id of
  \pkg{BatchExperiments} problem.}

  \item{resampling}{[\code{\link[mlr]{ResampleDesc}} |
  \code{\link[mlr]{ResampleInstance}}]\cr Resampling
  strategy.}

  \item{measures}{[\code{\link[mlr]{Measure}} | list of
  \code{\link[mlr]{Measure}}]\cr Performance measures to
  evaluate for task.  Default are the default \pkg{mlr}
  measures for the task.}

  \item{seed}{[\code{integer(1)}]\cr Problem seed.  Default
  is to generate a random one.}

  \item{...}{[any]\cr Further arguments passed to
  \code{\link[mlrData]{getDataset}}.}
}
\value{
  [\code{character(1)}]. Invisibly returns the id.
}
\description{
  Learners should be compared on the same training / test
  splits, therefore a problem seed will always be used to
  synchronize resampling.
}

