library(fUnitRoots)
n <- 1000
stats <- vapply(1:1000,function(i) {
  x <- cumsum(rnorm(n))
  y <- 2*x+rnorm(n)*0.1
  m <- lm(y~x)
  res <- resid(m)
  adf <- adfTest(res,type="nc")
  adf@test$statistic
},numeric(1))
quantile(stats)
