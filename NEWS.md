---
title: "NEWS.md"
author: "Philip D. Waggoner"
date: "6/28/2019"
output: html_document
---

# `plotGMM` v0.2.1
## Tools for Visualizing Gaussian Mixture Models

### Updates to `plot_cut_point`

1. Returned plots are now `ggplot2` objects (instead of base R, as in prior releases), which allow for more sophisticated plot options, as well as the ability for users to override default values (e.g., changing the plot title, axis labels, etc.).

2. Users can select different color palettes for the histogram. Choices include the `Dem_Ind_Rep7` palette from the `amerika` package, the `Rushmore1` palette from the `wesanderson` package, or `grayscale`, which is the default option.

3. A minor change is the returned value is now the *cut point* value (i.e., `mu` from a `mixtools` GMM) if `plot = FALSE`, instead of the full model summary as in prior releases. **Note**: If users set `plot = FALSE`, but specify a `color` in the function call, nothing will be returned (naturally). In this case, we recommend users either set `plot = TRUE` or remove the `color` argument from the function call. If nothing is done, then the function will still perform as normal.

## How do I get `plotGMM `?

The package is released on CRAN. If you have any questions or find any bugs requiring fixing, please feel free to contact us either directly (see the `DESCRIPTION` file for more) or by opening an issue ticket on GitHub. Thanks and enjoy!
