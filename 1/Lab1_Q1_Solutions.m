%% Lab 1 Q1 Solutions
% Written by Antoni Dimitriadis.

%% 1a
% f_min = 2*2000 = 4000Hz

clear variables;
close all;

%% 1b: Continuous signal
Tc= 1e-6;
fc = 1/Tc;
f = 2000;
nper = 5;
tmax = nper/f;
tc = 0:Tc:5/f - Tc;
x = cos(2*pi*f*tc);

plot(tc, x);

%% 1c: Sampling at 1.5*f_min
fs1 = 1.5*2*f;
Ts1 = 1/fs1;
ts1 = 0:Ts1:5/f - Ts1;
y = cos(2*pi*f*ts1);
hold on;
stem(ts1, y);
title("Sampling of x at f = 1.5*f_{min} = 6000Hz")

% There are 3 samples per period.
% Minimum frequency cosine that can fit those points is 2000Hz.

%% 1d: non-Nyquist sampling
fs2 = 0.75*2*f;
Ts2 = 1/fs2;
ts2 = 0:Ts2:5/f - Ts2;
z = cos(2*pi*f*ts2);
figure;
plot(tc, x);
hold on;
stem(ts2, z);

x_oth = cos(2*pi*(fs2-f)*tc);
hold on;
plot(tc,x_oth);

title("Sampling of x at f = 0.75*f_{min} = 3000Hz")

% There are 1.5 samples per period.
% Minimum frequency cosine that can fit those points is (fs2-f) = 1000Hz.

%% 1e: DTFTs of signal, sampled at different frequencies
% Please note step size is not 1Hz as the computation is too slow when
% using loops to compute the spectrum.

N = length(x);
num_freq = 1001;
freqc = linspace(-12000,12000,num_freq);
Xc = zeros(num_freq,1);

for k = 1:num_freq
    Xc(k)=0;
    for n=1:N
        Xc(k) = Xc(k) + x(n)*exp((-1j)*(n-1)*2*pi*(k-501)/num_freq*(max(freqc)-min(freqc))/fc);
    end
end

figure;
plot(freqc, abs(Xc));
title("Magnitude spectrum of x, sampled at fc = 10^6 Hz");
xlabel("Frequency (Hz)");
    
N = length(y);
num_freq = 1001;
freqs1 = linspace(-12000,12000,num_freq);
Xs1 = zeros(num_freq,1);

for k = 1:num_freq
    Xs1(k)=0;
    for n=1:N
        Xs1(k) = Xs1(k) + y(n)*exp((-1j)*(n-1)*2*pi*(k-501)/num_freq*(max(freqs1)-min(freqs1))/fs1);
    end
end
figure;
plot(freqs1, abs(Xs1));

title("Magnitude spectrum of x, sampled at 6000Hz");
xlabel("Frequency (Hz)");

N = length(z);
num_freq = 1001;
freqs2 = linspace(-12000,12000,num_freq);
Xs2 = zeros(num_freq,1);

for k = 1:num_freq
    Xs2(k)=0;
    for n=1:N
        Xs2(k) = Xs2(k) + z(n)*exp((-1j)*(n-1)*2*pi*(k-501)/num_freq*(max(freqs2)-min(freqs2))/fs2);
    end
end
figure;
plot(freqs1, abs(Xs2));

title("Magnitude spectrum of x, sampled at 3000Hz");
xlabel("Frequency (Hz)");