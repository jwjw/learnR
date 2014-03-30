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
sapply(list(mean=mean,sd=mean,max=max,min=min),function(f) f(idx$close))

## Linear regression

### Linear model fit
m <- lm(close~high+low+log(tradeVolume),data=idx)
m
print(m)

### Linear model diagnostic plot
plot(m)

### Linear model coefficients
coe <- m$coefficients
coe <- coef(m)
coe["high"]
coe[["low"]]

### Linear  model residuals
res <- m$residuals
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
### Test null hypothesis of independence
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
