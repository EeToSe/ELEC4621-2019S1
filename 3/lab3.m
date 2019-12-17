%% 
clc;
clear all;
close all;

%% lab3 q1 a
z = 1;
DC_gian_H_z_tf=1+0.33*z^(-1)-0.162*z^(-2)+0.33*z^(-1)+z^(-4);
%% lab3 q1 b 
c_numerator_H_z_tf = [1 0.33 -0.162 0.33 1];
numerator_H_z_tf = poly2str(c_numerator_H_z_tf,'z')
zeros_H_z_tf = roots(c_numerator_H_z_tf)
%% lab 3 q1 c d e
w = linspace(-pi,pi,1001);
[phase_response_1,magnitude_response_1,DC_gain_tf_1] = phase_and_magnitude_response(zeros_H_z_tf(1),zeros_H_z_tf(2),zeros_H_z_tf(3),zeros_H_z_tf(4),w);
[phase_response_2,magnitude_response_2,DC_gain_tf_2] = phase_and_magnitude_response(1/zeros_H_z_tf(1),1/zeros_H_z_tf(2),zeros_H_z_tf(3),zeros_H_z_tf(4),w);
[phase_response_3,magnitude_response_3,DC_gain_tf_3] = phase_and_magnitude_response(zeros_H_z_tf(1),zeros_H_z_tf(2),1/zeros_H_z_tf(3),1/zeros_H_z_tf(4),w);
[phase_response_4,magnitude_response_4,DC_gain_tf_4] = phase_and_magnitude_response(1/zeros_H_z_tf(1),1/zeros_H_z_tf(2),1/zeros_H_z_tf(3),1/zeros_H_z_tf(4),w);

figure(1)
plot(w,phase_response_1)
hold on
plot(w,phase_response_2)
hold on
plot(w,phase_response_3)
hold on
plot(w,phase_response_4)

figure(2)
plot(w,magnitude_response_1)
hold on
plot(w,magnitude_response_2)
hold on
plot(w,magnitude_response_3)
hold on
plot(w,magnitude_response_4)

%% lab3 q2 c d
n_1 = -100:100;
n_2 = -1000:1000;
n_3 = -10000:10000;
[h_n_1] = sinc_function(n_1);
[h_n_2] = sinc_function(n_2);
[h_n_3] = sinc_function(n_3);
[H_w_1] = dtft(h_n_1,w);
[H_w_2] = dtft(h_n_2,w);
[H_w_3] = dtft(h_n_3,w);
figure(4)
subplot(3,1,1)
plot(w,abs(H_w_1),'r')
subplot(3,1,2)
plot(w,abs(H_w_2),'b')
subplot(3,1,3)
plot(w,abs(H_w_3),'g')
legend('n=201','n=2001','n=20001')
figure(5)
subplot(3,1,1)
plot(w,angle(H_w_1),'r')
subplot(3,1,2)
plot(w,angle(H_w_2),'b')
subplot(3,1,3)
plot(w,angle(H_w_3),'g')
legend('n=201','n=2001','n=20001')
%% lab3 q2 e
N = 201;
Hanning_window_201 = hanning_window(N);
h_new_201 = h_n_1.*Hanning_window_201;
[H_w_1_new] = dtft(h_new_201,w);
figure(6)
plot(w,abs(H_w_1),'r')
hold on
plot(w,abs(H_w_1_new),'b')
legend('n=201','n=201 with window')


%%
function [phase_response,magnitude_response,DC_gain_tf] = phase_and_magnitude_response(z1,z2,z3,z4,w)
    z = exp(j*w);
    DC_gain_tf = (1-z1)*(1-z2)*(1-z3)*(1-z4);
    for i = 1:length(z)
    tf(i) = ((z(i)-z1)*(z(i)-z2)*(z(i)-z3)*(z(i)-z4)/z(i)^4)/DC_gain_tf;
    end
    phase_response = angle(tf);
    magnitude_response = abs(tf);
end

%% DTFT with coefficient matrix
function [X_k] = dtft(x_n,w)
    n = [-(length(x_n)-1)/2:(length(x_n)-1)/2];
    e = exp(-i* n'* w);
    X_k = x_n * e;
end
%% sinc function
function [y] = sinc_function(n)
    for i = 1:length(n);
        y(i) = sin(pi*n(i)/6)/(pi*n(i)/6);
    end
        % lim sinc(0)=1
        y((length(n)-1)/2+1) = 1;
end
%% hanning window function
function [y] = hanning_window(N)
    for i = [-(N-1)/2:(N-1)/2];
        y(i+(N-1)/2+1) = 0.5*(1+cos(2*pi*i/(N-1)));
    end
end
