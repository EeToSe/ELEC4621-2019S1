clear variables;
close all;
load('batcalls.mat');

%% question1
% Load the file batcalls
x=data_taegyp;
x1=data_ppip;
% Autocorrelation function
Rx=autocorraltion(x);
Rx1=autocorraltion(x1);

% Plot
figure()
subplot(2,1,1);
auto_plot(Rx1);
title('Autocorrelation');

% DTFT of autocorrelation, i.e. PSD
[h_w1,w1]=DTFT_F(Rx1,100);
subplot(2,1,2);
plot(w1,abs(h_w1));
title('PSD');

% Plot
figure()
subplot(2,1,1);
auto_plot(Rx);
title('Autocorrelation');

% DTFT of autocorrelation, i.e. PSD
[h_w,w]=DTFT_F(Rx,100);
subplot(2,1,2);
plot(w,abs(h_w));
title('PSD');

%%
a=co_LP(Rx,100);
a1=co_LP(Rx1,100);


%%
w_n=randn(200,1);
w_n1=randn(200,1);
w_a=filt(w_n,a);
w_a1=filt(w_n1,a1);
Ra=autocorraltion(w_a');
Ra1=autocorraltion(w_a1');

figure()
subplot(2,1,1);
auto_plot(Ra1)
title('Filtered autocorrelation')

[h_w_a1,w_a1]=DTFT_F(Ra1,100);
subplot(2,1,2);
plot(w_a1,abs(h_w_a1));
title('Filtered PSD')

figure()
subplot(2,1,1);
auto_plot(Ra)
title('Filtered autocorrelation')

[h_w_a,w_a]=DTFT_F(Ra,100);
subplot(2,1,2);
plot(w_a,abs(h_w_a));
title('Filtered PSD')

sound(w_n,44.1*1000)

sound(Ra,44.1*1000)


%%




%%
%function
function [Rx]=autocorraltion(x)
    N=length(x); 
    n=0;
    m=-N+1;
     while m<N
         sum=0;
         n=max(0,m);
         while n<=N-1-abs(m)+max(0,m)
             sum=x(n+1,1)*x(n-m+1,1)+sum;
             n=n+1;
         end
         Rx(m+N,1)=sum/(N-abs(m));
         m=m+1;
     end
end

function [h_w,w]=DTFT_F(h_n,K)
w=linspace(-pi,pi,K);
N=linspace(1,length(h_n),length(h_n));
co_e=exp(-1j.*w'*N);
h_w=co_e*h_n;
end


function a=co_LP(Tx,k)
   x=Tx(2:end-1,:);
   N=length(x);
   N=(N-1)/2;
   i=1;
   while i<=N
       Rx(:,i)=[flip(x(N+1:N+i,:));x(i+N+1:end,:)];
       i=i+1;
   end
   Rx(:,i)=flip(Rx(:,1));
   r=Tx(N+3:end);
   a=Rx(1:k,1:k)^(-1)*r(1:k);
end

function y=filt(x,h)

y=zeros(1,length(x)+length(h)-1);
n_h=1;
n_x=1;
sum=0;
while(n_x<length(x)+length(h)+1)%length
    n_h=1;
    sum=0;
    if n_x>length(x)
       n_h=n_x-length(x)+1;
    end
while(n_h<length(h)+1 && n_x-n_h+1>0)%length
sum=x(n_x-n_h+1)*h(n_h);
y(n_x)=sum+y(n_x);
n_h=n_h+1;
end
n_x=n_x+1;
end
end

function auto_plot(Rx)
plot(linspace(-(length(Rx)-1)/2,(length(Rx)-1)/2,length(Rx)),Rx);
end