context("plot_gmm")

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
