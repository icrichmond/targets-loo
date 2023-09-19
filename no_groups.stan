data {
  int n;
  vector[n] y;
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model{
  y ~ normal(mu, sigma);
  mu ~ std_normal();
  sigma ~ exponential(1);
}
generated quantities {
  vector[n] log_lik;
  for (i in 1:n){
    log_lik[i] = normal_lpdf(y[i] | mu, sigma);
  }
}
