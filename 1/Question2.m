clear all;
close all;

% Provided the impulse response h[n]
h1 = [-0.0625 0.25 0.625 0.25 -0.0625];
h2 = [-0.1 0.6 0.6 -0.1];
h3 = [0.2 0.5 0.2 0.1];
% ------------------Question 2(a)-(b)-----------------

% Provided the sequence as below
x1 = [1 2 3 4 5 6 7 6 5 4 3 2 1];
figure(1)
plot(conv1(h1,x1))
hold on;
plot(conv2(h1,x1))
hold on;
plot(conv(h1,x1))

% ------------------Question 2(d)-(e)-----------------
wn = -pi:2*pi/1024:pi-2*pi/1024;
H1 = evaluate(h1,wn);
figure(2)
subplot(3,1,1)
plot(conv(h1,x1))
subplot(3,1,2)
plot(wn,abs(H1));
title('Magnitude Response');
subplot(3,1,3)
plot(wn,angle(H1))
title('Phase Response');

H2 = evaluate(h2,wn);
figure(3)
subplot(3,1,1)
plot(conv(h2,x1))
subplot(3,1,2)
plot(wn,abs(H2));
title('Magnitude Response');
subplot(3,1,3)
plot(wn,angle(H2))
title('Phase Response');

H3 = evaluate(h3,wn);
figure(4)
subplot(3,1,1)
plot(conv(h3,x1))
subplot(3,1,2)
plot(wn,abs(H3));
title('Magnitude Response');
subplot(3,1,3)
plot(wn,angle(H3))
title('Phase Response');
%% Input-based perspective convolution
function y1 = conv1(h,x)
    
    % Create a large enough output vector y, setting all entries to 0
    N = length(x);
    M = length(h);
    len_y = N+M-1;
    y1 = zeros(1,len_y);

    % According to the convolution equation
    for i = 1:N
       for j = 1:M
          y1(i+j-1) = y1(i+j-1)+x(i)*h(j);
       end
    end
end

%% Output-based perspective convolution
function y2 = conv2(h,x)

    N = length(x);
    M = length(h);
    len_y = N+M-1;
    y2 = zeros(1,len_y);
    x_padding = [zeros(1,M-1) x zeros(1,M-1)];
    hr = fliplr(h);
    for n = 1:len_y
        y2(n) = x_padding(n:n+M-1)*hr';
    end
end

%% Inspect the magnitude and phase of h(w)
function response = evaluate(h,w)
    hn = [0:length(h)-1]
    En = exp(-i* w'* hn);
    response = En*h.';
end