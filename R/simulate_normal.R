simulate_normal <- function(n) {
  y <- rnorm(n, mean = 0, sd = 1)
  list(y = y, n = n)
}
