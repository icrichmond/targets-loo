# simulate_normal(50)
# no_groups$sample(data = simulate_normal(50))$loo()
test_data <-  simulate_normal_group(100, 20)


library(ggplot2)
as.data.frame(test_data[c("y")]) |>
  ggplot(aes(y = y)) + geom_histogram()

as.data.frame(test_data[c("y", "j")]) |>
  ggplot(aes(y = y, x = j)) +
  geom_point()

library(targets)
tar_load(no_groups)
tar_load(some_groups)
source("functions.R")

compare_two_models_loo(no_groups, some_groups,
                       data = simulate_normal_group(n_per_group = 5, 10))

no_groups_samples <- no_groups$sample(data = test_data, refresh=0L)
no_groups_samples$summary()
loo_nogrp <- no_groups_samples$loo()
# targets::tar_load(some_groups)
some_grps_samples <- some_groups$sample(data = test_data, refresh=0L)
loo_grps <- some_grps_samples$loo()
# simulate_normal(50)
loo::loo_compare(list(none = loo_nogrp, some = loo_grps))



tar_load("demo_groups_draws_some_groups")
tar_load("demo_groups_data")

library(dplyr)
yrep_mat <- demo_groups_draws_some_groups |>
  select(starts_with("yrep")) |>
  head(200) |>
  as.matrix()

?bayesplot::ppc_dens_overlay

bayesplot::ppc_dens_overlay(demo_groups_data$y, yrep_mat)

## making values dataframe

library(tidyverse)
tar_load(increase_group_reps)
increase_group_reps |>
  filter(model == "no_groups") |>
  ggplot(aes(x = n_per_group, y = elpd_diff)) + geom_point() +
  facet_wrap(~J)

