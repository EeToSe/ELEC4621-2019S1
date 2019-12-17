%% Lab 1 Q2 Solutions
% Written by Antoni Dimitriadis.

%%
clear variables;
close all;

%% 2a
h_a = [-0.0625,0.25,0.625,0.25,-0.0625];
x = [1,2,3,4,5,6,7,6,5,4,3,2,1];
y1 = zeros(1,length(x)+length(h_a)-1);

for n = 1:length(x)
    y1(n:n+length(h_a)-1) = y1(n:n+length(h_a)-1) + x(n)*h_a;
end

plot(x);
hold on;
plot(y1);
title("Input based perspective");

%% 2b
y2 = zeros(length(x)+length(h_a)-1,1);
x = [0,0,0,0,x,0,0,0,0];

for n = 1:length(y2)
   y2(n) = sum(x(n:n+length(h_a)-1).* flip(h_a));
end

figure;
plot(x(length(h_a):end-length(h_a)+1));
hold on;
plot(y2);
title("Convolution via the dot product");

%% 2c
theta = linspace(-pi,pi,1000);

H_a = zeros(length(theta),1);

for l = 1:length(theta)
    for n = 1:length(h_a)
        H_a(l) = H_a(l) + h_a(n)*exp((-1j)*(n-1)*theta(l));
    end
end

figure;
plot(theta,abs(H_a));
title("Magnitude spectrum of H_a");
xlabel("Normalised Frequency (radians)");

figure;
plot(theta,angle(H_a));
title("Phase spectrum of H_a");
xlabel("Normalised Frequency (radians)");

% THE FILTER IS LINEAR PHASE (since it is symmetric)

%% 2d

h_b = [-0.1,0.6,0.6,-0.1];
x = [1,2,3,4,5,6,7,6,5,4,3,2,1];
y3 = zeros(1,length(x)+length(h_b)-1);

for n = 1:length(x)
    y3(n:n+length(h_b)-1) = y3(n:n+length(h_b)-1) + x(n)*h_b;
end

figure;
plot(x);
hold on;
plot(y3);
title("Input x and output y3");

H_b = zeros(length(theta),1);

for l = 1:length(theta)
    for n = 1:length(h_b)
        H_b(l) = H_b(l) + h_b(n)*exp((-1j)*(n-1)*theta(l));
    end
end

figure;
subplot(2,1,1);
plot(theta,abs(H_b));
title("Magnitude spectrum of H_b");
xlabel("Normalised Frequency (radians)");

subplot(2,1,2);
plot(theta,angle(H_b));
title("Phase spectrum of H_b");
xlabel("Normalised Frequency (radians)");

% FILTER IS LINEAR PHASE (can tell since it is symmetric)

%% 2e

h_c = [0.2,0.5,0.2,0.1];
x = [1,2,3,4,5,6,7,6,5,4,3,2,1];
y4 = zeros(1,length(x)+length(h_c)-1);

for n = 1:length(x)
    y4(n:n+length(h_c)-1) = y4(n:n+length(h_c)-1) + x(n)*h_c;
end

figure;
plot(x);
hold on;
plot(y4);
title("y4");

H_c = zeros(length(theta),1);

for l = 1:length(theta)
    for n = 1:length(h_c)
        H_c(l) = H_c(l) + h_c(n)*exp((-1j)*(n-1)*theta(l));
    end
end

figure;
subplot(2,1,1);
plot(theta,abs(H_c));
title("Magnitude spectrum of H_c");
xlabel("Normalised Frequency (radians)");

subplot(2,1,2);
plot(theta,angle(H_c));
title("Phase spectrum of H_c");
xlabel("Normalised Frequency (radians)");

% FILTER IS NOT LINEAR PHASE