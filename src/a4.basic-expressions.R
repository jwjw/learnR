# Basic expressions

## Assignment: `<-`, `->`, `<<-`, `->>`, `=`
x1 <- 1
2 -> x2
x3 <<- 3
4 ->> x4
x5 = 5
x6 <- x7 = 8

### Local evaluation
local({
  x1 <- 1
  x1+1
})

local({
  x1 <<- 1
  x1+1
})


### Scoping

x <- 10
local({
  message(x)
  x <- 5
  message(x)
})
message(x)


x <- 10
local({
  message(x)
  x <- 5
  local({
    message(x)
    x <- 3
    message(x)
  })
  message(x)
})
message(x)


x <- 10
local({
  message(x)
  x <<- 5
  local({
    x <<- 3
    message(objects())
    message(x)
  })
  message(objects())
  message(x)
})
objects()
message(x)

### Invisible return value
f <- function(x,y) {
  invisible(x+y)
}

f(1,2)
m <- f(1,2)
m1 <- m2 <- f(1,2)

### Quotation
`+a` <- c(1,2,3)
`-a` <- function(a,d) { a-d }
l1 <- list(`a+-`=rnorm(10),`a-+`=rnorm(10))
data.frame(`a-+`=rnorm(10),`a+-`=rnorm(10))

## Conditional expression

### if-else

num <- as.numeric(readline("Number? "))
if(num > 0) {
  cat("The number is greater than 0")
} else if(num < 0) {
  cat("The number is less than 0")
} else {
  cat("The number is 0")
}

### ifelse

num1 <- as.numeric(readline("Number 1? "))
num2 <- as.numeric(readline("Number 2? "))
num3 <- ifelse(num1 > 0 & num2 < 0, 1, 0)


## Loop expression

### for-loop
for(i in c(1,2,3)) {
  message("Hello, world!")
}

for(i in 1:10) {
  message(sprintf("Message %d",i))
}


for(i in 1:10) {
  if(i==5) break
  else message(sprintf("Message %d",i))
}

for(i in 1:10) {
  if(i==5) next
  else message(sprintf("Message %d",i))
}

for(item in c("Hello","World","Hi")) {
  message(item)
}

for(item in list(a=c(1,2,3),b=c("a","b","c","d"))) {
  str(item)
}

df <- data.frame(x=c(1,2,3),y=c("A","B","C"),stringsAsFactors = FALSE)
for(col in df) {
  str(col)
}

for(i in 1:nrow(df)) {
  row <- df[i,]
  str(row)
}

### while-loop

x <- 0
while(x <= 10) {
  message(x)
  x <- x + 1
}

### repeat loop

x <- 0
repeat {
  x <- x+1
  if(x==10) break
  else if(x==5) {
    next
  }
  else {
    message(x)
  }
}
