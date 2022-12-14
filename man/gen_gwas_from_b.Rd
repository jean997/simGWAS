% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gen_gwas_from_b.R
\name{gen_gwas_from_b}
\alias{gen_gwas_from_b}
\title{Generate GWAS data from standardized or non-standardized direct SNP effects and LD}
\usage{
gen_gwas_from_b(
  b_joint_std,
  b_joint,
  N,
  V_E,
  R_E = NULL,
  R_LD = NULL,
  af = NULL,
  sim_func = gen_genos_mvn,
  calc_sumstats = TRUE
)
}
\arguments{
\item{b_joint_std}{Matrix of standardized joint (causal) effects (dimension variants by traits)}

\item{b_joint}{Matrix of non-standardized joint (causal) effects (dimension variants by traits). Supply only one of \code{b_joint} or
\code{b_joint_std}.}

\item{N}{Sample size, scalar, vector, or special sample size format data frame, see details.}

\item{V_E}{Vector with length equal to the number of traits giving the environmental variance of each trait.}

\item{R_E}{Environmental correlation matrix, (traits by traits). If missing, R_E is assumed to be the identity.}

\item{R_LD}{LD pattern (optional). See \code{?sim_mv} for more details.}

\item{af}{Allele frequencies. This can be a scalar, vector or a function. For this function, af must be
supplied if R_LD is not supplied. If a vector, af should have length equal to the number of variants.}

\item{snp_info}{(optional, required if \code{R_LD} is supplied).}
}
\description{
Generate GWAS data from standardized or non-standardized direct SNP effects and LD
}
\details{
This function can be used to generate individual level GWAS data by passing in the \code{beta_joint} table
from a data set simulated using `sim_mv`. If the
original data are generated with af missing and no LD then the \code{beta_joint} table contains standardized effects. Otherwise
it contains non-standardized effects. Use the appropriate argument, either \code{b_joint_std} or \code{b_joint}.
}
\examples{
# Use gen_gwas_from_b to generate individual level data with given effect size.
Ndf <- data.frame(trait_1 = 1, trait_2 = 1, N = 10000)
G <- matrix(0, nrow = 2, ncol = 2)
R_E <- matrix(c(1, 0.8, 0.8, 1), nrow = 2, ncol = 2)
# original data
dat <- sim_mv(N = Ndf, J = 2000, h2 = c(0.4, 0.3), pi = 100/2000,
               G = G, R_E = R_E, af = function(n){rbeta(n, 1, 5)})
# Now generate GWAS data
gw_dat <- gen_gwas_from_b(b_joint = dat$beta_joint, N = Ndf, V_E = c(0.6, 0.7),
                           R_E = R_E, af = dat$snp_info$AF, calc_sumstats = TRUE)
}
