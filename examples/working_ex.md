# Tracking Working Examples

### Mixture of Regressions
```{R}
data(NOdata)
attach(NOdata)
set.seed(100)
out <- regmixEM(Equivalence, NO, verb = TRUE, epsilon = 1e-04)
plot_MM(out)
```

### Multivariate normal
```{R}
x.1 <- rmvnorm(40, c(0, 0))
x.2 <- rmvnorm(60, c(3, 4))
x.3 <- rmvnorm(30, c(2, 4))
X.1 <- rbind(x.1, x.2, x.3)
mu <- list(c(0, 0), c(3, 4), c(2,4))
out <- mvnormalmixEM(X.1, arbvar = FALSE, mu = mu,epsilon = 1e-02)
plot_MM(out)
```
