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
#' ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "black", fill = "white") +
#' ggplot2::stat_function(geom = "line", fun = plotmm::plot_mix_comps_normal,
#'                        args = list(mu = mixmdl$mu[1], sigma = mixmdl$sigma[1], lam = mixmdl$lambda[1]),
#'                        colour = "red", lwd = 1) +
#' ggplot2::stat_function(geom = "line", fun = plotmm::plot_mix_comps_normal,
#'                        args = list(mu = mixmdl$mu[2], sigma = mixmdl$sigma[2], lam = mixmdl$lambda[2]),
#'                        colour = "blue", lwd = 1) +
#' ggplot2::ylab("Density") + 
#' ggplot2::theme_minimal()
#'
#' @export
plot_mix_comps_normal <- function(x, mu, sigma, lam) {
  lam * stats::dnorm(x, mu, sigma)
}
