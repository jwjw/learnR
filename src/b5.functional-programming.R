# Functional programming

# http://adv-r.had.co.nz/Functional-programming.html
# http://www.r-bloggers.com/functional-programming-in-r/

## Anonymous functions
(function(x,y) {x+y})(1,2)

## Closures

### MLE
require("sde")

spread <- sde.sim(0,1,0,1000,
  drift = expression(0-0.5*x),
  sigma = expression(0.8),sigma.x = expression(0))
plot(spread,type="l")

ou.lik <- function(x) {
  function(theta1,theta2,theta3) {
    n <- length(x)
    dt <- deltat(x)
    -sum(dcOU(x=x[2:n], Dt=dt, x0=x[1:(n-1)],
      theta=c(theta1,theta2,theta3), log=TRUE))
  }
}

ou.fit <- mle(ou.lik(spread),
  start=list(theta1=0,theta2=0.5,theta3=0.2),
  method="L-BFGS-B",lower=c(0,1e-5,1e-3), upper=c(1,1,1))
ou.coe <- coef(ou.fit)
ou.coe

## Higher order functions

### lapply
lapply(1:10,function(i) {
  c(i,i+1)
})

lapply(c(a=1,b=2,c=3), function(i) {
  c(i,i+1)
})

do.call(rbind,lapply(c(a=1,b=2,c=3), function(i) {
  c(i,i+1)
}))

do.call(rbind,lapply(c(a=1,b=2,c=3), function(i) {
  c(x=i,y=i+1)
}))

data.frame(do.call(rbind,lapply(c(a=1,b=2,c=3), function(i) {
  c(i,i+1)
})))

data.frame(do.call(rbind,lapply(c(a=1,b=2,c=3), function(i) {
  c(x=i,y=i+1)
})))

lapply(list(1:10), function(i) {
  class(i)
})

lapply(list(x=1:10,y=c("a","b","c")),function(i) {
  if(is.numeric(i) | is.integer(i)) {
    i^2
  } else if(is.character(i)) {
    toupper(i)
  } else {
    stop("Unknown type of data")
  }
})

lapply(data.frame(x=1:10,y=letters[1:10],z=factor(1:10)),function(col) {
  if(is.numeric(col) | is.integer(col)) {
    col%%2
  } else if(is.character(col)) {
    toupper(col)
  } else {
    col
  }
})

### sapply


### vapply


### apply


### mapply


### tapply


### Map


### Reduce


### Filter
