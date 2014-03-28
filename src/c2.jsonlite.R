# {jsonlite} package
library(jsonlite)

## What is JSON

## Why JSON

## Read/Write JSON in R

### Exampel 1
get.df <- function(json) {
  require(jsonlite)
  profile <- fromJSON(json,simplifyDataFrame = FALSE)
  message(sprintf("Profile '%s' loaded", profile$title))
  rows <- data.frame(lapply(names(profile$functions),function(fun) {
    do.call(fun,c(list(n=profile$sample),profile$functions[[fun]]))
  }))
  colnames(rows) <- names(profile$functions)
  aggs <- data.frame(lapply(profile$aggregate, function(fun) {
    apply(rows,MARGIN = 1,FUN = get(fun))
  }))
  colnames(aggs) <- profile$aggregate
  cbind(rows,aggs)
}

df <- get.df("data/test1.json")

### Example 2: modifyList()

get.df2 <- function(name,format="data/%s.json",update=".user") {
  require(jsonlite)
  file.default <- sprintf(format,name)
  file.user <- sprintf(format,paste0(name,update))
  profile <- fromJSON(file.default,simplifyDataFrame = FALSE)
  if(file.exists(file.user)) {
    profile.user <- fromJSON(file.user,simplifyDataFrame = FALSE)
    profile <- modifyList(profile,profile.user)
  }
  str(profile)
  message(sprintf("Profile '%s' loaded", profile$title))
  rows <- data.frame(lapply(names(profile$functions),function(fun) {
    do.call(fun,c(list(n=profile$sample),profile$functions[[fun]]))
  }))
  colnames(rows) <- names(profile$functions)
  aggs <- data.frame(lapply(profile$aggregate, function(fun) {
    apply(rows,MARGIN = 1,FUN = get(fun))
  }))
  colnames(aggs) <- profile$aggregate
  cbind(rows,aggs)
}

df <- get.df2("test1")
