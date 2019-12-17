clear all;
close all;
%% -----------  Question (a) -----------

% According to z-transform transfer fucnion, we can get
% y1[n] = x[n] - ax[n-1]
% y2[n] = x[n] + ay[n-1]

% a = 0.5
[y1,y2] = imp(20,0.5,2);
plots(y1,y2,1);

% a= -0.5
[y1,y2] = imp(20,-0.5,2);
plots(y1,y2,2);


%% -----------  Question (b) -----------
x = [1 2 3 4 5 6 7 6 5 4 3 2 1];

% a = 0.5
[w1] = filter(x,0.5);
figure(3)
plot([0 x],'g');
hold on;
plot(w1);

% a = 0.5
[w2] = filter(x,-0.5);
figure(4)
plot([0 x],'g');
hold on;
plot(w2);


%% -----------  Question (c) -----------
[hw1,gw1] = mag(0.5);
[hw2,gw2] = mag(-0.5);

%% Impulse response function
% x - Discrete input sequences
% a - The coefficient of z-transform tf.
% b - sequence point of the impulse
function [y1,y2] = imp(N,a,b)
    
    % Initialize the input and output sequences
    x = zeros(1,N);
    x(b) = 1;
    y1 = zeros(1,N);
    y2 = zeros(1,N);
    for n = b:N
        y1(n) = x(n)-a*x(n-1);
        y2(n) = x(n)+a*y2(n-1);
    end
end


%% Filters Function
function [w] = filter(x,a)
    N = length(x);
    
    % The number of the output sequence should be one more than the input
    y = zeros(1,N+1);
    xp = [0 x];
    
    % Filter first with H(z)
    for n = 2:N+1
        y(n) = xp(n)-a*xp(n-1);
    end
    
    % Apply the second filter
    M = 4*N;
    yp = zeros(1,M);
    % substitute yp to y
    yp(2:length(y)+1) = y;
    w = zeros(1,M);   
    for m = 2:M
        w(m) = yp(m)+a*w(m-1);
    end    
    
end

%% Magnitude response
function [hw,gw] = mag(a)
    theta = -pi:pi/360:pi;
    z = exp(1i*theta);
    hw = 1-a*z.^(-1);
    gw = 1./(1-a*z.^(-1));

    figure
    subplot(2,1,1);
    plot(theta,abs(hw),theta,abs(gw));
    subplot(2,1,2);
    plot(theta,angle(hw),theta,angle(gw));
end

%% Plot fucntion
function plots(y1,y2,i)
    figure(i)
    subplot(2,1,1);
    stem(y1);
    title('Impulse response h[n]');
    subplot(2,1,2);
    stem(y2);
    title('Impulse response g[n]');
end











