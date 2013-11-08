\name{makeExperimentRegistryMlr}
\alias{ExperimentRegistryMlr}
\alias{makeExperimentRegistryMlr}
\title{Construct registry for \pkg{mlr} benchmark experiments.}
\usage{
  makeExperimentRegistryMlr(..., on.learner.error = "stop",
    on.par.without.desc = "stop",
    show.learner.output = TRUE)
}
\arguments{
  \item{...}{[any]\cr See
  [\code{\link{ExperimentRegistry}}].}

  \item{on.learner.error}{[\code{character(1)}]\cr See
  [\code{\link[mlr]{configureMlr}}].  Default is
  \dQuote{stop}.}

  \item{on.par.without.desc}{[\code{character(1)}]\cr See
  [\code{\link[mlr]{configureMlr}}].  Default is
  \dQuote{stop}.}

  \item{show.learner.output}{[\code{logical(1)}]\cr See
  [\code{\link[mlr]{configureMlr}}].  Default is
  \code{TRUE}.}
}
\value{
  Nothing.

  [\code{\link{ExperimentRegistryMlr}}].
}
\description{
  \pkg{BatchExperimentsMlr} will always be added to the
  registry packages.
}

