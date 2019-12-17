%% Lab 2 Q1 Solutions
% Written by Antoni Dimitriadis.

%% 1a

% Observe that the z transform of the sequence [a^i] for i in (0,...,infty)
% is given by 1/(1-az^(-1))

clear variables;
close all;

H = @(z,a) 1-a*z.^-1;
h = @(a,n) 1*(n==1) - a*(n==2);
G = @(z,a) 1./(1-a*z.^(-1));
g = @(a,n) a.^n;

figure;
stem(h(0.5,1:10));
hold on;
stem(g(0.5,1:10));
title("h[n] and g[n] for a = 1/2");

figure;
stem(h(-0.5,1:10));
hold on;
stem(g(-0.5,1:10));
title("h[n] and g[n] for a = -1/2");

%% 1b

fc = 6e3;
Tc= 1/fc;
f = 2000;
nper = 5;
tmax = nper/f;
tc = 0:Tc:5/f - Tc;
x = cos(2*pi*f*tc);
a = 1/2;

h_1 = h(a,1:2);
y = zeros(1,length(x)+length(h_1)-1);

for n = 1:length(x)
    y(n:n+length(h_1)-1) = y(n:n+length(h_1)-1) + x(n)*h_1;
end

figure;
stem(y);
title("y[n]");

% Apply G(z) to y using the difference equation, w[n] = y[n] + a*w[n-1]

w = zeros(length(x), 1);
w(1) = y(1);

for n = 2:length(x)
    w(n) = y(n) + a*w(n-1);
end

figure;
stem(x);
hold on;
stem(w);
title("Plots of x[n] and w[n]");

% The relationship is that x[n] is equal to w[n], obviously expected since
% G and H are inverse.

%% 1c

% To get the magnitude response, simply substitute z as e^(j*theta) and take
% absolute value

theta = linspace(-pi,pi,1000);

H_mag = abs(H(exp(1j*theta),a));
G_mag = abs(G(exp(1j*theta),a));

figure;
plot(H_mag);
hold on;
plot(G_mag);
title("Magnitude response of H & G with a=1/2");
legend('|H(\omega)|','|G(\omega)|');

