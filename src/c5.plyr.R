# {plyr} package
library(plyr)
l1 <- list(rnorm(5),rnorm(10),rnorm(30))


## llply
llply(l1,function(item) {
  c(mean=mean(item),sum=sum(item))
})

## ldply
ldply(l1,function(item) {
  c(n=length(item),mean=mean(item),sum=sum(item))
})

n <- 500000
d1 <- data.frame(type=sample(LETTERS[1:6],n,T),subtype=sample(letters[1:3],n,T),
  x=rnorm(n),y=rbinom(n,10,0.6),z=rgamma(n,0.5))

## dlply
dlply(d1,c("type","subtype"),function(df) {
  lm(z~x+y,data=df)
})

## ddply
ddply(d1,c("type","subtype"),function(df) {
  m <- lm(z~x+y,data=df)
  coef(m)
})
