# {dplyr} package
library(dplyr)

## prepare data frame
set.seed(133)

df <- local({
  n <- 2000000
  data.frame(
    id=1:n,
    type=sample(LETTERS[1:3],n,T),
    class=sample(letters[1:4],n,T),
    weight=rnorm(n,mean = 100,sd = 5),
    height=rnorm(n,mean = 30,sd = 3),
    radius=rnorm(n,mean = 10,sd = 1),
    inventory=rpois(100,5),
    stamp=rbinom(n,1000,0.1))
})

## select
df.select <- select(df,type,height,radius)

## filter
df.filter <- filter(df,pi*radius^2*height/weight >= 120)

## summarize
df.summary <- summarize(df,mean(weight),sd(weight),mean(radius),sd(radius))

## mutate
df.mutate <- mutate(df,density=pi*radius^2*height/weight)

## arrange
df.arrange <- arrange(df.mutate,type,class,desc(density))

## group_by
df.group <- group_by(df.mutate,type,class)
df.group.summary <- summarize(df.group,mean(density),sd(density))

## do
df.group.do.list <- do(df.group, function(g) {
  m <- lm(density~weight+height+radius,data=g)
  c(type=g[1,"type"],class=g[1,"class"],coef(m))
})
df.group.do <- do.call(rbind,df.group.do.list)

## Chain operator %.%
df.summary <-
  df %.%
  select(id:inventory) %.%
  mutate(density=pi*radius^2*height/weight) %.%
  filter(inventory >= 3 & density >= 100) %.%
  group_by(type,class) %.%
  summarize(density.mean=mean(density),density.sd=sd(density),
    inventory.sum=sum(inventory)) %.%
  mutate(density.smean=density.mean/density.sd) %.%
  arrange(desc(density.smean))

## Applications with {hflights} data
library(hflights)
data(hflights)
