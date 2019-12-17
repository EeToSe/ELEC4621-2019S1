clc;
clear all;
%% -----------(a)-------------
% From question we know:
% H(z)=1+0.33*z^(-1)-0.162*z^(-2)-0.3312*z^(-3)-0.1296*z(-4)
h1 = [1,0.33,-0.162,-0.3312,-0.1296];
DC_gain = sum(h1);

%% -----------(b)-------------
zeros1 = roots(h1);

%% -----------(c)-------------
zeros2 = zeros1;    
zeros2(1) = 1/zeros1(1);
h2 = poly(zeros2);

zeros3 = zeros1;
zeros3(2) = 1/conj(zeros1(2));
h3 = poly(zeros3);

zeros4 = zeros1;
zeros4(3) = 1/conj(zeros1(3));
h4 = poly(zeros4);

zeros5 = zeros1;
zeros5(4) = 1/zeros1(4);
h5 = poly(zeros5);

zeros6 = zeros1;
zeros6(1) = 1/zeros1(1);
zeros6(2) = 1/conj(zeros1(2));
h6 = poly(zeros6);

zeros7 = zeros1;
zeros7(1) = 1/zeros1(1);
zeros7(3) = 1/conj(zeros1(3));
h7 = poly(zeros7);

zeros8 = zeros1;
zeros8(1) = 1/zeros1(1);
zeros8(4) = 1/zeros1(4);
h8 = poly(zeros8);

zeros9 = zeros1;
zeros9(2) = 1/conj(zeros1(2));
zeros9(3) = 1/conj(zeros1(3));
h9 = poly(zeros9);

zeros10 = zeros1;
zeros10(2) = 1/conj(zeros1(2));
zeros10(4) = 1/zeros1(4);
h10 = poly(zeros9);

zeros11 = zeros1;
zeros11(3) = 1/conj(zeros1(3));
zeros11(4) = 1/zeros1(4);
h11 = poly(zeros9);

zeros12 = zeros1;
zeros12(1) = 1/zeros1(1);
zeros12(2) = 1/conj(zeros1(2));
zeros12(3) = 1/conj(zeros1(3));
h12 = poly(zeros9);

zeros13 = zeros1;
zeros13(1) = 1/zeros1(1);
zeros13(2) = 1/conj(zeros1(2));
zeros13(4) = 1/zeros1(4);
h13 = poly(zeros9);

zeros14 = zeros1;
zeros14(1) = 1/zeros1(1);
zeros14(3) = 1/conj(zeros1(3));
zeros14(4) = 1/zeros1(4);
h14 = poly(zeros9);

zeros15 = zeros1;
zeros15(2) = 1/conj(zeros1(2));
zeros15(3) = 1/conj(zeros1(3));
zeros15(4) = 1/zeros1(4);
h15 = poly(zeros9);

zeros16 = zeros1;
zeros16(1) = 1/zeros1(1);
zeros16(2) = 1/conj(zeros1(2));
zeros16(3) = 1/conj(zeros1(3));
zeros16(4) = 1/zeros1(4);
h16 = poly(zeros9);

theta = linspace(-pi,pi,1000);
[mag1,phase1] = response(h1,theta);
[mag2,phase2] = response(h2,theta);
[mag3,phase3] = response(h3,theta);
[mag4,phase4] = response(h4,theta);
[mag5,phase5] = response(h5,theta);
[mag6,phase6] = response(h6,theta);
[mag7,phase7] = response(h7,theta);
[mag8,phase8] = response(h8,theta);
[mag9,phase9] = response(h9,theta);
[mag10,phase10] = response(h10,theta);
[mag11,phase11] = response(h11,theta);
[mag12,phase12] = response(h12,theta);
[mag13,phase13] = response(h13,theta);
[mag14,phase14] = response(h14,theta);
[mag15,phase15] = response(h15,theta);
[mag16,phase16] = response(h16,theta);

figure(1);
plot(theta,mag1,theta,mag2,theta,mag3,theta,mag4,theta,mag5,theta,mag6,theta,mag7,theta,mag8,theta,mag9,theta,mag10,theta,mag11,theta,mag12,theta,mag13,theta,mag14,theta,mag15,theta,mag16);
grid on;
xlabel('theta');
ylabel('Magnitude Response');
legend('h1','h2','h3','h4','h5','h6','h7','h8','h9','h10','h11','h12','h13','h14','h15','h16');

figure(2);
title('Phase Response');
subplot(4,2,1)
plot(theta,phase1);
subplot(4,2,2)
plot(theta,phase2);
subplot(4,2,3)
plot(theta,phase3);
subplot(4,2,4)
plot(theta,phase4);
subplot(4,2,5)
plot(theta,phase5);
subplot(4,2,6)
plot(theta,phase6);
subplot(4,2,7)
plot(theta,phase7);
subplot(4,2,8)
plot(theta,phase8);

figure(3);
title('Phase Response');
subplot(4,2,1)
plot(theta,phase9);
subplot(4,2,2)
plot(theta,phase10);
subplot(4,2,3)
plot(theta,phase11);
subplot(4,2,4)
plot(theta,phase12);
subplot(4,2,5)
plot(theta,phase13);
subplot(4,2,6)
plot(theta,phase14);
subplot(4,2,7)
plot(theta,phase15);
subplot(4,2,8)
plot(theta,phase16);

%% -----------(d)-------------
figure(3);
theta = theta(1:1000);
plot(theta,diff(phase1)/(pi/1000),theta,diff(phase2)/(pi/1000),theta,diff(phase3)/(pi/1000),theta,diff(phase4)/(pi/1000),theta,diff(phase5)/(pi/1000),theta,diff(phase6)/(pi/1000),theta,diff(phase7)/(pi/1000),theta,diff(phase8)/(pi/1000));
grid on;
xlabel('theta');
ylabel('Phase Response');
legend('h1','h2','h3','h4','h5','h6','h7','h8');
% The minimum phase system h1 has the smallest group delay.

%% Function: Calculate the magnitude and phase responses of the filter
function [mag,phase] = response(h,theta)  
    H = zeros(length(theta),1);
    for n = 1:length(theta)
        for m = 1:length(h)
            H(n) = H(n)+ h(m)*exp((-1j)*(m-1)*theta(n));
        end
    end
    mag = abs(H)/max(abs(H));
    phase = angle(H)/pi*360;
end