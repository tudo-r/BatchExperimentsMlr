\name{unwrapOptResults}
\alias{unwrapOptResults}
\title{Unwrap optimal hyperparameter and performance values from reduced results.}
\usage{
  unwrapOptResults(data, x = TRUE, y = FALSE, keep = FALSE)
}
\arguments{
  \item{data}{[\code{data.frame}]\cr Result
  \code{data.frame} from \code{\link{reduceResultsMlr}}.}

  \item{x}{[\code{logical(1)}]\cr Should slot \code{x} be
  extracted? \code{x} contains a named list of
  hyperparameter values, identified as optimal.}

  \item{y}{[\code{logical(1)}]\cr Should slot \code{y} be
  extracted? \code{y} contains the performance values for
  optimal \code{x}.}

  \item{keep}{[\code{logical(1)}]\cr Should
  \code{\link[mlrTune]{OptResult}} be kept in \code{data}?
  If \code{FALSE} it is removed.}
}
\value{
  [\code{data.frame}] \code{data}, possibly augmented by
  the optimal hyperparameter values and corresponding
  performance measures and \code{\link[mlrTune]{OptResult}}
  removed.
}
\description{
  Unwrap \code{\link[mlrTune]{OptResult}} from the
  \code{data.frame} returned by
  \code{\link{reduceResultsMlr}}.
}

