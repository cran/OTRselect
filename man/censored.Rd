\name{censored}
\alias{censored}
\title{
Variable Selection for Optimal Treatment Decision with Censored Survival Times
}
\description{
A penalized regression framework that can simultaneously estimate the optimal treatment strategy and identify important variables when the response is continuous and censored. This method uses an inverse probability weighted least squares estimation with adaptive LASSO penalty for variable selection.}
\usage{
censored(x, y, a, delta, propen, phi, logY = TRUE, 
         intercept = TRUE)
}
\arguments{
  \item{x}{Matrix or data.frame of model covariates.}
  \item{y}{Vector of response. Note that this data is used to estimate the Kaplan-Meier Curve and should not be log(T).}
  \item{a}{Vector of treatment received. Treatments must be coded as integers or numerics that can be recast as integers without loss of information.}
  \item{delta}{Event indicator vector. The indicator must be coded as 0/1 where 0=no event and 1=event.}
  \item{propen}{Vector or matrix of propensity scores for each treatment. If a vector, the propensity is assumed to be the same for all samples. Column or element order must correspond to the sort order of the treatment variable, i.e., 0,1,2,3,... If the number of columns/elements in propen is one fewer than the total number of treatment options, it is assumed that the base or lowest valued treatment has not been provided. }
  \item{phi}{A character \{'c' or 'l'\} indicating if the constant ('c') or linear ('l') baseline mean function is to be used.}
  \item{logY}{TRUE/FALSE indicating if log(y) is to be used for regression.}
  \item{intercept}{TRUE/FALSE indicating if an intercept is to be included in phi model. }
}
\value{
A list object containing
\item{beta}{A vector of the estimated regression coefficients after variable selection.}
\item{optTx}{The estimated optimal treatment for each sample.}
}
\references{
Geng, Y., Lu, W., and Zhang, H. H.
(2015).
On optimal treatment regimes selection for mean survival time.
Statistics in Medicine, 34, 1169--1184.
PMCID: PMC4355217.
}
\author{
Wenbin Lu, Hao Helen Zhang, Yuan Geng, and Shannon T. Holloway}

\examples{
  sigma <- diag(10)
  ct <- 0.5^{1L:9L}
  rst <- unlist(sapply(1L:9L,function(x){ct[1L:{10L-x}]}))
  sigma[lower.tri(sigma)] <- rst
  sigma[upper.tri(sigma)] <- t(sigma)[upper.tri(sigma)]

  M <- t(chol(sigma))
  Z <- matrix(rnorm(1000),10,100)
  X <- t(M\%*\%Z)

  A <- rbinom(100,1,0.5)

  Y <- rweibull(100,shape=0.5,scale=1)
  C <- rweibull(100,shape=0.5,scale=1.5)

  delta <- as.integer(C <= Y)

  Y[delta > 0.5] <- C[delta>0.5]

  dat <- data.frame(X,A,exp(Y),delta)
  colnames(dat) <- c(paste("X",1:10,sep=""),"a","y","del")
  
  censored(x = X, 
           y = Y, 
           a = A, 
           delta = delta,
           propen = 0.5, 
           phi = "c", 
           logY = TRUE, 
           intercept = TRUE)
}
