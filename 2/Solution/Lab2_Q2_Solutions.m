%% Lab 2 Q2 Solutions
% Written by Antoni Dimitriadis.

%% Q2a
% See attached LaTeX document for answers

clear variables;
close all;
%% Q2b

w = pi/6; t = 0;
alpha = 2*cos(w); beta = 1;
x = zeros(1,101); x(1) = cos(w-t); x(2) = -cos(2*w-t);
y = zeros(1, length(x) + 2);
for i = 3:length(y)
    y(i) = x(i-2) + alpha*y(i-1) - beta*y(i-2);
end
y(1:2) = [];
y1 = y;

w = pi/4; t = pi/6;
alpha = 2*cos(w); beta = 1;
x = zeros(1,101); x(1) = cos(w-t); x(2) = -cos(2*w-t);
y = zeros(1, length(x) + 2);
for i = 3:length(y)
    y(i) = x(i-2) + alpha*y(i-1) - beta*y(i-2);
end
y(1:2) = [];
y2 = y;

w = pi/3; t = 2*pi/3; 
alpha = 2*cos(w); beta = 1;
x = zeros(1,101); x(1) = cos(w-t); x(2) = -cos(2*w-t);
y = zeros(1, length(x) + 2);
for i = 3:length(y)
    y(i) = x(i-2) + alpha*y(i-1) - beta*y(i-2);
end
y(1:2) = [];
y3 = y;

samps = -1:length(x) - 2;
figure;
subplot(3,1,1);
stem(samps,y1);
title("\omega_0 = \pi/6, \theta_0 = 0");
axis([samps(1) samps(end) -1.5 1.5]);
subplot(3,1,2);
stem(samps,y2);
title("\omega_0 = \pi/4, \theta_0 = \pi/6");
axis([samps(1) samps(end) -1.5 1.5]);
subplot(3,1,3);
stem(samps,y3);
title("\omega_0 = \pi/3, \theta_0 = 2\pi/3");
axis([samps(1) samps(end) -1.5 1.5]);

%% Q2c
% We simply set t = pi/2 to get the sin wave required.