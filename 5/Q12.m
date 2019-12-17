clear
close all
clc

%% Q1
% N samples obtained from a white Gaussian noise process
% Each sample have K different realisations

K = 256;
N = 32;
X=zeros(N,K);

% White Gaussian Noise with mean 0 and variance 0.25
mean = 0;
mu = 0.5;

for i=1:32
    X(i,:) = mu*randn(1,K) + mean;
end

% Calculate the mean
mean = zeros(N,1);

for i=1:32
    mean(i) = sum(X(i,:))/K;
end

% Calculate the variance
variance = zeros(N,1);

for i=1:32
    for n=1:256
        variance(i) = variance(i)+(X(i,n)-mean(i))^2;
    end
    variance(i) = variance(i)/K;
end

% Calculate the correlation
correlation = zeros(N,N);

for i=1:32
    for K=1:32
        correlation(i,K) = X(i,:)*X(K,:)'/256;
    end
end

% Calculate the covariance
covariance = correlation-mean*mean';

[X,Y] = meshgrid(1:32,1:32);

figure
subplot(211)
surf(X,Y,correlation)
title('Correlation')
subplot(212)
surf(X,Y,covariance)
title('Covariance')

%% Question2
% This time  single realisation of 512 samples
x=0.5*randn(1,512);

mean=sum(x)/512;

variance=0;
for n=1:512
    variance=variance+(x(n)-mean)^2;
end
variance=variance/512;

correlation=zeros(33,33);

for m=1:33
    if m==1
        correlation(1,m)=x*x'/512;
    else
        correlation(1,m)=x*[x(m:end) zeros(1,m-1)]'/(512-m+1);
    end
end

for m=2:33
    correlation(m,:)=[flip(correlation(1,2:m)) correlation(1,1:end-m+1)];
end

covariance=correlation-mean^2*ones(33);

[X,Y]=meshgrid(1:33,1:33);

figure
subplot(211)
surf(X,Y,correlation)
title('Correlation')
subplot(212)
surf(X,Y,covariance)
title('Covariance')
