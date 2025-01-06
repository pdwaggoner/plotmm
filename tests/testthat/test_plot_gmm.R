options(repos = c(CRAN = "https://cloud.r-project.org"))

context("plot_gmm")

if (!requireNamespace("EMCluster", quietly = TRUE)) {
  install.packages("EMCluster")
}

if (!requireNamespace("flexmix", quietly = TRUE)) {
  install.packages("flexmix")
}

if (!requireNamespace("mixtools", quietly = TRUE)) {
  install.packages("mixtools")
}

if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

if (!requireNamespace("plotmm", quietly = TRUE)) {
  install.packages("plotmm")
}

set.seed(235)

test_that("plot_gmm catches input errors", {
  mixmdl <- mixtools::normalmixEM(faithful$waiting, k = 2)
  expect_error(plot_gmm(mixmdl, k = 1))
  expect_error(plot_gmm(mixmdl, k = 16))
})

# Testing beyond 11 components causes problems.
test_that("plot_gmm successfully plots", {
  for (num_comps in seq(2, 11)) {
    mixmdl <- mixtools::normalmixEM(faithful$waiting, k = num_comps)
    expect_is(plot_gmm(mixmdl, k = num_comps), "ggplot")
  }
})
