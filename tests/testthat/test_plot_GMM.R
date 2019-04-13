context("plot_GMM")

set.seed(235)

test_that("plot_GMM catches input errors", {
  mixmdl <- mixtools::normalmixEM(faithful$waiting, k = 2)
  expect_error(plot_GMM(mixmdl, k = 1))
  expect_error(plot_GMM(mixmdl, k = 16))
})

# Testing beyond 11 components causes problems.
test_that("plot_GMM successfully plots", {
  for (num_comps in seq(2, 11)) {
    mixmdl <- mixtools::normalmixEM(faithful$waiting, k = num_comps)
    expect_is(plot_GMM(mixmdl, k = num_comps), "ggplot")
  }
})



