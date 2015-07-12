## Overview
We were prompted by [an online article](http://www.bloombergview.com/articles/2015-06-25/fear-factor-drives-the-stock-market-s-highs-and-lows)
to explore the presence of asymmetry and negative skewness is the
probability distributions of the log-returns of stocks and stock indices.
Since the use of (scaled) third central moment as a test of symmetry requires existence of moments of at
least order three, it is not appropriate for distributions with heavy tails. Accordingly
we propose a different test.


## R code
We use two helper functions that we wrote for this work:
 * symmetryTest.R is standalone R code.
 * getTicker.R  is our wrapper for getSymbols{quantmod}.

## Notice 
Copyright (C) 2015 by Dr. Hossain Pezeshki June 19th, 2015

[My LinkedIn profile](https://ca.linkedin.com/pub/hossain-pezeshki/0/778/395)

Permission is granted for anyone to copy, use, or modify these
programs and accompanying documents for purposes of research or
education, provided this copyright notice is retained, and note is
made of any changes that have been made.
 
These programs and documents are distributed without any warranty,
express or implied.  As the programs were written for research
purposes only, they have not been tested to the degree that would be
advisable in any important application.  All use of these programs is
entirely at the user's own risk.
