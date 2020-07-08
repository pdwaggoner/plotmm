---
title: "NEWS.md"
author: "Waggoner, Chan, Zhang"
date: "07/08/2020"
output: html_document
---

# `plotmm` v0.1.0

## Tidy Tools for Visualizing Mixture Models

The `plotmm` package is a substantially updated version of the `plotGMM` package (Waggoner and Chan). Whereas `plotGMM` only includes support for visualizing univariate Gaussian mixture models fit via the `mixtools` package, the new `plotmm` package supports numerous mixture model specifications from several packages (model objects).

Waggoner and Chan would like to sincerely thank Zhang for joining the team and making development of this package possible.

## Key Features

Supported model objects/packages include:

1. `mixtools`
2. `EMCluster`
3. `flexmix`

Supported specifications include mixtures of:

1. Univariate Gaussians
2. Multivariate Gaussians
3. Gammas
4. Logistic regressions
5. Linear regressions
6. Poisson regressions

Note that though `plotmm` includes many updates and expanded functionality beyond `plotGMM`, it is under active development with support for more model objects and specifications forthcoming. Stay tuned for updates, and always feel free to open an issue ticket to share anything you'd like to see included in future versions of the package.

## How do I get `plotmm `?

The package is available on CRAN. If you have any questions or find any bugs requiring fixing, please feel free to contact us either directly (see the `DESCRIPTION` for more) or by opening an issue ticket on GitHub. Thanks and enjoy!
