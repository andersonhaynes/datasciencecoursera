cacheSolve <- function(x, ...) {
  val <- x$getsolve () #sets value (vector) obtained through the subset
  if(!is.null(val)) { #provided value is not NA 
    message("get cached data") #message is returned
    return(val) # value is returned
  }
  data <- x$get ()  #sets value obtained through the subset
<<<<<<< HEAD
  val <- solve(data, ...) # sets value using
  x[[setsolve]](val)
  val
}
