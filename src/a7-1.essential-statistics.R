# Essential statistics

## Prepare data
idx <- read.csv("data/sh000300.csv",header = T,
  col.names=c("date","open","high","low","close","volume","tradeVolume"),
  colClasses=c("Date","numeric","numeric","numeric","numeric","numeric","numeric"))
us.cpi <- read.csv("data/us-cpi.csv",header = T,
  col.names=c("year","month","cpi"),
  colClasses=c("integer","integer","numeric"))
us.gdp <- read.csv("data/us-gdp.csv",header = T,
  col.names=c("year","month","gdp"),
  colClasses=c("integer","integer","numeric"))
us <- merge(us.gdp,us.cpi,by = c("year","month"))
rm(us.gdp,us.cpi)


## Descriptive statistics
mean(idx$close)
median(idx$close)
sd(idx$close)
max(idx$close)
min(idx$close)
range(idx$close)
quantile(idx$close)
fivenum(idx$close)
IQR(idx$close)
summary(idx$close)
summary(idx)
str(idx)
cor(idx[-1])
cor(log(us$gdp),us$cpi)

mean(idx$close,trim = 0.05)
mean(idx$close,trim = 0.1)
sapply(list(mean=mean,sd=sd,max=max,min=min),function(f) f(idx$close))

## Linear regression

### Linear model fit
m <- lm(close~high+low+log(tradeVolume),data=idx)
m
print(m)

### Linear model diagnostic plot
plot(m)

### Linear model coefficients
coe <- m$coefficients
coe <- coefficients(m)
coe <- coef(m)

coe["high"]
coe[["low"]]

### Linear  model residuals
res <- m$residuals
res <- residuals(m)
res <- resid(m)

plot(res)

### Linear model plot
plot(x=m$fitted.values,y=idx$close)

### Linear model summary
summary(m)
ms <- summary(m)
ms$sigma
ms$r.squared
ms$adj.r.squared
ms$fstatistic
ms$cov.unscaled

## Statistical hypothesis testing
# http://www.r-tutor.com/elementary-statistics/hypothesis-testing
t.test(res)
Box.test(res)
wilcox.test(res)

library(tseries)
adf.test(res,alternative = "stationary", k = 1)
pp.test(res)

## Model analysis
confint(m)
inf <- influence(m)
influence.measures(m)
eff <- effects(m)
vcov(m)
deviance(m)

aov(close~high+low+log(tradeVolume),data=idx)
anova(m)

### Update a model: update()
m1 <- update(m,close~high+low+0)
m2 <- update(m,.~I((high+low)/2)+log(tradeVolume))
m3 <- update(m,close~high+low+factor(up),data=transform(idx,up=c(F,diff(open)>0))[-1,])

### Predict with a model: predict()
m4 <- update(m2, data=idx[1:(nrow(idx)-51),])
m4.real <- idx[50:nrow(idx),"close"]
m4.pred <- predict(m4,newdata=idx[50:nrow(idx),])
plot(x=m4.pred,y=m4.real)
cor(m4.pred,m4.real)
cor(diff(log(m4.pred)),diff(log(m4.real)))


## Time series model fit

### ARIMA
x1 <- arima.sim(model=list(ar=c(0.8,-0.5),ma=c(0.5,0.2)),n = 200)
x1.arma <- arima(x1,order = c(2,0,2),include.mean = F)
confint(x1.arma)
AIC(x1.arma)
logLik(x1.arma)
x1.pred <- predict(x1.arma,n.ahead = 5)
plot(x1,xlim=c(1,205))
lines(x1.pred$pred,col="red")

### GARCH
library(fGarch)
x2 <- garchSim()
x2.fit <- garchFit(~garch(1,1),data = x2)

ret <- diff(log(idx$close))
ret.fit <- garchFit(~garch(1,1),data=ret)
plot(ret.fit)
plot(ret.fit@residuals,main="Residuals")
