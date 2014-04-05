# R language mechanism

## Lazy evaluation

fun <- function(a,b=c) {
  c <- 1
  a+b
}


## Dynamic scoping
fun <- function(a,b) {
  if(a>b) {
    f1 <- function(c) {
      x*c
    }
    x <- a-b
    a <- a+1
    z <- f1(5)
  } else if(a<b) {
    f1 <- function(c) {
      x/c
    }
    x <- a+b
    b <- b-1
    z <- f1(6)
  } else {
    z <- 0
  }
  a*b*z
}

fun(1,2)


## Typed object searching
list <- list(a=1,b=2)
list2 <- list(a=2,b=3)
list.a <- list$a
list2.b <- list2$b


## ...
tplot <- function(...,type=c("plot","hist"),message=TRUE) {
  par(mfrow=c(1,length(type)))
  if(message) message("Plot started")
  lapply(type, function(f) {
    if(is.function(f)) {
      fun <- f
    } else if (is.character(f)) {
      fun <- get(f)
    } else {
      stop("'type' must be character or function")
    }
    fun(...)
  })
  if(message) message("Plot finished")
}

tplot(rnorm(100),type=c("plot","hist"))
tplot(rnorm(100),type=c(plot,hist))
tplot(rnorm(100),type=c(plot,hist,function(...) {plot(...,col="red")}))
tplot(rnorm(100),col="red",type=c(plot,hist),message = F)



## Environment

### Value type: locally mutable
### Reference type: Globally mutable
l1 <- list(a=0,b=0)
e1 <- as.environment(l1)
e2 <- new.env()
e2$a <- 0
e2$b <- 0
e3 <- list2env(l1)

ls.str(l1)
ls.str(e1)
ls.str(e2)
ls.str(e3)

fun <- function(x) {
  x$a <- x$a+1
  x$b <- x$b+1
  invisible(NULL)
}

fun(l1)
str(l1)

fun(e1)
ls.str(e1)

fun(e2)
ls.str(e2)

fun(e3)
ls.str(e3)


get("a",envir = e1)
get("b",envir = e2)

e3 <- new.env()
sys.source("tasks/task2.R",envir = e3)
e3$coe
objects(envir = e3)
get("m",envir = e3)
ls.str(envir = e3)


env <- new.env()
env$a <- 1
env$b <- 2

fun <- function(x,env) {
  attach(env)
  z <- c(x+a,x+b,x*a*b)
  detach(env)
  z
}

fun(2,env)


## Expression
e1 <- expression(sum(1:10))
e1
eval(e1)
e1[[1]]
e1[[1]][1] <- call("prod")
eval(e1)
e1[[1]][1] <- expression(sum)
eval(e1)

e2 <- expression(x+10)
e2
eval(e2)

x <- 10
eval(e2)
rm(x)

env <- new.env()
env$x <- 20
eval(e2,env)

env <- as.environment(list(x=20))
eval(e2,env)

# http://stackoverflow.com/questions/22805816/what-is-the-mechanism-that-makes-work-when-defined-by-in-empty-environment

env <- as.environment(list(x=20,`+`=function(a,b) {a+b}))
eval(e2,env)

env <- list2env(list(x=20))
eval(e2,env)

e3 <- parse(text="x <- rnorm(100)")
eval(e3)

# http://obeautifulcode.com/R/How-R-Searches-And-Finds-Stuff/
