#' Plots Mixture Components from Gaussian Mixture Models
#'
#' Generates a plot of data densities with overlaid mixture components from a Gaussian mixture model (GMM)
#' @usage plot_gmm(m, k = NULL)
#' @param m An object of class \code{mixEM} corresponding with the fit GMM
#' @param k The number of components specified in the GMM, \code{m}
#' @details Original function from the \code{plotGMM} package. Retained here for bridging between the packages. We recommend using instead the updated \code{plot_mm} function.
#'
#' Note: \code{plot_gmm} requires a \code{mixtools} object to be supplied. Users must enter the same component value, \code{k}, in the \code{plot_gmm} function, as that which was specified in the original GMM specification (also \code{k} in \code{mixtools}).
#'
#' @examples
#' \donttest{
#' if(require(mixtools)){
#' mixmdl <- mixtools::normalmixEM(faithful$waiting, k = 2)
#' }
#' plot_gmm(mixmdl, 2)
#' }
#'
#' @references Benaglia, T., Chauveau, D., Hunter, D. and Young, D., 2009. mixtools: An R package for analyzing finite mixture models. Journal of Statistical Software, 32(6), pp.1-29.
#' @references Wickham, H., 2016. ggplot2: elegant graphics for data analysis. Springer.
#'
#' @export
plot_gmm <- function(m, k=NULL) {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package \"ggplot2\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("methods", quietly = TRUE)) {
    stop("Package \"methods\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  m <- try(methods::as(m, "mixEM", strict=TRUE))
  if (!inherits(m, "mixEM")){
    stop("must be a mixEM object", call. = FALSE)
  }
  x <- m$x
  x <- data.frame(x)
  if (k <= 1){
    stop("Specified components must be at least length 2.")
  } else if (k >= 16){
    stop("Are you really searching for 16 or more clusters? If so, open an issue ticket: `https://github.com/pdwaggoner/plotGMM/issues`\nand we will consider updating the package. If not, go back and make sure the GMM is properly specified.")
  }

  component_colors <-
    c(
      "red",
      "blue",
      "green",
      "yellow",
      "orange",
      "purple",
      "darksalmon",
      "goldenrod2",
      "dodgerblue",
      "darkorange3",
      "burlywood4",
      "darkmagenta",
      "firebrick",
      "deeppink2",
      "darkseagreen1"
    )

  out_plot <-
    ggplot2::ggplot(data.frame(x)) +
    ggplot2::geom_density(
      ggplot2::aes(x),
      colour = "darkgray", fill = "lightgray"
    )

  for (i in seq(1, k)) {
    out_plot <-
      out_plot +
      ggplot2::stat_function(geom = "line", fun = plot_mix_comps_normal,
                           args = list(m$mu[i], m$sigma[i], lam = m$lambda[i]),
                           colour = component_colors[i], lwd = 1) +
      ggplot2::ylab("Density") +
      ggplot2::theme_bw()
  }

  out_plot

}
