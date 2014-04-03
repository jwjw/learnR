# Parallel computing

## parallel
library(parallel)
cl <- makeCluster(detectCores())
clusterCall(cl, function() {
  n <<- 100
})
coes <- as.numeric(parLapply(cl,1:10000,function(i) {
  x <- rnorm(n)
  y <- 2*x+rnorm(n)*0.1
  m <- lm(y~x)
  coe <- coef(m)
  coe[[2]]
}))
stopCluster(cl)
hist(coes)


## parallelMap
library(parallelMap)
parallelStart(mode="socket",cpus=4)
result <- parallelSapply(1:10000, function(i,n) {
  x <- rnorm(n)
  y <- 2*x+rnorm(n)*0.1
  m <- lm(y~x)
  coe <- coef(m)
  coe[[2]]
},n=100)
parallelStop()


## foreach
library(foreach)
library(doParallel)
cl <- makeCluster(detectCores())
clusterCall(cl, function() {
  n <<- 100
})
registerDoParallel(cl)
result <- foreach(i=1:10000) %dopar% {
  x <- rnorm(n)
  y <- 2*x+rnorm(n)*0.1
  m <- lm(y~x)
  coe <- coef(m)
  coe[[2]]
}
stopCluster(cl)


## doParallel + plyr
library(plyr)
library(doParallel)
cl <- makeCluster(detectCores())
clusterCall(cl, function() {
  n <<- 100
})
registerDoParallel(cl)
result <- llply(1:10000,function(i) {
  x <- rnorm(n)
  y <- 2*x+rnorm(n)*0.1
  m <- lm(y~x)
  coe <- coef(m)
  coe[[2]]
},.parallel=T)
stopCluster(cl)

