\name{reduceResultsMlr}
\alias{reduceResultsMlr}
\title{Reduce results into standard \code{data.frame}.}
\usage{
  reduceResultsMlr(reg, ids,
    strings.as.factors = default.stringsAsFactors(),
    block.size = 100)
}
\arguments{
  \item{reg}{[\code{\link{ExperimentRegistryMlr}}]\cr
  Experiment registry.}

  \item{ids}{[\code{integer}]\cr Ids of selected
  experiments.  Default is all jobs for which results are
  available.}

  \item{strings.as.factors}{[\code{logical(1)}] Should all
  character columns in result be converted to factors?  See
  \code{\link{reduceResultsExperiments}}.  Default is
  \code{default.stringsAsFactors()}.}

  \item{block.size}{[\code{integer(1)}] Results will be
  fetched in blocks of size \code{block.size}.  See
  \code{\link{reduceResultsExperiments}}.  Default is 100.}
}
\value{
  [\code{data.frame}]. Contains everything implied by
  \code{\link{reduceResultsExperiments}} and all measures
  defined in added problems.
}
\description{
  Reduce results into standard \code{data.frame}.
}

