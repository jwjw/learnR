


# First model

Soon after you launch RStudio, you can start typing in the R console. Here we can start our first example.

First, we generate 100 random numbers that follow a standard normal distribution, and assign the values to symbol `x`.


```r
> x <- rnorm(100)
```


Next, we generate another 100 random numbers, each of which is 2 times the corresponding number in `x` plus a small noise.


```r
> y <- 2 * x + rnorm(100) * 0.1
```


Then we can run a linear regression between `x` and `y`.


```r
> lm(y ~ x)
```

```

Call:
lm(formula = y ~ x)

Coefficients:
(Intercept)            x  
    0.00153      1.99247  
```

