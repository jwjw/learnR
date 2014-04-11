# Functional programming

# http://adv-r.had.co.nz/Functional-programming.html
# http://www.r-bloggers.com/functional-programming-in-r/

## Anonymous functions
(function(x,y) {x+y})(1,2)

## Closures

### MLE (OU-process)
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
  i^2
})

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

do.call(rbind,lapply(1:10, function(i) {
  data.frame(x=rnorm(i),y=rnorm(i)*2)
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

lapply(list(1:10), class)

do.call(c,lapply(1:10,function(i){
  rnorm(i)
}))

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
sapply(1:10,function(i) {
  i^2
})

sapply(1:10,function(i) {
  c(i,i^2)
})

sapply(1:10,function(i) {
  c(x=i,y=i^2)
})

sapply(list(a=1:10,b=3:6), function(i) {
  c(x=i,y=i^2)
})

sapply(list(a=1:10,b=3:6), function(i) {
  rbind(x=i,y=i^2)
})

sapply(list(a=1:10), function(i) {
  rbind(x=i,y=i^2)
})

### vapply
vapply(1:10,function(i) {
  i^2
},numeric(1))

vapply(1:10,function(i) {
  c(i,i^2)
},numeric(2))

vapply(1:10,function(i) {
  c(x=i,y=i^2)
},numeric(2))


### apply
m <- matrix(1:50,nrow = 10,ncol = 5)
m
apply(m,1,mean)
apply(m,2,mean)
apply(m,1,sum)
apply(m,2,sum)
apply(m,1,function(row) {
  c(row[1],row[2])
})
apply(m,2,function(row) {
  c(row[1],row[2])
})


### mapply
mapply(rep, 1:4, 4:1)


### tapply
groups <- as.factor(rbinom(100, 5, 0.4))
tapply(groups, groups, length)

n <- 17
fac <- factor(rep(1:3, length = n), levels = 1:5)
table(fac)
tapply(1:n, fac, sum)
sum((1:n)[c(T,F,F)])
sum((1:n)[c(F,T,F)])
sum((1:n)[c(F,F,T)])

tapply(1:n, fac, sum, simplify = FALSE)
tapply(1:n, fac, range)
tapply(1:n, fac, quantile)

### Map
Map(function(x) x+1, 1:5)
Map(function(x,y) x+y, 1:5, 6:10)
Map(function(x,y,z) x*y+y*z+x*z, 1:3,4,6:11)

### Reduce
add <- function(x) Reduce(`+`,x)
add(list(1,2,3))

times <- function(x) Reduce(`*`,x,init = 1)
times(list(1,2,3))

dfs <- lapply(1:5, function(k) {
  df <- data.frame(i=1:10,x=rnorm(10,k,1))
  colnames(df) <- c("i",letters[k])
  df
})
df1 <- Reduce(function(...) merge(...,by = "i"),dfs)

### Filter
Filter(function(x) x>=0, rnorm(10))

### Position
Position(function(x) x>=0, c(-2,-1,0,1,2,3))

### Find
Find(function(x) x>=0, c(-2,-1,0,1,2,3))
