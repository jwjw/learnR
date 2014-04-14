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
int calc1() {
  int a = 5; // initialization
  int a1 (5); // constructor initialization
  // int a2 {5}; // uniform initialization
  int b = a*2+1+a1;
  int c = a+b*3;
  return a+(b-c)*(a-b);
}

