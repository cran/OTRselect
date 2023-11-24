\name{uncensored}
\alias{uncensored}
\title{
Variable Selection for Optimal Treatment Decision with Uncensored Continuous Response
}
\description{
A penalized regression framework that can simultaneously estimate the optimal treatment strategy and identify important variables when the response is continuous and not censored. This method uses an inverse probability weighted least squares estimation with adaptive LASSO penalty for variable selection.}
\usage{
uncensored(x, y, a, propen, phi, intercept = TRUE)
}
\arguments{
  \item{x}{Matrix or data.frame of model covariates.}
  \item{y}{Vector of response. Note that this data is used to estimate the Kaplan-Meier Curve and should not be log(T).}
  \item{a}{Vector of treatment received. Treatments must be coded as integers or numerics that can be recast as integers without loss of information.}
  \item{propen}{Vector or matrix of propensity scores for each treatment. If a vector, the propensity is assumed to be the same for all samples. Column or element order must correspond to the sort order of the treatment variable, i.e., 0,1,2,3,... If the number of columns/elements in propen is one fewer than the total number of treatment options, it is assumed that the base or lowest valued treatment has not been provided. }
  \item{phi}{A character \{'c' or 'l'\} indicating if the constant ('c') or linear ('l') baseline mean function is to be used.}
  \item{intercept}{TRUE/FALSE indicating if an intercept is to be included in phi model. }
}
\value{
A list object containing
\item{beta}{A vector of the estimated regression coefficients after variable selection.}
\item{optTx}{The estimated optimal treatment for each sample.}
}
\references{
Lu, W., Zhang, H. H., and Zeng. D. 
(2013). 
Variable selection for optimal treatment decision. 
Statistical Methods in Medical Research, 22, 493--504. 
PMCID: PMC3303960.
}
\author{
Wenbin Lu, Hao Helen Zhang, Donglin Zeng, and Shannon T. Holloway}

\examples{
  sigma <- diag(10)
  ct <- 0.5^{1L:9L}
  rst <- unlist(sapply(1L:9L,function(x){ct[1L:{10L-x}]}))
  sigma[lower.tri(sigma)] <- rst
  sigma[upper.tri(sigma)] <- t(sigma)[upper.tri(sigma)]

  M <- t(chol(sigma))
  Z <- matrix(rnorm(1000),10,100)
  X <- t(M \%*\% Z)

  gamma1 <- c(1, -1, rep(0,8))
  beta <- c(1,1,rep(0,7), -0.9, 0.8)

  A <- rbinom(100,1,0.5)

  Y <- 1.0 + X \%*\% gamma1 + 
       A*{cbind(1.0,X)\%*\%beta} + rnorm(100,0,.25)

  dat <- data.frame(X,A,Y)
  
  uncensored(x=X,  
             y = Y,  
             a = A,  
             propen = 0.5,  
             phi = "c",  
             intercept = TRUE)

}

