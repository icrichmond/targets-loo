data {
  int n;
  vector[n] y;
  int J;
  // group id vector
  array[n] int<lower=0,upper=J> j;
}
parameters {
  real mu;
  real<lower=0> sigma;
  vector[J] z;
  real<lower=0> sigma_g;
}
transformed parameters{
  vector[J] alpha = z*sigma_g;
}
model{
  y ~ normal(mu + alpha[j], sigma);
  mu ~ std_normal();
  sigma ~ exponential(1);
  sigma_g ~ exponential(1);
  z ~ std_normal();
}
generated quantities {
  vector[n] log_lik;
  vector[n] avg = mu + alpha[j];
  vector[n] yrep;
  for (i in 1:n){
    log_lik[i] = normal_lpdf(y[i] | avg[i], sigma);
    yrep[i] = normal_rng(avg[i], sigma);
  }
}
