# Parallel computing

## parallel
library(parallel)
cl <- makeCluster(detectCores())
clusterCall(cl, function() {
  n <<- 100
})
coes <- as.numeric(clusterApply(cl,1:1000,function(i) {
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

parallelStop()

## doParallel + plyr
