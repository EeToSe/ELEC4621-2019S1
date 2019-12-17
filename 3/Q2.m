%% (c)&(d)
w = linspace(-pi,pi,1000);

L1 = 100;
L2 = 500;
L3 = 1000;
[h1] = sinc_discrete(L1);
[h2] = sinc_discrete(L2);
[h3] = sinc_discrete(L3);

[H1] = dtft(h1,w);
[H2] = dtft(h2,w);
[H3] = dtft(h3,w);

% Magnitude response
figure(1)
plot(w,abs(H1)/max(abs(H1)),'r')
hold on
plot(w,abs(H2)/max(abs(H2)),'b')
hold on
plot(w,abs(H3)/max(abs(H3)),'g')
legend('L1=100','L2=500','L3=1000');

% Phase response
figure(2)
subplot(3,1,1);
plot(w,angle(H1),'r');
title('L1=100');
subplot(3,1,2);
plot(w,angle(H2),'b');
title('L2=500');
subplot(3,1,3);
plot(w,angle(H3),'g');
title('L3=1000');

%% (e)
han1 = hanning_window(L1)

%% Sinc function
function [y] = sinc_discrete(L)
    n = -L:L;
    for i = 1:length(n)
        y(i) = sin(pi*n(i)/6)/(pi*n(i)/6);
    end
        % sinc(0)=1
        y((length(n)-1)/2+1) = 1;
end

%% DTFT with coefficient matrix
function [H] = dtft(h,w)
    n = [-(length(h)-1)/2:(length(h)-1)/2];
    e = exp(-1i* n'* w);
    H = h * e;
end

%% Hanning window
function [han] = hanning_window(L)
    n = -L:L
    N = length(n)
    for n = -L:L
        han(n) = 0.5*(1+cos(pi*n/(L-1)));
    end
end