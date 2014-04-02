# Design patterns
# http://renkun.me/blog/r/2014/02/15/a-principle-of-writing-robust-r-program.html

## data

## input
profile.default <- list(
  name = "test1",
  n = 20,
  random = c("rnorm","runif","rnorm"),
  range = c(0.2,0.8),
  columns = c("a","b","c")
)

profile.user <- list(
  n = 30
)

profile <- modifyList(profile.default,profile.user)

## logic
data <- lapply(profile$random,function(fun) {
  rnd <- get(fun)
  val <- rnd(n=profile$n)
  val[val < profile$range[1]] <- profile$range[1]
  val[val > profile$range[2]] <- profile$range[2]
  return(val)
})
df <- data.frame(do.call(cbind,data))
colnames(df) <- profile$columns

## output
df
