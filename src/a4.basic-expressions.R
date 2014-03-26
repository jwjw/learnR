# Basic expressions

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



## Output expression


