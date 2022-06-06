\name{Qhat}
\alias{Qhat}
\title{
Mean Response or Restricted Mean Response Given a Treatment Regime
}
\description{
Estimates the mean response given a treatment regime if data is uncensored. If data is censored, estimates the restricted mean response given a treatment regime.
}
\usage{
Qhat(y, a, g, wgt = NULL)
}
\arguments{
  \item{y}{vector of responses. Note if logY = TRUE in censored, this value should also be the logarithm.}
  \item{a}{vector of treatments received.}
  \item{g}{vector of the given treatment regime.}
  \item{wgt}{weights to be used if response is censored.}
}
\value{
Returns the estimated mean response or restricted mean response.
}
\references{
Lu, W., Zhang, H. H., and Zeng. D. 
(2013). 
Variable selection for optimal treatment decision. 
Statistical Methods in Medical Research, 22, 493--504. 
PMCID: PMC3303960.

Geng, Y., Lu, W., and Zhang, H. H.
(2015).
On optimal treatment regimes selection for mean survival time.
Statistics in Medicine, 34, 1169--1184.
PMCID: PMC4355217.
}
\author{
Wenbin Lu, Hao Helen Zhang, Donglin Zeng, Yuan Geng, and Shannon T. Holloway}

\examples{

  y <- rnorm(100)
  a <- rbinom(100,1,0.5)
  g <- integer(100)

  Qhat(y = y, a = a, g = g)

}

