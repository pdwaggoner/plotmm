---
title: "NEWS.md"
author: "Philip D. Waggoner"
date: "3/28/2019"
output: html_document
---

# `plotGMM` v 0.2.0
## Tools for Visualizing Gaussian Mixture Models

### Changes: New Functions Added

1. `plot_GMM`: Now the main function of the package, `plot_GMM` allows the user to simply input the name of a `mixEM` class object (from fitting a Gaussian mixture model (GMM) using the `mixtools` package), as well as the number of components, `k`, that were used in the original GMM fit. The result is a clean `ggplot2` class object showing the density of the data with overlaid mixture weight component curves.  

2. `plot_cut_point`: Gaussian mixture models (GMMs) are not only used for uncovering clusters in data, but are also often used to derive cut points, or lines of separation between clusters in feature space (see the Benaglia et al. 2009 reference in the package documentation for more). The `plot_cut_point` function plots data densities with the overlaid cut point (the mean of the calculated `mu`) from `mixEM` class objects, which are GMM's fit using the `mixtools` package.

## How do I get `plotGMM `?

The package is released on CRAN. If you have any questions or find any bugs requiring fixing, please feel free to contact us either directly (see the `DESCRIPTION` file for more) or by opening an issue ticket on GitHub. Thanks and enjoy!
