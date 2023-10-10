simulate_normal <- function(n) {
  y <- rnorm(n, mean = 0, sd = 1)
  list(y = y, n = n)
}

simulate_normal_group <- function(n_per_group, J){

  alpha <- rnorm(J, mean = 0, sd = 3)

  j <- rep(1:J, each = n_per_group)

  y <- rnorm(n_per_group*J, mean = alpha[j], sd = .5)
  list(
    n = J * n_per_group,
    J = J,
    y = y,
    j = j
  )
}
