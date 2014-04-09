# Other packages

## pipeR
# https://github.com/renkun-ken/pipeR

## rootSolve
# http://www.rdocumentation.org/packages/rootSolve
library(rootSolve)
fun <- function(x) cos(2*x)^3
curve(fun(x),0,10,main="uniroot.all")
All <- uniroot.all(fun,c(0,10))
All
points(All,y=rep(0,length(All)),pch=16,cex=2)

f <- function (x) 1/cos(1+x^2)
AA <- uniroot.all(f, c(-5, 5))
curve(f(x), -5, 5, n = 500, main = "uniroot.all")
points(AA, rep(0, length(AA)), col = "red", pch = 16)
f(AA)

## Rsolnp
# http://www.rdocumentation.org/packages/Rsolnp
library(Rsolnp);
fn1 <- function(x) exp(x[1]*x[2]*x[3]*x[4]*x[5])
eqn1 <- function(x) {
	z1 <- sum(x^2)
	z2 <- x[2]*x[3]-5*x[4]*x[5]
	z3 <- x[1]^3+x[2]^3
	return(c(z1,z2,z3))
}
x0 <- c(-2, 2, 2, -1, -1)
powell <- solnp(x0, fun = fn1, eqfun = eqn1, eqB = c(10, 0, 5))
powell
fn1(powell$pars)
