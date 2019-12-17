%% Lab 3 Q2 Solutions
% Written by Antoni Dimitriadis.

%% Q2a
% The filter is linear and time invariant, but not causal (since the impulse
% response has non zero values with n < 0)

%% Q2b
% The transfer function in frequency domain is H(w) = 6*rect(3/pi*w)
% This can be computed from the z transform tables and the time scaling
% property of the DTFT.

%% Q2c

clear variables
close all

w = linspace(-pi,pi,10000);
rect = @(x) (abs(x) < 1/2);
H = 6*rect(3/pi*w);

figure;
plot(w,abs(H));
axis([-pi pi 0 8]);
title("Magnitude response of ideal transfer function");
xlabel("Normalised angular frequency (rads)");

%% Q2d

% (i)
L = 50;
n = -L:L;
FT = exp(-1j*w'*n);
h1 = sinc(n/6);
H1 = FT*h1';

figure;
plot(w,abs(H));
hold on;
plot(w,abs(H1));

L = 200;
n = -L:L;
FT = exp(-1j*w'*n);
h2 = sinc(n/6);
H2 = FT*h2';

hold on;
plot(w,abs(H2));
axis([-pi pi 0 8]);
title("Magnitude responses of H");
xlabel("Normalised angular frequency (rads)");
legend("Ideal","L=50","L=200");

% There are a lot of ripples in the pass and stop band, and the transition
% band widens. It is clear from comparing the L=50 and L=200 lines that 
% larger L gives less ripples and a narrower transition band.

% (ii)
figure;
plot(w,angle(H));
hold on;
plot(w,angle(H1));
hold on;
plot(w,angle(H2));
title("Phase responses of H");
xlabel("Normalised angular frequency (rads)");
legend("Ideal","L=50","L=200");

% The filter is 0 phase as it is symmetric (ignoring the errors due to
% matlab precision). All the filters have the same phase plot.

% (iii)

% In order for it to be realisable it must be causal and so we require a
% shift of L samples in time domain, this would result in a group delay of
% L samples.


%% Q2e
% We plot the result for L = 100

L = 100;
n = -L:L;
FT = exp(-1j*w'*n);
h3 = sinc(n/6);
H3 = FT*h3';
h4 = h3.*hanning(length(n))';
H4 = FT*h4';

figure;
plot(w,abs(H3));
hold on;
plot(w,abs(H4));
axis([-pi pi 0 8]);
title("Magnitude responses of H");
xlabel("Normalised angular frequency (rads)");
legend("Rectangular Window","Hann window");

% You can very visibly see the trade-off in using a hanning window. The
% ripples are almost completely gone (as the hanning window has very low
% side lobes in the frequency domain), but the transition band has widened
% which is a result of the wider central lobe of the hanning window's
% frequency response when compared to the sinc.