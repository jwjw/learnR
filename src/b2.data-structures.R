# Data structures

## S3 object
library(stats)
x <- rnorm(100)
y <- 2*x+rnorm(100)*0.1
m <- lm(y~x)
class(m)
plot(m)
coef(m)
plot(resid(m))


## S4 object

### fUnitRoots
library(fUnitRoots)
x <- cumsum(rnorm(200))
y <- 2*x+norm(200)*0.1
m <- lm(y~x)
res <- residuals(m)
adf <- adfTest(res,type="nc")
class(adf)
adf@test$statistic

### MLE
x <- rnorm(100,mean = 10,sd = 3)
norm.lik <- function(x) {
  function(mean,sd) {
    -sum(dnorm(x,mean = mean,sd = sd,log = TRUE))
  }
}
x.fit <- mle(norm.lik(x),start = list(mean=0,sd=1),method = "L-BFGS-B",
  lower=c(-20,1e-2),upper=c(20,6))
class(x.fit)
x.fit@coef
coef(x.fit)
AIC(x.fit)
logLik(x.fit)
