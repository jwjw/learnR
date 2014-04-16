# Rcpp

## Introduction to C++

## Introduction to Rcpp
# http://www.rcpp.org/
# {Rcpp}, {RcppArmadillo}, {RcppEigen}, {RInside}

## Rcpp Quick Start
# https://support.rstudio.com/hc/en-us/articles/200486088-Using-Rcpp-with-RStudio
# http://cran.rstudio.com/web/packages/Rcpp/vignettes/Rcpp-quickref.pdf
# http://adv-r.had.co.nz/Rcpp.html

## Performance
Rcpp::sourceCpp('src/c8.Rcpp.test.cpp')
system.time(x1 <- vapply(1:2000000,function(i) {
  a <- i
  a1 <- i
  b <- a*2+1+a1
  c <- a+b*3
  a+(b-c)*(a-b)
},numeric(1)))

system.time(x2 <- vapply(1:2000000, calc1,numeric(1)))

system.time(x3 <- calc1s(2000000))


rate.r <- function(x) {
  diff(x)/x[-length(x)]
}
x <- pmax(rnorm(10000000,100,1),0.01)
system.time(r1 <- rate.r(x))
system.time(r2 <- rate(x))
