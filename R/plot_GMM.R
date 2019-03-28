#'Plots Components from Gaussian Mixture Models
#'
#'Generates a plot of densities with overlaid components from a Gaussian mixture model (GMM)
#'@usage plot_GMM(m, k=NULL)
#'@param m a \code{mixEM} class object corresponding with the fit GMM
#'@param k the number of components specified in the GMM, \code{m}
#'@details Uses ggplot2 graphics to plot data densities with overlaid components from \code{mixEM} objects, which are GMM's fit using the \code{mixtools} package.
#'
#'Note: Users must enter the same component value, \code{k}, in the \code{plot_GMM} function, as that which was specified in the original GMM specification.
#'@examples
#'set.seed(235)
#'mixmdl <- mixtools::normalmixEM(faithful$waiting, k = 2)
#'
#'plot_GMM(mixmdl, 2)
#'@method mixtools mixEM
#'@export

plot_GMM <- function(m, k=NULL) {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package \"ggplot2\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("mixtools", quietly = TRUE)) {
    stop("Package \"mixtools\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("methods", quietly = TRUE)) {
    stop("Package \"methods\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  m <- try(methods::as(m, "mixEM", strict=TRUE))
  x <- m$x
  x <- data.frame(x)
  if (k <= 1){
    stop("Specified components must be at least length 2.")
  }
  if (k == 2){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 3){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 4){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 5){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 6){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[6], m$sigma[6], lam = m$lambda[6]),
                             colour = "purple", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 7){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[6], m$sigma[6], lam = m$lambda[6]),
                             colour = "purple", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[7], m$sigma[7], lam = m$lambda[7]),
                             colour = "darksalmon", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 8){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[6], m$sigma[6], lam = m$lambda[6]),
                             colour = "purple", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[7], m$sigma[7], lam = m$lambda[7]),
                             colour = "darksalmon", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[8], m$sigma[8], lam = m$lambda[8]),
                             colour = "goldenrod2", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 9){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[6], m$sigma[6], lam = m$lambda[6]),
                             colour = "purple", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[7], m$sigma[7], lam = m$lambda[7]),
                             colour = "darksalmon", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[8], m$sigma[8], lam = m$lambda[8]),
                             colour = "goldenrod2", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[9], m$sigma[9], lam = m$lambda[9]),
                             colour = "dodgerblue", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 10){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[6], m$sigma[6], lam = m$lambda[6]),
                             colour = "purple", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[7], m$sigma[7], lam = m$lambda[7]),
                             colour = "darksalmon", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[8], m$sigma[8], lam = m$lambda[8]),
                             colour = "goldenrod2", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[9], m$sigma[9], lam = m$lambda[9]),
                             colour = "dodgerblue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[10], m$sigma[10], lam = m$lambda[10]),
                             colour = "darkorange3", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 11){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[6], m$sigma[6], lam = m$lambda[6]),
                             colour = "purple", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[7], m$sigma[7], lam = m$lambda[7]),
                             colour = "darksalmon", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[8], m$sigma[8], lam = m$lambda[8]),
                             colour = "goldenrod2", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[9], m$sigma[9], lam = m$lambda[9]),
                             colour = "dodgerblue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[10], m$sigma[10], lam = m$lambda[10]),
                             colour = "darkorange3", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[11], m$sigma[11], lam = m$lambda[11]),
                             colour = "burlywood4", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 12){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[6], m$sigma[6], lam = m$lambda[6]),
                             colour = "purple", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[7], m$sigma[7], lam = m$lambda[7]),
                             colour = "darksalmon", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[8], m$sigma[8], lam = m$lambda[8]),
                             colour = "goldenrod2", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[9], m$sigma[9], lam = m$lambda[9]),
                             colour = "dodgerblue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[10], m$sigma[10], lam = m$lambda[10]),
                             colour = "darkorange3", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[11], m$sigma[11], lam = m$lambda[11]),
                             colour = "burlywood4", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[12], m$sigma[12], lam = m$lambda[12]),
                             colour = "darkmagenta", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 13){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[6], m$sigma[6], lam = m$lambda[6]),
                             colour = "purple", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[7], m$sigma[7], lam = m$lambda[7]),
                             colour = "darksalmon", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[8], m$sigma[8], lam = m$lambda[8]),
                             colour = "goldenrod2", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[9], m$sigma[9], lam = m$lambda[9]),
                             colour = "dodgerblue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[10], m$sigma[10], lam = m$lambda[10]),
                             colour = "darkorange3", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[11], m$sigma[11], lam = m$lambda[11]),
                             colour = "burlywood4", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[12], m$sigma[12], lam = m$lambda[12]),
                             colour = "darkmagenta", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[13], m$sigma[13], lam = m$lambda[13]),
                             colour = "firebrick", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 14){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[6], m$sigma[6], lam = m$lambda[6]),
                             colour = "purple", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[7], m$sigma[7], lam = m$lambda[7]),
                             colour = "darksalmon", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[8], m$sigma[8], lam = m$lambda[8]),
                             colour = "goldenrod2", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[9], m$sigma[9], lam = m$lambda[9]),
                             colour = "dodgerblue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[10], m$sigma[10], lam = m$lambda[10]),
                             colour = "darkorange3", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[11], m$sigma[11], lam = m$lambda[11]),
                             colour = "burlywood4", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[12], m$sigma[12], lam = m$lambda[12]),
                             colour = "darkmagenta", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[13], m$sigma[13], lam = m$lambda[13]),
                             colour = "firebrick", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[14], m$sigma[14], lam = m$lambda[14]),
                             colour = "deeppink2", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k == 15){
    ggplot2::ggplot(data.frame(x)) +
      ggplot2::geom_histogram(ggplot2::aes(x, ..density..), binwidth = 1, colour = "darkgray", fill = "lightgray") +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[1], m$sigma[1], lam = m$lambda[1]),
                             colour = "red", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[2], m$sigma[2], lam = m$lambda[2]),
                             colour = "blue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[3], m$sigma[3], lam = m$lambda[3]),
                             colour = "green", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[4], m$sigma[4], lam = m$lambda[4]),
                             colour = "yellow", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[5], m$sigma[5], lam = m$lambda[5]),
                             colour = "orange", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[6], m$sigma[6], lam = m$lambda[6]),
                             colour = "purple", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[7], m$sigma[7], lam = m$lambda[7]),
                             colour = "darksalmon", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[8], m$sigma[8], lam = m$lambda[8]),
                             colour = "goldenrod2", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[9], m$sigma[9], lam = m$lambda[9]),
                             colour = "dodgerblue", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[10], m$sigma[10], lam = m$lambda[10]),
                             colour = "darkorange3", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[11], m$sigma[11], lam = m$lambda[11]),
                             colour = "burlywood4", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[12], m$sigma[12], lam = m$lambda[12]),
                             colour = "darkmagenta", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[13], m$sigma[13], lam = m$lambda[13]),
                             colour = "firebrick", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[14], m$sigma[14], lam = m$lambda[14]),
                             colour = "deeppink2", lwd = 1) +
      ggplot2::stat_function(geom = "line", fun = plotGMM::plot_mix_comps,
                             args = list(m$mu[15], m$sigma[15], lam = m$lambda[15]),
                             colour = "darkseagreen1", lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }
  else if (k >= 16){
    stop("Are you really searching for 16 or more clusters? If so, open an issue ticket: `https://github.com/pdwaggoner/plotGMM/issues`\nand we will consider updating the package. If not, go back and make sure the GMM is properly specified.")
  }
}
