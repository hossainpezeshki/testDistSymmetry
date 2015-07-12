require (gtools)

lu <- defmacro (j, k, expr={
  c((k*(j-1)+1):(k*j))
})


symmetry.statfunc <- function (y) {
  mu <- mean (y);
  md <- median (y);
  tmp <- quantile (x=y, probs=c(1/4, 3/4));
  s <- (tmp[2] - tmp[1])/ (2 * 0.6745);  # Indication of scale
  val <- abs (mu - md) / s;
  names (val) <- NULL
  val;
}

symmetryTest <- function (x, B = 1000) {
  stopifnot (class(x) == "numeric")
  result <- list();
  result$statistic <- symmetry.statfunc (x);
  result$mu <- mean(x);
  result$md <- median(x);
  tmp <- quantile (x=x, probs=c(1/4, 3/4));
  result$scale  <- (tmp[2] - tmp[1])/ (2 * 0.6745);  # Indication of scale
  names (result$scale) <- NULL
  
  Hnull = c(x, (2*median(x)-x))
  
  # Note the use of balanced as opposed to ordinary bootstrap,
  # together with the use of antithetic variates.
  # Page 493 of Hinkley et al. exercise 21
  halfB = as.integer (B/2);
  direct.val = rep (0.0, halfB)
  anti.val = rep (0.0, halfB)
  
  BI <- rep (c(1:length(Hnull)), halfB);
  II <- sample (x=BI, size=length(BI), replace=FALSE)
  
  for (i in 1:halfB) {
    idx = lu (i, length(Hnull))
    jdx = II[idx]
    direct.val[i] = symmetry.statfunc(Hnull[jdx])
    
    jdx = (length(Hnull)+1) - jdx
    anti.val[i] = symmetry.statfunc (Hnull[jdx])
  }
  
  val = c (direct.val, anti.val)
  result$p.val <- (1 + sum (val >= result$statistic))/(1+B);
 
  result
}
