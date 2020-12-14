data {
  int<lower=1> D;
  int<lower=0> N;
  int<lower=1> J;
  int<lower=0,upper=1> y[N];
  int<lower=1,upper=J> id[N];
  row_vector[D] X[N];
}
parameters {
  vector[D] beta;
  vector[J] b;
  real alpha;
}

model {
  b ~ normal(0,2);
  alpha ~ normal(0,10);
  beta[1] ~ normal(0,10);
  beta[2] ~ normal(-1,10);
  beta[3] ~ normal(-1,10);
  beta[4] ~ normal(-1,10);
  {
    vector[N] logit_theta;
    for (n in 1:N)
      logit_theta[n] = b[id[n]] + alpha + X[n] * beta;
    y ~ bernoulli_logit(logit_theta);
  }
}
