clear all;
close all;

%% -----------  Question (a)-(b) -----------

y1 = oscillator1(pi/6,0);
y2 = oscillator1(pi/4,pi/6);
y3 = oscillator1(pi/3,2*pi/3);
subplot3(1,y1,y2,y3)

%% -----------  Question (c)-(d) -----------

y4 = oscillator2(pi/6);
y5 = oscillator2(pi/4);
y6 = oscillator2(pi/3);
subplot3(2,y4,y5,y6)

%% Function oscillator cos(w0n+theta0)
function [y] = oscillator1(w0,theta0)
    a = zeros(1,100);
    y = zeros(1,98);
    x = zeros(1,100);
    alpha = 2*cos(w0);
    b =1;
    x(1) = cos(-w0+theta0);               %x(-1)
    x(2) = cos(theta0)-alpha*x(1);        %x(0)
    a(1) = x(1);
    a(2) = x(2)+alpha*x(2);
    
    for n = 3:100
        a(n)=x(n)+alpha*a(n-1)-b*a(n-2);
    end
    
    y(1:98)=a(3:100);
end

%% Function oscillator sin(w0n)
function [y] = oscillator2(w0)

    alpha = 2*cos(w0);
    b =1;
    y = zeros(1,98);    
    y(1) = sin(w0);
    y(2) = sin(2*w0);
    
    for n = 3:100
        y(n) = alpha*y(n-1)-b*y(n-2);
    end
    
end

%% Function plot the oscillators
function subplot3(i,y1,y2,y3)
    
    % Subplot
    figure(i)
    subplot(3,1,1)
    stem(y1)
    subplot(3,1,2)
    stem(y2)
    subplot(3,1,3)
    stem(y3)
end