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
plot_mm <- function(m, k = NULL, data = NULL) {
  # tools
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package \"ggplot2\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("methods", quietly = TRUE)) {
    stop("Package \"methods\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package \"dplyr\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("patchwork", quietly = TRUE)) {
    stop("Package \"patchwork\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  # models
  if (!requireNamespace("mixtools", quietly = TRUE)) {
    stop("Package \"mixtools\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("EMCluster", quietly = TRUE)) {
    stop("Package \"EMCluster\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("flexmix", quietly = TRUE)) {
    stop("Package \"flexmix\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  X1 <- X2 <- NULL # for local calling in multivariate cases
  component_colors <- c(
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
  ## mixtools objects
  if (inherits(m, "mixEM")){
    # if gammamixEM
    if (m$ft=="gammamixEM") {
      if(is.null(k)){
        k <- length(m$gamma.pars)/2
      }
      # range of k, bigger than 16 if needed
      if (k <= 1){
        stop("Specified components must be at least length 2.")
      } else if (k >= 16){
        stop("Are you really searching for 16 or more components? If so, open an issue ticket --> `https://github.com/pdwaggoner/plotmm/issues` \n
           We will consider updating the package. \n
           If not, make sure the mixture model is properly specified.")
      }
      x <- data.frame(m$x)
      colnames(x) <- "density"
      out_plot <- ggplot2::ggplot(x) +
        ggplot2::geom_density(ggplot2::aes(x=density),
                              colour = "darkgray",
                              fill = "lightgray") +
        ggplot2::theme_minimal()
      for (i in 1:k) {
        out_plot <- out_plot +
          ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                 args = list(alpha = m$gamma.pars[1,i],
                                             beta = m$gamma.pars[2,i],
                                             lam = m$lambda[i],
                                             gamma = TRUE),
                                 colour = component_colors[i], lwd = 1) +
          ggplot2::ylab("Density") +
          ggplot2::theme_minimal()
      }
    }

    # if binary logisremixEM
    if (m$ft=="logisregmixEM") {
      if(is.null(k)){
        k <- ncol(m$beta)
      }
      if (k <= 1){
        stop("Specified components must be at least length 2.")
      } else if (k >= 16){
        stop("Are you really searching for 16 or more components? If so, open an issue ticket --> `https://github.com/pdwaggoner/plotmm/issues` \n
           We will consider updating the package. \n
           If not, make sure the mixture model is properly specified.")
      }
      df <- data.frame(matrix(NA,
                              nrow = length(m$y),
                              ncol=2))
      X_1 <- as.numeric(data.frame(m$x)[,2])
      X_2 <- as.numeric(m$y)
      if (length(X_2)!=sum(X_2==0 | X_2==1)){
        stop("The response feature should be binary. Check input or report the issue")
      }
      out_plot <- ggplot2::qplot(x = X_1,
                                 y = X_2) +
        ggplot2::geom_point(colour = "lightgray") +
        ggplot2::theme_minimal()
      for (i in 1:k) {
        out_plot <- out_plot +
          ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                 args = list(beta0 = m$beta[1,i],
                                             beta1 = m$beta[2,i],
                                             logisreg = TRUE),
                                 colour = component_colors[i], lwd = 1) +
          ggplot2::xlab("X") +
          ggplot2::ylab("Y") +
          ggplot2::theme_minimal()
      }
    }

    # if poisregmixEM
    if (m$ft=="poisregmixEM") {
      if(is.null(k)){
        k <- ncol(m$beta)
      }
      if (k <= 1){
        stop("Specified components must be at least length 2.")
      } else if (k >= 16){
        stop("Are you really searching for 16 or more components? If so, open an issue ticket --> `https://github.com/pdwaggoner/plotmm/issues` \n
           We will consider updating the package. \n
           If not, make sure the mixture model is properly specified.")
      }
      df <- data.frame(matrix(NA,
                              nrow = length(m$y),
                              ncol = 2))
      X_1 <- as.numeric(data.frame(m$x)[,2])
      X_2 <- as.numeric(m$y)
      out_plot <- ggplot2::qplot(x = X_1,
                                 y = X_2) +
        ggplot2::geom_point(colour = "lightgray") +
        ggplot2::theme_minimal()
      for (i in 1:k) {
        out_plot <- out_plot +
          ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                 args = list(beta0 = m$beta[1,i],
                                             beta1 = m$beta[2,i],
                                             lam = m$lambda[i],
                                             poisson = TRUE),
                                 colour = component_colors[i], lwd = 1) +
          ggplot2::xlab("X") +
          ggplot2::ylab("Y")  +
          ggplot2::theme_minimal()
      }
    }

    # if regmixEM
    if (m$ft=="regmixEM"){
      if(is.null(k)){
        k <- ncol(m$posterior)
      }
      if (k <= 1){
        stop("Specified components must be at least length 2.")
      } else if (k >= 16){
        stop("Are you really searching for 16 or more components? If so, open an issue ticket --> `https://github.com/pdwaggoner/plotmm/issues` \n
           We will consider updating the package. \n
           If not, make sure the mixture model is properly specified.")
      }
      df <- data.frame(matrix(NA,
                              nrow = length(m$y),
                              ncol = 2))
      X_1 <- as.numeric(data.frame(m$x)[,2])
      X_2 <- as.numeric(m$y)
      coeff <- data.frame(m$beta)
      out_plot <- ggplot2::qplot(x = X_1,
                                 y = X_2) +
        ggplot2::geom_point(colour = "lightgray") +
        ggplot2::xlab("X") +
        ggplot2::ylab("Y")  +
        ggplot2::theme_minimal()
      for (i in 1:k) {
        out_plot <- out_plot +
          ggplot2::geom_abline(intercept = coeff[1,i],
                               slope = coeff[2,i],
                               colour = component_colors[i],
                               lwd = 1) +
          ggplot2::theme_minimal()
      }
    }

    # if univariate normalmixEM or repnormixEM
    if (m$ft=="normalmixEM" | m$ft=="repnormmixEM") {
      if(is.null(k)){
        k <- m$posterior
      }
      # range of k, bigger than 16 if needed
      if (k <= 1){
        stop("Specified components must be at least length 2.")
      } else if (k >= 16){
        stop("Are you really searching for 16 or more components? If so, open an issue ticket --> `https://github.com/pdwaggoner/plotmm/issues` \n
           We will consider updating the package. \n
           If not, make sure the mixture model is properly specified.")
      }
      x <- data.frame(m$x)
      colnames(x) <- "density"
      out_plot <- ggplot2::ggplot(x) +
        ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
        ggplot2::theme_minimal()
      for (i in 1:k) {
        out_plot <- out_plot +
          ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                 args = list(mu = m$mu[i],
                                             sigma = m$sigma[i],
                                             lam = m$lambda[i],
                                             normal = TRUE),
                                 colour = component_colors[i], lwd = 1) +
          ggplot2::ylab("Density")  +
          ggplot2::theme_minimal()
      }
    }

    # if bivariate normalmixEM
    if (m$ft=="mvnormalmixEM" && ncol(m$x)==2){
      if(is.null(k)){
        k <- ncol(m$posterior)
      }
      # range of k, bigger than 16 if needed
      if (k <= 1){
        stop("Specified components must be at least length 2.")
      } else if (k >= 16){
        stop("Are you really searching for 16 or more components? If so, open an issue ticket --> `https://github.com/pdwaggoner/plotmm/issues` \n
           We will consider updating the package. \n
           If not, make sure the mixture model is properly specified.")
      }
      x <- data.frame(m$x)
      mean <- m$mu
      sigma <- m$sigma
      X_1 <- x[ ,1]
      X_2 <- x[ ,2]
      post <- m$posterior
      out_plot <- ggplot2::qplot(x = X_1,
                                 y = X_2) +
        ggplot2::geom_point(colour = "darkgray", fill = "lightgray", size=0.7) +
        ggplot2::theme_minimal()
      for (i in 1:k){
        p <- data.frame(t(data.frame(mean[[i]])))
        e <- data.frame(mixtools::ellipse(mean[[i]], sigma, newplot = TRUE, npoints = 500))
        out_plot  <- out_plot +
          ggplot2::geom_point(data = p, ggplot2::aes(x = X1, y = X2), colour = "black", size = 0.7) +
          ggplot2::geom_point(data = e, ggplot2::aes(x = X1, y = X2), colour = component_colors[i], size = 0.3) +
          ggplot2::theme_minimal()
      }
      x1 <- data.frame(m$x[,1])
      colnames(x1) <- "density"
      x2 <- data.frame(m$x[,2])
      colnames(x2) <- "density"
      hist1 <- ggplot2::ggplot(x1) +
        ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
        ggplot2::ggtitle("X1") +
        ggplot2::theme_minimal()
      hist2 <- ggplot2::ggplot(x2) +
        ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
        ggplot2::ggtitle("X2") +
        ggplot2::theme_minimal()
      out_plot <- out_plot / (hist1 + hist2)
    }

    # if multivariate normalmixEM
    if (m$ft=="mvnormalmixEM"&&ncol(m$x)>2){
      stop("Not compatible with multivariate `normalmixEM` objects where ncol(m$x) >= 3 yet. \n
           Development is in process.")
    }
  }

  ## EMCluster objects
  else if (inherits(m, "emret")){
    if (is.null(data)){
      stop("The original data is required as an input for `emret` objects.")
    }
    if (is.null(k)){
      k <- m$nclass
    }

    # if bivariate case
    if (ncol(data)==2){
      x <- data.frame(data)
      X_1 <- x[ ,1]
      X_2 <- x[ ,2]
      out_plot <- ggplot2::qplot(x=X_1, y=X_2) +
        ggplot2::geom_point(colour = "lightgray") +
        ggplot2::xlab("X1") +
        ggplot2::ylab("X2")  +
        ggplot2::theme_minimal()
    }
    for (i in 1:k){
      p <- data.frame(m$Mu)[i,]
      sigma <- data.frame(EMCluster::LTSigma2variance(m$LTSigma)[,,i])
      e <- data.frame(mixtools::ellipse(m$Mu[i,], sigma, newplot = TRUE, npoints = 500))
      out_plot  <- out_plot +
        ggplot2::geom_point(data = p, ggplot2::aes(x = X1, y = X2), colour = "black", size = 0.7) +
        ggplot2::geom_point(data = e, ggplot2::aes(x = X1, y = X2), colour = component_colors[i], size = 0.3) +
        ggplot2::theme_minimal()
    }
    x1 <- data.frame(x[,1])
    colnames(x1) <- "density"
    x2 <- data.frame(x[,2])
    colnames(x2) <- "density"
    hist1 <- ggplot2::ggplot(x1) +
      ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
      ggplot2::ggtitle("X1") +
      ggplot2::theme_minimal()
    hist2 <- ggplot2::ggplot(x2) +
      ggplot2::ggtitle("X2") +
      ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
      ggplot2::theme_minimal()
    out_plot <- out_plot / (hist1 + hist2)

    # if multivariate case
    if (ncol(data)!=2){
      stop("Not compatible with multivariate `emret` objects where ncol(data) >= 3 yet. \n
           Development is in process.")
    }

  }

  ## flexmix objects
  else if (inherits(m, "flexmix")){
    if (is.null(k)){
      k <- m@k0
    }
    if (k <= 1){
      stop("Specified components must be at least length 2.")
    } else if (k >= 16){
      stop("Are you really searching for 16 or more components? If so, open an issue ticket --> `https://github.com/pdwaggoner/plotmm/issues` \n
           We will consider updating the package. \n
           If not, make sure the mixture model is properly specified.")
    }

    num_model <- length(m@model)
    if (num_model==1){
      family <- m@model[[1]]@family
      if (family=="poisson" & ncol(m@model[[1]]@x)==2) {

      } else if (family=="gaussian" & ncol(m@model[[1]]@x)==1) {
        x <- data.frame(m@model[[1]]@y)
        colnames(x) <- "density"
        out_plot <- ggplot2::ggplot(x) +
          ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
          ggplot2::theme_minimal()
        sigma <- flexmix::parameters(m)[2,]
        lam <- table(flexmix::clusters(m))
        mu <- flexmix::parameters(m)[1,]
        for (i in 1:k) {
          out_plot <- out_plot +
            ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                   args = list(mu = mu[i],
                                               sigma = sigma[i],
                                               lam = lam[i]/sum(lam),
                                               normal = TRUE),
                                   colour = component_colors[i],
                                   lwd = 1) +
            ggplot2::ylab("Density") +
            ggplot2::xlab("x")  +
            ggplot2::theme_minimal()
        }
      } else if (family=="Gamma" & ncol(m@model[[1]]@x)==1) {
        x <- data.frame(m@model[[1]]@y)
        colnames(x) <- "density"
        out_plot <- ggplot2::ggplot(x) +
          ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
          ggplot2::theme_minimal()
        shape <- flexmix::parameters(m)[2,]
        lam <- table(flexmix::clusters(m))
        coef <- flexmix::parameters(m)[1,]
        for (i in 1:k) {
          out_plot <- out_plot +
            ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                   args = list(alpha = shape[i],
                                               beta = 1/(coef[i]*shape[i]),
                                               lam = lam[i]/sum(lam),
                                               gamma = TRUE),
                                   colour = component_colors[i],
                                   lwd = 1) +
            ggplot2::ylab("Density")  +
            ggplot2::theme_minimal()
        }
      } else if (family=="binomial"& ncol(m@model[[1]]@x)==2) {

      }
    } else if (num_model>1){
      for (j in i:num_model){
        family <- m@model[[j]]@family
        if (family=="poisson" & ncol(m@model[[1]]@x)==2) {

        } else if (family=="gaussian" & ncol(m@model[[j]]@x)==1) {
          x <- data.frame(m@model[[j]]@y)
          colnames(x) <- "density"
          out_plot <- ggplot2::ggplot(x) +
            ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
            ggplot2::theme_minimal()
            sigma <- flexmix::parameters(m)[[j]][2,]
            lam <- table(flexmix::clusters(m))
            mu <- flexmix::parameters(m)[[j]][1,]
          for (i in 1:k) {
            out_plot <- out_plot +
              ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                     args = list(mu = mu[i],
                                                 sigma = sigma[i],
                                                 lam = lam[i]/sum(lam),
                                                 normal = TRUE),
                                     colour = component_colors[i],
                                     lwd = 1) +
              ggplot2::ylab("Density") +
              ggplot2::xlab("x")  +
              ggplot2::theme_minimal()
          }
        } else if (family=="Gamma" & ncol(m@model[[j]]@x)==1) {
          x <- data.frame(m@model[[j]]@y)
          colnames(x) <- "density"
          out_plot <- ggplot2::ggplot(x) +
            ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
            ggplot2::theme_minimal()
          shape <- flexmix::parameters(m)[[j]][2,]
          lam <- table(flexmix::clusters(m))
          scale <- flexmix::parameters(m)[[j]][1,]
          for (i in 1:k) {
            out_plot <- out_plot +
              ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                     args = list(alpha = shape[i],
                                                 beta = 1/(coef[i]*shape[i]),
                                                 lam = lam[i]/sum(lam),
                                                 gamma = TRUE),
                                     colour = component_colors[i],
                                     lwd = 1) +
              ggplot2::ylab("Density")  +
              ggplot2::theme_minimal()
          }
        } else if (family=="binomial") {

        }
      }
    }
  }
  else {
    stop("Please check the input type. Currently objects from 'mixtools', 'EMCluster', and 'flexmix' are supported. \n
         If you want to generate plots for mixture model objects from other packages, please open an issue ticket: \n
         `https://github.com/pdwaggoner/plotmm/issues`.")
  }

  out_plot

}
