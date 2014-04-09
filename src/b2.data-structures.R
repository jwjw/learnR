# Data structures

## S3 object

### Using S3 object
library(stats)
x <- rnorm(100)
y <- 2*x+rnorm(100)*0.1
m <- lm(y~x)
class(m)
plot(m)
coef(m)
plot(resid(m))

### Defining S3 object
abu1 <- list(title="abu object",fun=rnorm,args=list(n=30,mean=1,sd=1))
class(abu1) <- "abu"
plot.abu <- function(x,...) {
  call <- match.call()
  message(sprintf("Plotting %s",x$title))
  num <- do.call(x$fun,x$args)
  plot(num,main=call$x,...)
}

plot(abu1)
plot(abu1,col="red",type="l")

abu2 <- structure(
  list(title="abu object 2",fun=runif,args=list(n=40,min=-1,max=2)),
  class="abu")
class(abu2)
plot(abu2,col="red")

sabu <- structure(
  list(title="abu object 2",fun=runif,args=list(n=40,min=-1,max=2),
    start=function(.self){ message("sabu") }),
  class=c("sabu","abu"))

plot.sabu <- function(x,...) {
  x$start(x)
  plot.abu(x,...)
}

class(sabu)
plot(sabu)
plot.abu(sabu)


## S4 object

### Using S4 object
#### fUnitRoots
library(fUnitRoots)
x <- cumsum(rnorm(200))
y <- 2*x+norm(200)*0.1
m <- lm(y~x)
res <- residuals(m)
adf <- adfTest(res,type="nc")
class(adf)
adf@test$statistic

#### MLE
library(stats4)
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
