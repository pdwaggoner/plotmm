# `plotmm` Tidy Tools for Visualizing Mixture Models
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/plotGMM)](http://cran.r-project.org/package=plotGMM)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/plotGMM)](http://www.r-pkg.org/pkg/plotGMM)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=plastic)](https://github.com/pdwaggoner/plotGMM/pulls)

---

Package Authors:
  - [Philip D. Waggoner](https://github.com/pdwaggoner), University of Chicago
  - [Fong Chun Chan](https://github.com/tinyheero), Achilles Therapeutics
  - Lu Zhang, Emory University

---

In collaboration with [Fong Chan](https://github.com/tinyheero) and Lu Zhang (Emory University), we have developed `plotmm`, which is a substantial update to the [`plotGMM` package](https://cran.r-project.org/web/packages/plotGMM/index.html).

The package now supports more model objects (from mixtools, EMCluster, and flexmix), as well as many additional mixture model specifications, including mixtures of: 

1. Univariate Gaussians
2. Multivariate Gaussians
3. Gammas
4. Logistic regressions
5. Linear regressions
6. Poisson regressions

The package has five functions: 

1. `plot_mm()`: The main function of the package, `plot_mm` allows the user to simply input the name of the fit mixture model, as well as the number of components `k` that were used in the original fit. The result is a ggplot of the density of the data with overlaid mixture weight component curves.  

2. `plot_cut_point()`: Mixture models are often used to derive cut points of separation between groups in feature space. `plot_cut_point()` plots the data density with the overlaid cut point (the mean of the calculated `mu`) from the fit mixture model. 

3. `plot_mix_comps()`: This is a helper function allowing for expanded visual customization of mixture models. The function superimposes the shape of the components over a `ggplot2` object. This function is also used to render all plots in the main `plot_mm()` function.

4. `plot_gmm()`: This is the original function, upon which the package was expanded. It is included here for quicker access to a common mixture model form (univariate Gaussian), as well as to bridge between the original `plotGMM` package.

5. `plot_mix_comps_normal()`: Similarly, this function is the original `plot_mix_comps()` function for Gaussian mixture models only. It is included for exhaustive bridging between the original `plotGMM` package.

## Installation

Dev version: `devtools::install_github("pdwaggoner/plotmm")`

CRAN (v0.1.0) release: *Forthcoming*

### Tidy visualization of mixture models via `plot_mm()`

First, here is an example for univariate normal mixture model:

```{r }
set.seed(576)

mixmdl <- mixtools::normalmixEM(iris$Petal.Length, k = 2)

# visualize
plot_mm(mixmdl, 2) +
  ggplot2::labs(title = "Univariate Gaussian Mixture Model",
                subtitle = "Mixtools Object")
```
![Univariate GMM](one.pdf)


Next is an example for a mixture of logistic regressions:

```{r }
# set up the data (replication of mixtools examples for comparability)
beta <- matrix(c(-10, .1, 20, -.1), 2, 2)
x <- runif(500, 50, 250)
x1 <- cbind(1, x)
xbeta <- x1%*%beta
w <- rbinom(500, 1, .3)
y <- w*rbinom(500, size=1, prob=(1/(1+exp(-xbeta[, 1])))) + (1-w)*rbinom(500, size=1, prob=(1/(1+exp(-xbeta[, 2]))))
out <- logisregmixEM(y, x, beta = beta, lambda = c(.3, .7), verb = TRUE, epsilon = 1e-01)

# visualize
plot_mm(out) +
  ggplot2::labs(title = "Mixture of Logistic Regressions",
                subtitle = "Mixtools Object")
```
![Mixture of Logistic Regressions](two.pdf)


Next is an example of a mixture of linear regressions:

```{r }
# set up the data (replication of mixtools examples for comparability)
data(NOdata)
attach(NOdata)
set.seed(100)
out <- regmixEM(Equivalence, NO, verb = TRUE, epsilon = 1e-04)
df <- data.frame(out$beta)

# visualize
plot_mm(out) +
  ggplot2::labs(title = "Mixture of Regressions",
                subtitle = "Mixtools Object")
```
![Mixture of Regressions](three.pdf)


Next is a bivariate Gaussian mixture model (via EMCluster)

```{r}
library(EMCluster)
set.seed(1234)
x <- da1$da
out <- init.EM(x, nclass = 10, method = "em.EM")

plot1 <- plot_mm(out, data=x)

plot1 + patchwork::plot_annotation(title = "Bivariate Gaussian Mixture Model",
                                  subtitle = "EMCluster Object")
```
![Bivariate GMM](four.pdf)


### Plot cut points via `plot_cut_point()` (with the [amerika](https://cran.r-project.org/web/packages/amerika/index.html) color palette, wesanderson, grayscale, and cutpoint only)

```{r }
mixmdl <- mixtools::normalmixEM(faithful$waiting, k = 2)

plot_cut_point(mixmdl, plot = TRUE, color = "amerika") # produces plot

plot_cut_point(mixmdl, plot = FALSE) # produces only cut point value
```
![Cut Point from Old Faithful GMM using `plot_cut_point` (amerika)](plotA.png)

![Cut Point from Old Faithful GMM using `plot_cut_point` (wesanderson](plotW.png)

![Cut Point from Old Faithful GMM using `plot_cut_point` (default; custom labs](plotCPD.png)

```{r }
# Or cutpoint value only
plot_cut_point(mixmdl, plot = FALSE) # 67.35299
```


### Customize a ggplot with `plot_mix_comps()`

```{r }
library(plotGMM)
library(magrittr)
library(ggplot2)

# Fit a univariate mixture model via mixtools
set.seed(576)
mixmdl <- mixtools::normalmixEM(faithful$waiting, k = 2)

# Customize a plot with `plot_mix_comps()`
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
![Custom Plot using `plot_mix_comps`](faithful.png)
