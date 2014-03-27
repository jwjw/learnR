# Basic Object Types

## Vector

### Numeric vector
1.5
numeric(10)
c(1,2,3,4.5)
c(1,2,c(2,3))
1:5
seq(1,10,2)
seq(3,length.out = 10)
is.numeric(c(1,2,3,4.5))

### Integer vector
2L
integer(10)
c(1L,2L,3L)
1L:5L
as.integer(c(1,2,3.9))
is.integer(c(1,2,3))
is.integer(c(1L,2L,3L))

### Complex vector
1+2i
1+0i
complex(10)
c(1+i,1+2i,1+3i)
as.complex(c(1,2,3))
is.complex(c(1+i,1+2i,1+3i))

### Logical vector
TRUE
FALSE
T
F
logical(10)
c(TRUE,TRUE,FALSE)
as.logical(c(0,1,-2,3))
as.logical("true")
as.logical("a")
is.logical(c(FALSE,FALSE,TRUE))

### Character vector
"hello, world!"
character(3)
c("Hello","World")
c('This','is','something')
"This is a 'character' enclosed in double quotes"
'This is a "character" enclosed in single quotes'

### Date vector
as.Date("2013-05-10")
as.Date(c("2013-05-10","2014-05-20"))
c(as.Date("2013-05-10"),as.Date("2014-05-20"))

### Named vector
c(a=1,b=2,c=3)
c(category="Class-1",type="PC")
c(1,2,k=3)
nv <- c(1,2,3)
names(nv) <- c("a","b","c")
names(nv) <- NULL

### Subsetting vectors
v1 <- c(1,2,3,4)
v1[2]
v1[2:4]
v1[-3]
v1[2] <- 0
v1[2:4] <- c(0,1,3)
v1[c(TRUE,TRUE,FALSE,FALSE)] <- c(3,2)
v1 <= 2
v1[v1 <= 2] <- 0
v1[v1^2-v1+1>=0]
v1[5] <- 5
v1[10] <- 10

v2 <- c(a=1,b=2,c=3,d=4)
v2["a"]
v2[c("a","d")]
v2["e"] <- 5
v2["z"] <- 26
v2[15] <- 100
v2["e"] <- "hello"

### Arithmetic operators for numeric/integer vectors
c(1,2,3) + c(2,3,4)
c(1,2,3) - c(2,3,4)
c(1,2,3) * c(2,3,4)
c(1,2,3) / c(2,3,4)
c(1,2,3) ^ 2
c(1,2,3) ^ c(2,3,4)
c(1,2,3) %% 2

c(a=1,b=2,c=3) + c(b=2,c=3,d=4)
c(a=1,b=2,3) + c(b=2,c=3,d=4)



## Matrix

### Defining matrix
matrix(c(1,2,3,2,3,4,3,4,5),ncol = 3)

matrix(c(1,2,3,
         4,5,6,
         7,8,9),nrow=3,byrow=FALSE)

matrix(c(1,2,3,
         4,5,6,
         7,8,9),nrow=3,byrow=TRUE)

### Naming matrix
matrix(c(1,2,3,4,5,6,7,8,9),nrow=3,byrow=TRUE,
  dimnames=list(c("r1","r2","r3"),c("c1","c2","c3")))

m1 <- matrix(c(1,2,3,2,3,4,3,4,5),ncol = 3)
rownames(m1) <- c("r1","r2","r3")
colnames(m1) <- c("c1","c2","c3")

diag(1,nrow=5)

### Subsetting matrix
m1[1,]
m1[,2]
m1[1,1]
m1[1:2,]
m1[,2:3]
m1[1:2,2:3]
m1[-1,]
m1[,-2]
m1[1]
m1[9]
m1[3:7]
m1[c("r1","r3"),c("c1","c3")]

### Operators for matrices
m1 + m1
m1 - 2*m1
m1 * m1
m1 / m1
m1^2
m1 %*% m1
t(m1)

## Array
a0 <- array(c(0,1,2,3,4,5,6,7,8,9),dim=c(1,5,2))
dimnames(a0) <- list(c("r1"),c("c1","c2","c3","c4","c5"),c("k1","k2"))

a1 <- array(c(0,1,2,3,4,5,6,7,8,9),dim=c(1,5,2),
  dimnames=list(c("r1"),c("c1","c2","c3","c4","c5"),c("k1","k2")))

a1[1,,]
a1[,2,]
a1[,,1]
a1[1,1,1]
a1[1,2:4,1:2]
a1[c("r1"),c("c1","c3"),"k1"]

## List
l1 <- list(a=1,b=2,c=3)
l1$a
l1["a"]
l1[["a"]]
l1[c("a","b")]
names(l1) <- c("A","B","C")
l1$d <- 4

l2 <- list(a=c(1,2,3),b=c("x","y","z","w"))
l2$b

is.list(l1)
as.list(c(1,2,3))

l3 <- as.list(c(a=1,b=2,c=3))
l3$d
l3$d <- c("hello","world")
l3



## Data frame

### Defining data frame
data.frame(id=1:5,x=c(0,2,1,-1,-3),y=c(0.5,0.2,0.1,0.5,0.9))
data.frame(id=1:10,x=runif(10),y=rnorm(10))
data.frame(id=1:5,name=c("A","A","B","B","C"),x=runif(5),y=rnorm(5))
data.frame(id=1:5,name=c("A","A","B","B","C"),x=runif(5),y=rnorm(5),stringsAsFactor=FALSE)

df1 <- data.frame(1:5,c("A","A","B","B","C"),rnorm(5))
colnames(df1) <- c("id","name","x")

as.data.frame(matrix(c(1,2,3,4,5,6,7,8,9),nrow=3,byrow=FALSE))

### Subsetting data frame
df1$id
df1[1]
df1["name"]
df1[c("id","name")]
df1[1:2]
df1[,"name"]
df1[,c("name","x")]
df1[,1:2]
df1[1:4,]
df1[1:4,"x"]
df1[1:4,c("id","x")]
df1[df1$x>=0,]
df1[df1$name=="A",]


## Function
add <- function(x,y) {
  x+y
}

calc <- function(x,y,type) {
  if(type=="add") {
    x+y
  } else if(type=="minus") {
    x-y
  } else if(type=="multiply") {
    x*y
  } else if(type=="divide") {
    x/y
  } else {
    stop("Unknown type of operation")
  }
}
