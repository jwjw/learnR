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


## Statistical functions


## Data manipulation

### Data read
EURUSD5 <- read.csv("data/EURUSD5.csv",header=FALSE,
  col.names=c("Date","Time","Open","High","Low","Close","Volume"))

sh000300 <- read.csv("data/sh000300.csv",header = T,
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

