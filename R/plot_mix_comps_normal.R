#' Custom Function for Overlaying Mixture Components for Normal Distributions
#'
#' Plots a mixture component conditioned on a superimposed function
#' @usage plot_mix_comps_normal(x, mu, sigma, lam)
#' @param x Input data
#' @param mu Mean of component
#' @param sigma Variance of component
#' @param lam Mixture weight of component
#'
#' @details Allows for specifying a custom function to be superimposed when plotting a mixture component assuming a normal distribution. This is the original function for the package, which is also included in the updated \code{plot_mix_comps()} function.
#'
#' @examples
#' if(require(mixtools)){
#' mixmdl <- mixtools::normalmixEM(faithful$waiting, k = 2)
#' }
#' x <- mixmdl$x
#' x <- data.frame(x)
#' ggplot2::ggplot(data.frame(x)) +
#'   ggplot2::geom_density(ggplot2::aes(x), color="black", fill="black") +
#'   ggplot2::stat_function(geom = "line", fun = plot_mix_comps_normal,
#'                 args = list(mixmdl$mu[1], mixmdl$sigma[1], lam = mixmdl$lambda[1]),
#'                 colour = "red") +
#'   ggplot2::stat_function(geom = "line", fun = plot_mix_comps_normal,
#'                 args = list(mixmdl$mu[2], mixmdl$sigma[2], lam = mixmdl$lambda[2]),
#'                colour = "blue")
#'
#' @export
plot_mix_comps_normal <- function(x, mu, sigma, lam) {
  lam * stats::dnorm(x, mu, sigma)
}
