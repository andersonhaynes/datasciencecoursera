makeCacheMatrix <- function(x = numeric()) {
  val <- NULL # value set to !NA
  set <- function(y) {
    x <<- y
    val <<- NULL # value set to !NA
  }
  get <- function() x
  setsolve <- function(cacheSolve) val <<- cacheSolve
  getsolve <- function() val
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
}
