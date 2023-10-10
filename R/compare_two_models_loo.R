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
