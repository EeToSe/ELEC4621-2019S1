clear variables;
close all;

%% Lab 4 report
% Written by Sheng Li z5170850

%% Analysis of Bat Echolocation Calls
% The bat echolocation calls are recorded and saved as wav files. 
% Each file contains the data vector and the sampling frequency.
% The bat calls are all ultrasonic, they are sample at 750ksamples/s.


%% 1. Calculate and plot the magnitude Fourier spectrum of the signal

% Choose a wav file loaded into Matlab

[x,Fs] = audioread('pcap00001_4.wav');
w = linspace(-pi,pi,1000);

% Calculate the magnitude Fourier spectrum with DTFT
n1 = 0:length(x)-1;
X = exp(-1i*w'*n1)*x;

% Plot the magnitude Fourier spectrum
figure
plot(w,abs(X));
xlabel('Frequency,w')
ylabel('Magnitude');
title('Magnitude Fourier Spectrum');

%% 2. Bandwidth and the minimum required sampling frequency

DB = 20*log(abs(X));
figure
plot(DB)
title('Magnitude Fourier Spectrum in DB')
bandwidth = 1.217*750000/pi;
Fsmin = bandwidth*2;

%% 3. Play the signal with a different sampling frequency
% Using fs1 = 44.1 kHz, play the sound

fs1 = 44100;
sound(x,fs1);

%% 4. The time varying spectrum of the signals

% The length of the window
N = 50;

% Calculate how many blocks we have
L = ceil(length(x)/N);

% Calculate the short-time fourier transform
X_stft = stft(x,N,L,w);

% Plot the time varying spectrum of the signal
[Xaxis,Yaxis]=meshgrid(1:N:L*N,w);
figure
mesh(Xaxis',Yaxis',abs(X_stft))
xlabel('Time index')
ylabel('Frequency,w')
zlabel('Magnitude')
title('Time varying spectrum')


%% 5. Resample the signal to the minimum sampling frequency achievable
% The signals are to be resampled to the minimum sampling frequency achievable

% Use the self-written function
xre = myresamp(x,Fsmin,Fs);

n3 = 0:length(xre)-1;
Xre = xre*exp(-1i*n3.'*w);

% Plot the magnitude Fourier spectrum
figure
plot(w,abs(Xre));
xlabel('Frequency,w')
ylabel('Magnitude');
title('Magnitude Fourier Spectrum');

%% 6. PLot the STFT of the resampled signal
Lre = ceil(length(xre)/N);
Xre_stft = stft(xre,N,Lre,w);

% Plot the time varying spectrum of the signal
[Xaxis,Yaxis] = meshgrid(1:N:Lre*N,w);
figure
mesh(Xaxis',Yaxis',abs(Xre_stft))
xlabel('Time index')
ylabel('Frequency,w')
zlabel('Magnitude')
title('Reampled Time varying spectrum')

%% 7. Play the resampled signal using fs1 = 44.1kHz
sound(xre,fs1);
