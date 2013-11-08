\name{addSimulatedData}
\alias{addSimulatedData}
\title{Add simulated data as a problem.}
\usage{
  addSimulatedData(reg, id, type, fun, target, resampling,
    measures, seed)
}
\arguments{
  \item{reg}{[\code{\link{ExperimentRegistryMlr}}]\cr
  Registry.}

  \item{id}{[\code{character(1)}] \cr Name of problem.}

  \item{type}{[\code{character(1)}] \cr Type of learn task,
  either \code{"classif"} for classification or
  \code{"regr"} for regression.}

  \item{fun}{[\code{function}] \cr Function for data
  generation.}

  \item{target}{[\code{character(1)}] \cr Name of target
  variable.}

  \item{resampling}{[\code{\link[mlr]{ResampleDesc}} |
  \code{\link[mlr]{ResampleInstance}}]\cr Resampling
  strategy.}

  \item{measures}{[\code{\link[mlr]{Measure}} | list of
  \code{\link[mlr]{Measure}}]\cr Performance measures to
  evaluate for task.  Default are the default \pkg{mlr}
  measures for the task.}

  \item{seed}{[\code{integer(1)}]\cr Problem seed.  Default
  is to generate a random one.}
}
\value{
  [\code{character(1)}]. Invisibly returns the id.
}
\description{
  Learners should be compared on the same training / test
  splits, therefore a problem seed will always be used to
  synchronize resampling.
}

