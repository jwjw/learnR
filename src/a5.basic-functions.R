# Basic functions

## Environment functions
search()

x <- 1
y <- 1

objects()
remove(x)
rm(y)

## Package functions
require(graphics)
library(graphics)
install.packages("dplyr")

## Object functions
x <- 1
class(x)
typeof(x)
str(x)

x <- c(1,2,3)
class(x)
typeof(x)
str(x)

x <- c("a","b")
class(x)
typeof(x)
str(x)

x <- list(a=1,b=2)
class(x)
typeof(x)
str(x)

x <- data.frame(a=1,b=2)
class(x)
typeof(x)
str(x)


## Logical functions
a1 <- c(TRUE, TRUE, FALSE)
a2 <- c(TRUE, FALSE, FALSE)
a1 & a2
a1 | a2

x <- rnorm(100)
any(x > 1)
all(x <= 4)

which(x >= 1.5)


## Character functions: cat(), message(), print(), sprintf(), paste(), paste0()
cat("Hello, world!")
message("Hello, world!")
print("Hello, world!")
cat("A new line\nA tab\t")
message("A new line\nA tab\t")
sprintf("Hello, %s! Your number is %d., and your score is %.2f","Jack",50,35.618)
paste("Hello","world")
paste("Hello","world",sep="-")
paste0("Hello","world")
tolower("Hello")
toupper("Hello")
nchar("Hello")
ch1 <- "Hello"
substr(ch1,1,3)
substr(ch1,1,3) <- "abc"

## Math funcitons
sin(1)
cos(1)
tan(1)
exp(-1)
sinh(1)
cosh(1)
tanh(1)
factorial(5)
ceiling(10.6)
floor(9.5)
trunc(1.5)
round(pi,3)
signif(pi,3)

polyroot(c(1,2,1,-1))
f <- deriv(y~sin(cos(x)*y),c("x","y"),func=T)
f(1,2)

uniroot(function(x) x^3-x+1,c(-5,5))



## Statistical functions
x.norm <- rnorm(20)
mean(x.norm)
sd(x.norm)
median(x.norm)
quantile(rnorm(x.norm))
max(x.norm)
min(x.norm)
pmax(c(1,2,3),c(2,3,1))
pmin(c(1,2,3),c(2,3,1),c(3,2,1))
summary(x.norm)

set.seed(100)
sample(c(1,2,3),size = 2,replace = FALSE)
sample(c("a","b","z"),size = 10, replace = TRUE)
rnorm(20,mean = 10,sd = 2)
rbinom(20,size = 10,prob = 0.6)
runif(20)
runif(20,min = 10,max = 20)
rgamma(20,shape = 0.5)

plot(dnorm,xlim=c(-3,3))
plot(pnorm,xlim=c(-3,3))
qnorm(c(0.01,0.99))

## Data manipulation

### Data read
EURUSD5 <- read.csv("data/EURUSD5.csv",header=FALSE,
  col.names=c("Date","Time","Open","High","Low","Close","Volume"))

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

### Transformation
EURUSD5$DateTime <- strptime(paste(EURUSD5$Date,EURUSD5$Time),format="%Y.%m.%d %H:%M")
EURUSD5 <- EURUSD5[c("DateTime","Open","High","Low","Close","Volume")]

EURUSD5a <- transform(EURUSD5, Medium=(High+Low)/2)

### Data write
write.csv(EURUSD5a,"output/EURUSD5a.local.csv",row.names=FALSE)
write.table(EURUSD5a,"output/EURUSD5a.local.txt",row.names=FALSE,sep="\t")

#### Read/Write via RSQLite
##### Write data.frame to SQLite database
require(RSQLite)
conn <- dbConnect(SQLite(),"data/example.local.sqlite")
n <- 1000000
products.df <- data.frame(i=1:n,type=sample(LETTERS,n,T),
  class=sample(LETTERS[1:3],n,T),x=rnorm(n,6,2),y=rbinom(n,10,0.6))
dbWriteTable(conn,"products",products.df)
dbDisconnect(conn)

##### Read data.frame from SQLite database
require(RSQLite)
conn <- dbConnect(SQLite(),"data/example.local.sqlite")
products.A <- dbGetQuery(conn,"SELECT * FROM products WHERE type='A'")
products.subset <- dbGetQuery(conn,"SELECT i,class,x+y AS z FROM products WHERE type='A' AND x>=8")
dbDisconnect(conn)

## Higher-order functions

### Example: passing function as function argument
add <- function(x,y,z) {
    x+y+z
}
product <- function(x,y,z) {
    x*y*z
}
aggregate <- function(x,y,z,fun) {
    fun(x,y,z)
}

### Example: using lapply()
result <- list()
for(i in seq_along(x)) {
    result[[i]] <- f(x[i])
}

result <- lapply(x, f)

### Example: using closure
add <- function(x,y) {
    x+y
}
result <- lapply(1:10, add, y=3)

add <- function(y) {
    function(x) {
        x+y
    }
}
result <- lapply(1:10,add(3))
result <- sapply(1:10,add(3))

## Optimization
f <- function(x) x^4+3*x^2+x-1
optimize(f,c(-6,6))

f <- function(x) x^4+3*x^2+x-1
nlm(f, 0)

f <- function(x) sum((x-1:length(x))^2)
nlm(f, c(10,10))
