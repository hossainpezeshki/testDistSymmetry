require (quantmod)
require (xts)

getTicker <- function (sym, auto.assign=FALSE,
                       freq="monthly",
                       from="1999-03-10", to="2015-06-04") {
  fileName <- paste (sym, '_', freq, '_', from, '_', to, ".RData", sep='')
  if (length (grep (fileName, dir())) == 0) {
    stock_data <- getSymbols (sym, src="yahoo", from=from, to=to, auto.assign=FALSE)
    if (freq == "monthly") {
      stock_data <- to.monthly (stock_data)
    } else {
      stock_data <- to.daily (stock_data)
    }
    save (stock_data, file=fileName)
  } else {
    load (fileName)
  }
  
  adj <- Ad (stock_data)
  result <- list()
  result$freq = freq
  result$time.index = index (adj)
  
  
  result$price <- coredata (adj)
  m = dim (result$price)[1]
  result$m <- m
  result$Rt <- result$price[2:m,1]/result$price[1:(m-1),1] - 1
  result$rt <- log (1 + result$Rt)
  result$rt.xts <- function () { 
    xts (x=result$rt, order.by=result$time.index[2:result$m])
  }
  result$Rt.xts <- function () {
    xts (x=result$Rt, order.by=result$time.index[2:result$m])
  }
  result$ticker <- sym
  
  result$call <- match.call()
  class (result) <- "ReturnsType"
  
  if (auto.assign) {
    assign (sym, result, envir=parent.env (environment()))
  } else {
    result
  }
}
