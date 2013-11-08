\name{addMlrLearner}
\alias{addMlrLearner}
\title{Add resampling of an \pkg{mlr} learner as an algorithm.}
\usage{
  addMlrLearner(reg, learner)
}
\arguments{
  \item{reg}{[\code{\link{ExperimentRegistryMlr}}]\cr
  Registry.}

  \item{learner}{[\code{\link[mlr]{Learner}}]\cr Learner.}
}
\value{
  [\code{character(1)}]. Invisibly returns the id.
}
\description{
  One resampling iteration is one job. The resulting object
  is a list with the following items \describe{ \item{pred
  [\code{\link[mlr]{Prediction}}]}{Prediction for
  resampling iteration.} \item{measures
  [\code{numeric}]}{Named vector of performance measures,
  measures are taken from problem definition.}
  \item{opt.result
  [\code{\link[mlrTune]{OptResult}}]}{Result of tuning if
  done, otherwise \code{NULL}.} }
}
\details{
  The id of the learner is used as id for the algorithm,
  but \dQuote{classif.} or \dQuote{regr.} is removed.
}

