# `plotGMM` Tools for Visualizing Gaussian Mixture Models
Old version: [![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/plotGMM)](http://cran.r-project.org/package=plotGMM)
Old version: [![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/plotGMM)](http://cranlogs.r-pkg.org/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=plastic)](https://github.com/pdwaggoner/plotGMM/pulls)

In collaboration with Fong Chun Chan [@tinyheero](https://github.com/tinyheero), the latest relaese (v 0.2.0) of `plotGMM` provides two main functions: 

1. `plot_GMM`: The main function of the packcage, `plot_GMM` allows the user to simply input the name of a `mixEM` object (from fitting a Gaussian mixture model (GMM) via the `normalmixEM` function from the `mixtools` package), as well as the number of components, `k`, that were used in the original GMM fit. The result is a clean `ggplot2` object showing the density of the data with overlaid mixture weight component curves.  

2. `plot_mix_comps`: A custom function for users interested in overlaying the components from a Gaussian mixture model. This allows for clean, precise plotting constraints, including mean (`mu`), variance (`sigma`), and mixture weight (`lambda`) of the components. The function superimposes the shape of the components over a `ggplot2` object. Importantly, while the `plot_mix_comps` function is used in the main `plot_GMM` function, users can use the `plot_mix_comps` function in their own custom plots. To do so, see the second example below. 

### For plotting GMMs using `plot_GMM`
```{r }
set.seed(2478)
mixmdl <- mixtools::normalmixEM(faithful$waiting, k = 2)

plot_GMM(mixmdl, 2)
```

### Manually using the `plot_mix_comps` function in a custom `ggplot2` plot
```{r }
library(plotGMM)
library(magrittr)
library(ggplot2)
library(mixtools)

# Fit a GMM using EM
set.seed(576)
mixmdl <- normalmixEM(faithful$waiting, k = 2)

# Plot mixture components using the `plot_mix_comps` function
data.frame(x = mixmdl$x) %>%
ggplot() +
geom_histogram(aes(x, ..density..), binwidth = 1, colour = "black",
                 fill = "white") +
   stat_function(geom = "line", fun = plot_mix_comps,
                 args = list(mixmdl$mu[1], mixmdl$sigma[1], lam = mixmdl$lambda[1]),
                 colour = "red", lwd = 1.5) +
   stat_function(geom = "line", fun = plot_mix_comps,
                 args = list(mixmdl$mu[2], mixmdl$sigma[2], lam = mixmdl$lambda[2]),
                 colour = "blue", lwd = 1.5) +
   ylab("Density")
```
