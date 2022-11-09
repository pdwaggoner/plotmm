#' Helper Function for Overlaying Mixture Components
#'
#' Allows for plotting mixture components conditioned on a superimposed function meant for passage to ggplot's \code{stat_function()}
#' @usage plot_mix_comps(x, mu = NULL, sigma = NULL, lam = 1, beta0 = NULL,
#'  beta1=NULL, alpha=NULL, beta=NULL,
#'  normal=FALSE, logisreg=FALSE,
#'  gamma=FALSE, poisson=FALSE)
#' @param x Input data
#' @param mu Component mean
#' @param sigma Component variance
#' @param lam Component mixture weight
#' @param alpha Initial shape parameters
#' @param beta Initial parameter values
#' @param beta0 Coefficient values
#' @param beta1 Coefficient values
#' @param normal Logical for normal distribution
#' @param logisreg Logical for logistic regression mixtures
#' @param gamma Logical for gamma distribution
#' @param poisson Logical for poisson regression mixtures
#'
#' @details Allows for component curves to be superimposed over a mixture model plot
#'
#' @examples
#' \donttest{
#' if(require(mixtools)){
#' mixmdl <- mixtools::normalmixEM(faithful$waiting, k = 2)
#' }
#' x <- mixmdl$x
#' x <- data.frame(x)
#' ggplot2::ggplot(data.frame(x)) +
#'   ggplot2::geom_density(ggplot2::aes(x), color="black", fill="black") +
#'   ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
#'                 args = list(mixmdl$mu[1], mixmdl$sigma[1], lam = mixmdl$lambda[1]),
#'                 colour = "red") +
#'   ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
#'                 args = list(mixmdl$mu[2], mixmdl$sigma[2], lam = mixmdl$lambda[2]),
#'                colour = "blue")
#'}
#'
#' @export
plot_mix_comps <- function(x, mu = NULL, sigma = NULL, lam = 1, beta0 = NULL,
                           beta1 = NULL, alpha = NULL, beta = NULL,
                           normal = FALSE, logisreg = FALSE,
                           gamma = FALSE, poisson = FALSE) {
  if (normal==TRUE) {
    if(is.null(mu) | is.null(sigma) | is.null(lam)){
      stop("Check input for normal distribution.")
    }
    lam*stats::dnorm(x, mean = mu, sd = sigma)
  } else if (logisreg==TRUE) {
    if(is.null(beta0) | is.null(beta1)){
      stop("Check input for binary logistic regrssions.")
    }
    stats::plogis(beta0 + beta1*x)
  } else if (gamma==TRUE) {
    if(is.null(alpha) | is.null(beta) | is.null(lam)){
      stop("Check input for gamma distribution.")
    }
    lam*stats::dgamma(x, shape = alpha, scale = beta)
  } else if (poisson==TRUE) {
    if(is.null(beta0) | is.null(beta1)){
      stop("Check input for poisson distribution.")
    }
    lam*stats::rpois(x, exp(beta0 + beta1))
  }
}
