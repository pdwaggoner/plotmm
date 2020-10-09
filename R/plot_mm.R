#' Tidy Visualization of Mixture Models
#'
#' Generates a ggplot of data densities with overlaid mixture components from fit mixture models.
#' @usage plot_mm(m, k = NULL, data = NULL)
#' @param m A mixture model object
#' @param k Optional. The number of components specified in the mixture model, \code{m}
#' @param data Name of data object required only for \code{EMCluster} objects
#'
#' @details This is the core function in the package, returning a \code{ggplot} object for a fit mixture model. The plot includes the data density with overlaid mixture components.
#'
#' @examples
#' \donttest{
#' if(require(mixtools)){
#' mixmdl1 <- mixtools::normalmixEM(faithful$waiting, k = 2)
#' }
#' plot_mm(mixmdl1, 2)
#'
#' if(require(mixtools)){
#' x <- c(rgamma(200, shape = 50, scale = 11), rgamma(200, shape = 28, scale = 6))
#' mixmdl2 <- mixtools::gammamixEM(x, lambda = c(1, 1)/2)
#' }
#' plot_mm(mixmdl2)
#'}
#'
#' @references Wickham, H., 2016. ggplot2: elegant graphics for data analysis. Springer.
#'
#' @export
[LU TO INSERT CODE HERE]
