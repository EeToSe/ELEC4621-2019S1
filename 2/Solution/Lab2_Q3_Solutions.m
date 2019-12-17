%% Lab 2 Q3 Solutions
% Written by Antoni Dimitriadis.

%% Q3a

clear variables;
close all;

% Using polynomial multiplication, aided by Matlab's conv() function

R1 = exp(-1/8);
R2 = 0.9;
R3 = 0.9;
theta2 = 0.6*pi;
theta3 = 0.85*pi;

a = [1,-R1];
b = [1,-2*R2*cos(theta2),R2^2];
c = [1,-2*R3*cos(theta3),R3^2];

h = conv(a,conv(b,c));

%% Q3b

% Evaluate H(z) for z = e^jw, then plot magnitude and phase

w = linspace(-pi, pi, 1000);
v = exp(1j*w);

H = @(z1,z2,z3,z4,z5) (v-z1).*(v-z2).*(v-z3).*(v-z4).*(v-z5)./v.^5;

figure;
subplot(2,1,1);
plot(w,abs(H(R1,R2*exp(1j*theta2),R2*exp(-1j*theta2),R3*exp(1j*theta3),R3*exp(-1j*theta3))));
title("Magnitude spectrum of H(r1,r2,r3)");
subplot(2,1,2);
plot(w, angle(H(R1,R2*exp(1j*theta2),R2*exp(-1j*theta2),R3*exp(1j*theta3),R3*exp(-1j*theta3))));
title("Phase spectrum of H(r1,r2,r3)");

%% Q3c

% Select permutations of r1,r2,r3 to reciprocate, and rerun code from above

figure;
subplot(4,2,1);
plot(w,abs(H(1/R1,R2*exp(1j*theta2),R2*exp(-1j*theta2),R3*exp(1j*theta3),R3*exp(-1j*theta3))));
title("Magnitude spectrum of H(1/r1,r2,r3)");

subplot(4,2,2);
plot(w,abs(H(R1,1/R2*exp(1j*theta2),1/R2*exp(-1j*theta2),R3*exp(1j*theta3),R3*exp(-1j*theta3))));
title("Magnitude spectrum of H(r1,1/r2,r3)");

subplot(4,2,3);
plot(w,abs(H(R1,R2*exp(1j*theta2),R2*exp(-1j*theta2),1/R3*exp(1j*theta3),1/R3*exp(-1j*theta3))));
title("Magnitude spectrum of H(r1,r2,1/r3)");

subplot(4,2,4);
plot(w,abs(H(1/R1,1/R2*exp(1j*theta2),1/R2*exp(-1j*theta2),R3*exp(1j*theta3),R3*exp(-1j*theta3))));
title("Magnitude spectrum of H(1/r1,1/r2,r3)");

subplot(4,2,5);
plot(w,abs(H(R1,1/R2*exp(1j*theta2),1/R2*exp(-1j*theta2),1/R3*exp(1j*theta3),1/R3*exp(-1j*theta3))));
title("Magnitude spectrum of H(r1,1/r2,1/r3)");

subplot(4,2,6);
plot(w,abs(H(1/R1,R2*exp(1j*theta2),R2*exp(-1j*theta2),1/R3*exp(1j*theta3),1/R3*exp(-1j*theta3))));
title("Magnitude spectrum of H(1/r1,r2,1/r3)");

subplot(4,2,7);
plot(w,abs(H(1/R1,1/R2*exp(1j*theta2),1/R2*exp(-1j*theta2),1/R3*exp(1j*theta3),1/R3*exp(-1j*theta3))));
title("Magnitude spectrum of H(1/r1,1/r2,1/r3)");

figure;
subplot(4,2,1);
plot(w, angle(H(1/R1,R2*exp(1j*theta2),R2*exp(-1j*theta2),R3*exp(1j*theta3),R3*exp(-1j*theta3))));
title("Phase spectrum of H(1/r1,r2,r3)");

subplot(4,2,2);
plot(w, angle(H(R1,1/R2*exp(1j*theta2),1/R2*exp(-1j*theta2),R3*exp(1j*theta3),R3*exp(-1j*theta3))));
title("Phase spectrum of H(r1,1/r2,r3)");

subplot(4,2,3);
plot(w, angle(H(R1,R2*exp(1j*theta2),R2*exp(-1j*theta2),1/R3*exp(1j*theta3),1/R3*exp(-1j*theta3))));
title("Phase spectrum of H(r1,r2,1/r3)");

subplot(4,2,4);
plot(w, angle(H(1/R1,1/R2*exp(1j*theta2),1/R2*exp(-1j*theta2),R3*exp(1j*theta3),R3*exp(-1j*theta3))));
title("Phase spectrum of H(1/r1,1/r2,r3)");

subplot(4,2,5);
plot(w, angle(H(R1,1/R2*exp(1j*theta2),1/R2*exp(-1j*theta2),1/R3*exp(1j*theta3),1/R3*exp(-1j*theta3))));
title("Phase spectrum of H(r1,1/r2,1/r3)");

subplot(4,2,6);
plot(w, angle(H(1/R1,R2*exp(1j*theta2),R2*exp(-1j*theta2),1/R3*exp(1j*theta3),1/R3*exp(-1j*theta3))));
title("Phase spectrum of H(1/r1,r2,1/r3)");

subplot(4,2,7);
plot(w, angle(H(1/R1,1/R2*exp(1j*theta2),1/R2*exp(-1j*theta2),1/R3*exp(1j*theta3),1/R3*exp(-1j*theta3))));
title("Phase spectrum of H(1/r1,1/r2,1/r3)");

% They all have larger net change in phase (since part b is the min phase
% implementation)

%% Q2d

a = [1,-1/R1];
b = [1,-2*R2*cos(theta2),R2^2];
c = [1,-2*R3*cos(theta3),R3^2];
h1 = conv(a,conv(b,c));

a = [1,-R1];
b = [1,-2*(1/R2)*cos(theta2),(1/R2)^2];
c = [1,-2*R3*cos(theta3),R3^2];
h2 = conv(a,conv(b,c));

a = [1,-R1];
b = [1,-2*R2*cos(theta2),R2^2];
c = [1,-2*(1/R3)*cos(theta3),(1/R3)^2];
h3 = conv(a,conv(b,c));

a = [1,-1/R1];
b = [1,-2*(1/R2)*cos(theta2),(1/R2)^2];
c = [1,-2*R3*cos(theta3),R3^2];
h4 = conv(a,conv(b,c));

a = [1,-R1];
b = [1,-2*(1/R2)*cos(theta2),(1/R2)^2];
c = [1,-2*(1/R3)*cos(theta3),(1/R3)^2];
h5 = conv(a,conv(b,c));

a = [1,-1/R1];
b = [1,-2*R2*cos(theta2),R2^2];
c = [1,-2*(1/R3)*cos(theta3),(1/R3)^2];
h6 = conv(a,conv(b,c));

a = [1,-1/R1];
b = [1,-2*(1/R2)*cos(theta2),(1/R2)^2];
c = [1,-2*(1/R3)*cos(theta3),(1/R3)^2];
h7 = conv(a,conv(b,c));

figure;
subplot(4,2,1);
stem(h);
title("Impulse response h(r1,r2,r3)");
subplot(4,2,2);
stem(h1);
title("Impulse response h(1/r1,r2,r3)");
subplot(4,2,3);
stem(h2);
title("Impulse response h(r1,1/r2,r3)");
subplot(4,2,4);
stem(h3);
title("Impulse response h(r1,r2,1/r3)");
subplot(4,2,5);
stem(h4);
title("Impulse response h(1/r1,1/r2,r3)");
subplot(4,2,6);
stem(h5);
title("Impulse response h(r1,1/r2,1/r3)");
subplot(4,2,7);
stem(h6);
title("Impulse response h(1/r1,r2,1/r3)");
subplot(4,2,8);
stem(h7);
title("Impulse response h(1/r1,1/r2,1/r3)");

% h has the least energy of all the filters. Also has energy concentrated
% at the beginning of the impulse response.

%% Q2e

quanth = zeros(9, 6);
quantz = zeros(9, 5);

figure;
plot(v, 'k');
for n = 0:8
    quanth(n+1,:) = round(h, 8-n);
    quantz(n+1,:) = roots(quanth(n+1,:));
    hold on;
    plot(quantz(n+1,:), 'x');
end
legend("Unit circle","N=8","N=7","N=6","N=5","N=4", "N=3", "N=2", "N=1", "N=0");

transf = zeros(size(quantz,1),1000);
for k = 1:size(quantz,1)
    transf(k,:)=(quanth(k,1)*v.^5+quanth(k,2)*v.^4+quanth(k,3)*v.^3+quanth(k,4)*v.^2+quanth(k,5)*v+quanth(k,6))./v.^5;
end

figure;
plot(w,abs(H(R1,R2*exp(1j*theta2),R2*exp(-1j*theta2),R3*exp(1j*theta3),R3*exp(-1j*theta3))));
for k = 1:size(quantz,1)
    hold on;
    plot(w,abs(transf(k,:)));
end
title("Quantization of coefficients, magnitude spectrum");
legend("Default","N=8","N=7","N=6","N=5","N=4", "N=3", "N=2", "N=1", "N=0");

figure;
plot(w,angle(H(R1,R2*exp(1j*theta2),R2*exp(-1j*theta2),R3*exp(1j*theta3),R3*exp(-1j*theta3))));
for k = 1:size(quantz,1)
    hold on;
    plot(w,angle(transf(k,:)));
end
title("Quantization of coefficients, phase spectrum");
legend("Default","N=8","N=7","N=6","N=5","N=4", "N=3", "N=2", "N=1", "N=0");

