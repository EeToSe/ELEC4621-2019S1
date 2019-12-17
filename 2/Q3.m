clear all;
close all;

%% -----------  Question (a)&(b)-----------

% Initialize variables according to the given conditions
r1 = exp(-1/8);
r2 = 0.9;
r3 = r2;
theta2 = 0.6*pi;
theta3 = 0.85*pi;

% plot the impulse response
h1 = tap(r1,r2,r3,theta2,theta3);
response(h1)
% Use the same function as Lab 1 


%% -----------  Question (c)&(d) -----------

r1r = 1/r1;
r2r = 1/r2;
r3r = 1/r3;

% replaceing r1 by 1/r1
h2 = tap(r1r,r2,r3,theta2,theta3);
response(h2);

% replaceing r2 by 1/r2
h3 = tap(r1,r2r,r3,theta2,theta3);
response(h3);

% replaceing r3 by 1/r3
h4 = tap(r1,r2,r3r,theta2,theta3);
response(h4);

h5 = tap(r1r,r2r,r3,theta2,theta3);
response(h5);

h6 = tap(r1r,r2,r3r,theta2,theta3);
response(h6);

h7 = tap(r1,r2r,r3r,theta2,theta3);
response(h7);

h8 = tap(r1r,r2r,r3r,theta2,theta3);
response(h8);

%% -----------  Question (e) -----------

% The filter coefficients are rounded to 1 decimal place
h1N1 = round(h1,1);
response(h1N1);

% The filter coefficients are rounded to 2 decimal places
h1N2 = round(h1,2);
response(h1N2);

h1N3 = round(h1,3);
response(h1N3);

h1N4 = round(h1,0);
response(h1N4);

%% Function: find the filter taps
function [h] = tap(r1,r2,r3,theta2,theta3)
    
% Complex-valued zeros
    R1 = r1;
    R2 = r2*exp(1i*theta2);
    R3 = r2*exp(-1i*theta2);
    R4 = r3*exp(1i*theta3);
    R5 = r3*exp(-1i*theta3);

    % Calculate the coefficients of the polynomial with the roots above
    v = [R1;R2;R3;R4;R5];
    h = poly(v);
end

%% Function: Plot the magnitude and phase responses of the filter
function response(h)
    theta = linspace(-pi,pi,1000);
    H = zeros(length(theta),1);
    for n = 1:length(theta)
        for m = 1:length(h)
            H(n) = H(n)+ h(m)*exp((-1j)*(m-1)*theta(n));
        end
    end

    figure;
    subplot(3,1,1)
    stem(h);
    title('Impulse response');
    subplot(3,1,2)
    plot(theta,abs(H)/max(abs(H)));
    title('Magnitude response');
    subplot(3,1,3)
    plot(theta,angle(H));
    title('Phase response');
end