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


compare_two_models_loo <- function(model1,
                                   model2,
                                   names = c("m1", "m2"),
                                   n_per_group,
                                   J){

  sim_data <-  simulate_normal_group(
    n_per_group = n_per_group,
    J = J)

  m1_samples <- model1$sample(data = sim_data, refresh = 0L)

  m1_loo <- m1_samples$loo()
  # targets::tar_load(some_groups)
  m2_samples <- model2$sample(data = sim_data, refresh=0L)
  m2_loo <- m2_samples$loo()
  # simulate_normal(50)
  loolist <- list(m1_loo, m2_loo) |> purrr::set_names(names)
  as.data.frame(loo::loo_compare(loolist)) |>
    tibble::rownames_to_column(var = "model")
}

# tar_load(no_groups)
# tar_load(some_groups)
# compare_two_models_loo(no_groups, some_groups, data = simulate_normal_group(15, 1))


# last step -- figure out how to run this in targets over many sample sizes to compare.
