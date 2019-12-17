clear variables;
close all;

%% Question 1
N = 32;
K = 256;
x=randn(K,N);

% A white Gaussian noise process with mean zero and variance 0.25
mu = 0;
sigma = 0.5;

% White Gaussian Noise
noise = sigma*x + mu;

% Calculate the mean, variance, autocorrelation and autocorrelation
noise_mean = mean(noise);
noise_variance = var(noise);
noise_cov = cov(noise);



