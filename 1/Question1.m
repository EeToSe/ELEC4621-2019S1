clear all;
close all;

% Provided that the frequency of the signal is 2000Hz
f = 2000;

%% ------------------Question 1(a)-----------------

% the minimum sampling frequency for this signal
fs_min = 2*f;
fprintf('According to Nyquist–Shannon sampling theorem, the minimum sampling frequency: \n');
fprintf('%d Hz \n\n',fs_min);

%% ------------------Question 1(b)-(d)---------------

% Take different sampling frequencies
f1 = 1e6; f2 = 1.5*fs_min; f3 = 0.75*fs_min;
figure(1);
sampling1(f1,f);
hold on;
sampling2(f2,f);

figure(2);
sampling1(f1,f);
hold on;
sampling2(f3,f);

%% ------------------Question 1(e)-----------------

f_vec = -12e3:12e3;
Xf1 = dft(f1,f);
Xf2 = dft(f2,f);
Xf3 = dft(f3,f);
figure(3);
subplot(3,1,1);
plot(f_vec,abs(Xf1)/max(abs(Xf1)));
title('Spectra of the original and two sampled signals');
subplot(3,1,2);
plot(f_vec,abs(Xf2)/max(abs(Xf2)));
subplot(3,1,3);
plot(f_vec,abs(Xf3)/max(abs(Xf3)));

%% Fuction: Simulate a "continuous" signal using plot
function x1 = sampling1(fs,f)
    Ts = 1/fs;
    t = 0:Ts:5/f;
    x1 = cos(2*pi*f*t);
    plot(t, x1);
end

%% Fuction: STEM on top of the "continuous" 
function x2 = sampling2(fs,f)
    Ts = 1/fs;
    t = 0:Ts:5/f;
    x2 = cos(2*pi*f*t);
    stem(t,x2);
    fprintf('How many samples per period of the signal do we get: \n');
    fprintf('%d samples \n',fs/f);
end

function Xf = dft(fs,f)
    Ts = 1/fs;
    t = (0:Ts:5/f).';
    xt = cos(2*pi*f*t);
    f_vec = -12e3:12e3;
    F = exp(1i*2*pi*t*f_vec);
    Xf = F'*cos(2*pi*f*t);
end


