clear
close all
clc

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
title('correlation')
subplot(212)
surf(X,Y,covariance)
title('covariance')

