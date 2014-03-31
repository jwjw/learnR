# Debugging in RStudio
# https://support.rstudio.com/hc/en-us/articles/200713843-Debugging-with-RStudio
# https://support.rstudio.com/hc/en-us/articles/200534337-Breakpoint-Troubleshooting

## Example 1
test1 <- function(n,m=100) {
  for(i in 1:n) {
    x <- rnorm(m)
    y <- rnorm(m)
    m <- lm(y~x)
    coe <- coef(m)
    message(sprintf("message %d: coe = %.2f, %.2f",i,coe[[1]],coe[[2]]))
  }
}

test2 <- function(ns=c(5,10,15)) {
  for(n in ns) {
    message(sprintf("test1(n=%d)",n))
    test1(n)
  }
}
