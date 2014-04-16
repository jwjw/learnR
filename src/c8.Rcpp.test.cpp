#include <cstdio>
#include <Rcpp.h>

using namespace Rcpp;

// Below is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp
// function (or via the Source button on the editor toolbar)

// For more on using Rcpp click the Help button on the editor toolbar

// [[Rcpp::export]]
int timesTwo(int x) {
   return x * 2;
}

// [[Rcpp::export]]
void printSome() {
  printf("Hello, world!\n");
}

// [[Rcpp::export]]
int calc1(int i) {
  int a = i; // initialization
  int a1 (i); // constructor initialization
  // int a2 {5}; // uniform initialization
  int b = a*2+1+a1;
  int c = a+b*3;
  return a+(b-c)*(a-b);
}

// [[Rcpp::export]]
NumericVector calc1s(int n) {
  NumericVector x(n);
  for(int i = 1; i <= n; i++) {
    x[i-1] = calc1(i);
  }
  return x;
}

// [[Rcpp::export]]
NumericVector calc2(int n) {
  NumericVector x = rnorm(n);
  NumericVector y = rnorm(n);
  for(int i = 0; i < n; i++) {
    x[i] = x[i]*y[i]+1;
  }
  return x;
}

// [[Rcpp::export]]
NumericVector rate(NumericVector x) {
  int n = x.size();
  NumericVector y(n-1);
  for(int i=1;i<n;i++) {
    y[i-1] = (x[i]-x[i-1])/x[i-1];
  }
  return y;
}

// R-API
// [[Rcpp::export]]
int signC(int x) {
  if (x > 0) {
    return 1;
  } else if (x == 0) {
    return 0;
  } else {
    return -1;
  }
}

// [[Rcpp::export]]
double sumC(NumericVector x) {
  int n = x.size();
  double total = 0;
  for(int i = 0; i < n; ++i) {
    total += x[i];
  }
  return total;
}

// [[Rcpp::export]]
double meanC(NumericVector x) {
  int n = x.size();
  double total = 0;

  for(int i = 0; i < n; ++i) {
    total += x[i] / n;
  }
  return total;
}

// [[Rcpp::export]]
NumericVector pdistC(double x, NumericVector ys) {
  int n = ys.size();
  NumericVector out(n);

  for(int i = 0; i < n; ++i) {
    out[i] = sqrt(pow(ys[i] - x, 2.0));
  }
  return out;
}

// [[Rcpp::export]]
NumericVector rowSumsC(NumericMatrix x) {
  int nrow = x.nrow(), ncol = x.ncol();
  NumericVector out(nrow);

  for (int i = 0; i < nrow; i++) {
    double total = 0;
    for (int j = 0; j < ncol; j++) {
      total += x(i, j);
    }
    out[i] = total;
  }
  return out;
}

// [[Rcpp::export]]
double mpe(List mod) {
  if (!mod.inherits("lm")) stop("Input must be a linear model");

  NumericVector resid = as<NumericVector>(mod["residuals"]);
  NumericVector fitted = as<NumericVector>(mod["fitted.values"]);

  int n = resid.size();
  double err = 0;
  for(int i = 0; i < n; ++i) {
    err += resid[i] / (fitted[i] + resid[i]);
  }
  return err / n;
}

// [[Rcpp::export]]
NumericVector rsq(List mod) {
  if (!mod.inherits("lm")) stop("Input must be a linear model");
  Function summary("summary");
  List s = summary(mod);
  return s["r.squared"];
}

// [[Rcpp::export]]
List newList(int n) {
  List out = List::create(_["title"]="Hello");
  out["x"] = n + rnorm(n);
  return out;
}

// [[Rcpp::export]]
List model1(List mod) {
  if (!mod.inherits("lm")) stop("Input must be a linear model");
  Function summary("summary");
  Function modifyList("modifyList");
  List s = summary(mod);
  List out = modifyList(mod,s);
  out["title"] = "Title";
  return out;
}
