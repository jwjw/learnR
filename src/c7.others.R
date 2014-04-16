# Other packages

## pipeR
# https://github.com/renkun-ken/pipeR
library(pipeR)
plot(diff(log(sample(rnorm(10000,mean=10,sd=1),size=100,replace=FALSE))),col="red",type="l")

rnorm(10000,mean=10,sd=1) %>%
  sample(size=100,replace=FALSE) %>%
  log %>%
  diff %>%
  plot(col="red",type="l")

rnorm(10000,mean=10,sd=1) %>>%
  sample(.,size=length(.)/500,replace=FALSE) %>>%
  log %>>%
  diff %>>%
  plot(.,col="red",type="l",main=sprintf("length: %d",length(.)))

rnorm(100) %>% plot

rnorm(100) %>% plot(col="red")

rnorm(1000) %>% sample(size=100,replace=F) %>% hist

rnorm(100) %>>% plot

rnorm(100) %>>% plot(.)

rnorm(100) %>>% plot(.,col="red")

rnorm(1000) %>>% sample(.,length(.)/20,F)

rnorm(1000) %>>% sample(.,length(.)/20,F) %>>% plot(.,main=sprintf("length: %d",length(.)))

rnorm(100) %>>% {
  par(mfrow=c(1,2))
  hist(.,main="hist")
  plot(.,col="red",main=sprintf("%d",length(.)))
}


library(dplyr)
library(hflights)
data(hflights)

hflights %>%
  mutate(Speed=Distance/ActualElapsedTime) %>%
  group_by(UniqueCarrier) %>%
  summarize(n=length(Speed),speed.mean=mean(Speed,na.rm = T),
    speed.median=median(Speed,na.rm=T),
    speed.sd=sd(Speed,na.rm=T)) %>%
  mutate(speed.ssd=speed.mean/speed.sd) %>%
  arrange(desc(speed.ssd)) %>>%
  barplot(.$speed.ssd, names.arg = .$UniqueCarrier,
    main=sprintf("Standardized mean of %d carriers", nrow(.)))

hflights %>%
  mutate(Speed=Distance/ActualElapsedTime) %>%
  group_by(UniqueCarrier) %>%
  summarize(n=length(Speed),speed.mean=mean(Speed,na.rm = T),
    speed.median=median(Speed,na.rm=T),
    speed.sd=sd(Speed,na.rm=T)) %>%
  mutate(speed.ssd=speed.mean/speed.sd) %>%
  arrange(desc(speed.ssd)) %>>%
  assign("hflights.speed",.,.GlobalEnv) %>>%
  barplot(.$speed.ssd, names.arg = .$UniqueCarrier,
    main=sprintf("Standardized mean of %d carriers", nrow(.)))

{
  hflights %>%
  mutate(Speed=Distance/ActualElapsedTime) %>%
  group_by(UniqueCarrier) %>%
  summarize(n=length(Speed),speed.mean=mean(Speed,na.rm = T),
    speed.median=median(Speed,na.rm=T),
    speed.sd=sd(Speed,na.rm=T)) %>%
  mutate(speed.ssd=speed.mean/speed.sd) %>%
  arrange(desc(speed.ssd)) ->>
    hflights.speed
} %>>%
  barplot(.$speed.ssd, names.arg = .$UniqueCarrier,
    main=sprintf("Standardized mean of %d carriers", nrow(.)))

## rootSolve
# http://www.rdocumentation.org/packages/rootSolve
library(rootSolve)
fun <- function(x) cos(2*x)^3
curve(fun(x),0,10,main="uniroot.all")
All <- uniroot.all(fun,c(0,10))
All
points(All,y=rep(0,length(All)),pch=16,cex=2)

f <- function (x) 1/cos(1+x^2)
AA <- uniroot.all(f, c(-5, 5))
curve(f(x), -5, 5, n = 500, main = "uniroot.all")
points(AA, rep(0, length(AA)), col = "red", pch = 16)
f(AA)

## Rsolnp
# http://www.rdocumentation.org/packages/Rsolnp
library(Rsolnp)
fn1 <- function(x) exp(x[1]*x[2]*x[3]*x[4]*x[5])
eqn1 <- function(x) {
	z1 <- sum(x^2)
	z2 <- x[2]*x[3]-5*x[4]*x[5]
	z3 <- x[1]^3+x[2]^3
	return(c(z1,z2,z3))
}
x0 <- c(-2, 2, 2, -1, -1)
powell <- solnp(x0, fun = fn1, eqfun = eqn1, eqB = c(10, 0, 5))
powell
fn1(powell$pars)


## R Markdown (pandoc, {rmarkdown})
