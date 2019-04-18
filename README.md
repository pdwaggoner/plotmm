# `plotGMM` Tools for Visualizing Gaussian Mixture Models
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/plotGMM)](http://cran.r-project.org/package=plotGMM)
[![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/plotGMM)](http://cranlogs.r-pkg.org/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=plastic)](https://github.com/pdwaggoner/plotGMM/pulls)

In collaboration with Fong Chan [@tinyheero](https://github.com/tinyheero), the latest release (v 0.2.0) of `plotGMM` includes substantial updates with easy-to-use tools for visualizing output from Gaussian mixture models: 

1. `plot_GMM`: The main function of the package, `plot_GMM` allows the user to simply input the name of a `mixEM` class object (from fitting a Gaussian mixture model (GMM) using the `mixtools` package), as well as the number of components, `k`, that were used in the GMM fit. The result is a clean `ggplot2` object showing the density of the data with overlaid mixture weight component curves.  

2. `plot_cut_point`: Gaussian mixture models (GMMs) are not only used for uncovering clusters in data, but are also often used to derive cut points, or lines of separation between clusters in feature space (see the Benaglia et al. 2009 reference in the package documentation for more). The `plot_cut_point` function plots data densities with the overlaid cut point (the mean of the calculated `mu`) from `mixEM` class objects, which are GMM's fit using the `mixtools` package.

3. `plot_mix_comps`: This is a custom function for users interested in manually overlaying the components from a Gaussian mixture model. This allows for clean, precise plotting constraints, including mean (`mu`), variance (`sigma`), and mixture weight (`lambda`) of the components. The function superimposes the shape of the components over a `ggplot2` class object. Importantly, while the `plot_mix_comps` function is used in the main `plot_GMM` function in our `plotGMM` package, users can use the `plot_mix_comps` function to build their own custom plots.

### Plotting GMMs using `plot_GMM`
```{r }
# Fit a GMM using EM
set.seed(576)
mixmdl <- mixtools::normalmixEM(iris$Petal.Length, k = 2)

# Plot the density with overlaid mixture weight curves
plot_GMM(mixmdl, 2)
```
![Iris GMM Plot using `plot_GMM`](irisD.png)

### Plotting cut points from GMMs using `plot_cut_point`
```{r }
# Fit a GMM using EM
set.seed(576)
mixmdl <- mixtools::normalmixEM(faithful$waiting, k = 2)

# Option 1: Plot
plot_cut_point(mixmdl, plot = TRUE) # produces plot

# Option 2: No plot
plot_cut_point(mixmdl, plot = FALSE) # produces only numeric summary output from GMM
```
![Cut Point from Old Faithful GMM using `plot_cut_point`](cp.png)

### Use `plot_mix_comps` for a custom plot manually overlaying component curves
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
                 colour = "blue", lwd = 1.5)
```

![Custom Plot using `plot_mix_comps`](faithful.png)
