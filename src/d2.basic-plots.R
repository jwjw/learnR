# Basic plots

## Plot (scatter, line, etc.)
# http://www.statmethods.net/advgraphs/parameters.html
df <- data.frame(x=rnorm(100))
df <- transform(df,y=2*x+rnorm(100))

plot(df$x)
plot(df$x,df$y)
plot(y~x,data=df)
plot.types <- c("p","l","b","c","o","h","s","S","n")
invisible(lapply(plot.types,function(type) {
  plot(df$y,type=type,main=sprintf("Plot for y in df (type: %s)",type),
    xlab="index",ylab="df$y",col="blue")
}))

plot(sin,xlim=c(-3,3))
plot(dnorm,xlim=c(-3,3))

## Bar charts
library(hflights)
tab <- sort(table(hflights$UniqueCarrier),decreasing = T)
barplot(tab,main="Number of flights with DFW as destination for each carrier",cex.main=0.9)

## Pie charts
library(hflights)
tab <- sort(table(hflights$UniqueCarrier),decreasing = T)
pie(tab,main="Number of flights with DFW as destination for each carrier",cex.main=0.9)

## Composing plots
plot(df$y,main="y values",asp=2.5)
qts <- quantile(df$y)
abline(h=qts,col="blue")
text(x=5,y=qts,labels = names(qts),cex = 0.8)

plot(df$y,main="y values", type="l", asp=2.5)
points(df$y,col="red",pch=20,lwd = 1)
abline(h=mean(df$y),col="blue",lty=3)

plot(y~x,data=df)
m <- lm(y~x,data=df)
abline(m,col="red")

## Partitioning plots
par(mfrow=c(1,2))
plot(df$y,main="Values of y")
hist(df$y)

par(mfrow=c(2,2))
for(i in 1:4) {
  plot(df$x,df$y^i,main=sprintf("y~x^%d",i))
}

par(mfrow=c(2,2))
plot(m,ask=F)

df2 <- data.frame(x=rnorm(100))
df2$y <- 2*df$x+rnorm(100)*0.1
df2$z <- 3*df$x+rnorm(100)*0.2
df2$w <- 4*df$x+rnorm(100)*0.3

par(mfrow=c(1,3),oma = c(0,0,2,0))
plot(w~.,data=df2,ask=F)
title("Plots for w~x+y+z",outer = T,cex.main=1.5)

## Graphics devices
### Bitmap (bmp)
bmp("local/output.bmp",width = 800,height=600,units = "px",
  antialias = "cleartype")
par(mfrow=c(2,2))
plot(m,ask=F)
dev.off()

### JPEG (jpg)
jpeg("local/output.jpg",width = 800,height=600,units = "px",
  antialias = "cleartype")
par(mfrow=c(2,2))
plot(m,ask=F)
dev.off()

### Portable Network Graphics (png)
png("local/output.png",width = 800,height=600,units = "px")
par(mfrow=c(2,2))
plot(m,ask=F)
dev.off()

### TIFF (tif)
tiff("local/output.tif",width = 800,height=600,units = "px",
  antialias = "cleartype")
par(mfrow=c(2,2))
plot(m,ask=F)
dev.off()

### SVG (svg)
svg("local/output.svg",width = 16,height=9)
par(mfrow=c(2,2))
plot(m,ask=F)
dev.off()

### Portable Document Format (pdf)
pdf("local/output.pdf",width = 16,height=9,compress = TRUE)
par(mfrow=c(2,2))
plot(m,ask=F)
dev.off()


## Interative graphics ({manipulate})
library(manipulate)
manipulate(plot(1:x), x = slider(5, 10))

manipulate(
  plot(cars, xlim=c(x.min,x.max)),
  x.min=slider(0,15),
  x.max=slider(15,30))

manipulate(
  barplot(as.matrix(longley[,factor]),
          beside = TRUE, main = factor),
  factor = picker("GNP", "Unemployed", "Employed"))

manipulate(
  plot(pressure, type = type),
  type = picker("points" = "p", "line" = "l", "step" = "s"))

manipulate(
  boxplot(Freq ~ Class, data = Titanic, outline = outline),
  outline = checkbox(FALSE, "Show outliers"))

manipulate(
  plot(cars, xlim = c(x.min, x.max), type = type,
       axes = axes, ann = label),
  x.min = slider(0,15),
  x.max = slider(15,30, initial = 25),
  type = picker("p", "l", "b", "c", "o", "h", "s", "S", "n"),
  axes = checkbox(TRUE, "Draw Axes"),
  label = checkbox(FALSE, "Draw Labels"))
