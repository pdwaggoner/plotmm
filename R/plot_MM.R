plot_MM <- function(m, k = NULL) {
  # install package if needed
  pkgTest <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg)) 
      install.packages(new.pkg, dependencies = TRUE, quiet = TRUE, verbose = FALSE)
    sapply(pkg, require, character.only = TRUE)
  }
  lapply(c("dplyr","ggplot2","mixtools","methods","EMCluster","flexmix", "ggpubr", "patchwork"), pkgTest)
  # determine colors needed (since k<16, only defined 15 colors)
  component_colors <- c("red","blue","green","yellow","orange","purple","darksalmon","goldenrod2","dodgerblue", "darkorange3","burlywood4", "darkmagenta", "firebrick","deeppink2","darkseagreen1")
  
  #### if the object is from mixtools ####
  # i dont quite understand why this conversion here
  # m <- try(methods::as(m, "mixEM", strict=TRUE))
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
        stop("Are you really searching for 16 or more components? If so, open an issue ticket: `https://github.com/pdwaggoner/plotGMM/issues`\nand we will consider updating the package. If not, go back and make sure the mixture model is properly specified.")
      }
      x <- data.frame(m$x)
      colnames(x) <- "density"
      out_plot <- ggplot2::ggplot(x) +
        ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray")
      for (i in seq(1, k)) {
        out_plot <- out_plot + 
          ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                 args = list(alpha=m$gamma.pars[1,i],beta=m$gamma.pars[2,i],lam=m$lambda[i],gamma=T),
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
      # range of k, bigger than 16 if needed
      if (k <= 1){
        stop("Specified components must be at least length 2.")
      } else if (k >= 16){
        stop("Are you really searching for 16 or more components? If so, open an issue ticket: `https://github.com/pdwaggoner/plotGMM/issues`\nand we will consider updating the package. If not, go back and make sure the mixture model is properly specified.")
      }
      df <- data.frame(matrix(NA, nrow = length(m$y), ncol=2))
      df$X1 <- as.numeric(data.frame(m$x)[,2])
      df$X2 <- as.numeric(m$y)
      if (length(df$X2)!=sum(df$X2==0|df$X2==1)){
        stop("The response variable should be binary. Check input or report the problem.")
      }
      out_plot <- ggplot2::ggplot(df, aes(x=X1,y=X2)) +
        ggplot2::geom_point(colour = "lightgray")
      for (i in seq(1, k)) {
        out_plot <- out_plot + 
          ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                 args = list(beta0=m$beta[1,i],beta1=m$beta[2,i],logisreg=T),
                                 colour = component_colors[i], lwd = 1) +
          ggplot2::xlab("Predictor") + ggplot2::ylab("Response") +
          ggplot2::theme_minimal()
      }
    }
    
    # if poisregmixEM
    if (m$ft=="poisregmixEM") {
      if(is.null(k)){
        k <- ncol(m$beta)
      }
      # range of k, bigger than 16 if needed
      if (k <= 1){
        stop("Specified components must be at least length 2.")
      } else if (k >= 16){
        stop("Are you really searching for 16 or more components? If so, open an issue ticket: `https://github.com/pdwaggoner/plotGMM/issues`\nand we will consider updating the package. If not, go back and make sure the mixture model is properly specified.")
      }
      df <- data.frame(matrix(NA, nrow = length(m$y), ncol=2))
      df$X1 <- as.numeric(data.frame(m$x)[,2])
      df$X2 <- as.numeric(m$y)
      out_plot <- ggplot2::ggplot(df, aes(x=X1,y=X2)) +
        ggplot2::geom_point(colour = "lightgray")
      for (i in seq(1, k)) {
        out_plot <- out_plot + 
          ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                 args = list(beta0=m$beta[1,i],beta1=m$beta[2,i],lam=m$lambda[i],poisson=T),
                                 colour = component_colors[i], lwd = 1) +
          ggplot2::xlab("Predictor") + ggplot2::ylab("Response") +
          ggplot2::theme_minimal()
      }
    }
    
    # if regmixEM
    if (m$ft=="regmixEM"){
      k <- ncol(m$posterior)
      df <- data.frame(matrix(NA, nrow = length(m$y), ncol=2))
      df$X1 <- as.numeric(data.frame(m$x)[,2])
      df$X2 <- as.numeric(m$y)
      coeff <- data.frame(m$beta)
      out_plot <- ggplot2::ggplot(df, aes(x=X1,y=X2)) +
        ggplot2::geom_point(colour = "lightgray") +
        ggplot2::xlab("Predictor") + 
        ggplot2::ylab("Response") +
        ggplot2::theme_bw()
      for (i in seq(1, k)) {
        out_plot <- out_plot + 
          ggplot2::geom_abline(intercept=coeff[1,i],slope=coeff[2,i],colour=component_colors[i], lwd = 1) +
          ggplot2::theme_minimal()
      }
    }
    
    # if uni-variate normalmixEM or repnormixEM
    if (m$ft=="normalmixEM"|m$ft=="repnormmixEM") {
      if(is.null(k)){
        k <- m$posterior
      }
      # range of k, bigger than 16 if needed
      if (k <= 1){
        stop("Specified components must be at least length 2.")
      } else if (k >= 16){
        stop("Are you really searching for 16 or more components? If so, open an issue ticket: `https://github.com/pdwaggoner/plotGMM/issues`\nand we will consider updating the package. If not, go back and make sure the mixture model is properly specified.")
      }
      x <- data.frame(m$x)
      colnames(x) <- "density"
      out_plot <- ggplot2::ggplot(x) +
        ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray")
      for (i in seq(1, k)) {
        out_plot <- out_plot + 
          ggplot2::stat_function(geom = "line", fun = plot_mix_comps,
                                 args = list(mu=m$mu[i],sigma=m$sigma[i],lam=m$lambda[i],normal=T),
                                 colour = component_colors[i], lwd = 1) +
          ggplot2::ylab("Density") +
          ggplot2::theme_minimal()
      }
    }
    
       # if multivariate normalmixEM
    if (m$ft=="mvnormalmixEM"|length(m$mu)==2){
      if(is.null(k)){
        k <- ncol(m$posterior)
      }
      # range of k, bigger than 16 if needed
      if (k <= 1){
        stop("Specified components must be at least length 2.")
      } else if (k >= 16){
        stop("Are you really searching for 16 or more components? If so, open an issue ticket: `https://github.com/pdwaggoner/plotGMM/issues`\nand we will consider updating the package. If not, go back and make sure the mixture model is properly specified.")
      }
      x <- data.frame(m$x)
      mean <- m$mu
      sigma <- m$sigma
      colnames(x) <- c("X.1","X.2")
      post = m$posterior
      out_plot <- ggplot2::ggplot(x) +
        ggplot2::geom_point(ggplot2::aes(x=X.1, y=X.2), colour = "darkgray", fill = "lightgray", size=0.7)
      for (i in seq(1, k)){
        p <- data.frame(t(data.frame(mean[[i]])))
        colnames(p) <- c("X.1","X.2")
        e <- data.frame(mixtools::ellipse(mean[[i]], sigma,newplot=T, npoints=500))
        colnames(e) <- c("X.1","X.2")
        out_plot  <- out_plot +
          ggplot2::geom_point(data=p, aes(x=X.1, y=X.2), colour="black", size=0.7) +
          ggplot2::geom_point(data=e, aes(x=X.1, y=X.2), colour=component_colors[i], size=0.3) +
          ggplot2::labs(title = "Main") +
          ggplot2::theme_minimal()
      }
      x1 <- data.frame(m$x[,1])
      colnames(x1) <- "density"
      x2 <- data.frame(m$x[,2])
      colnames(x2) <- "density"
      hist1 <- ggplot2::ggplot(x1) +
        ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
        ggplot2::labs(title = "X1") +
        ggplot2::theme_minimal()
      hist2 <- ggplot2::ggplot(x2) +
        ggplot2::geom_density(ggplot2::aes(x=density), colour = "darkgray", fill = "lightgray") +
        ggplot2::labs(title = "X2") +
        ggplot2::theme_minimal()
      out_plot <- (out_plot + hist1 + hist2) + patchwork::plot_layout(ncol = 2) + ggplot2::theme_minimal()
    }
  } 
  
  #### if the object is from EMCluster ####
  else if (inherits(m, "")){
    
  }
  #### output ####
  out_plot
}
