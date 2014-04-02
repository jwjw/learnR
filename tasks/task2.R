n <- 100
x <- rnorm(n)
y <- 2*x+rnorm(n)*0.1
m <- lm(y~x)
coe <- coef(m)
