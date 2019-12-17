clear variables;
close all;
load('batcalls.mat');

%%
%question1
x=data_ppip;
Rx=autocorraltion(x);
figure()
subplot(2,1,1);
auto_plot(Rx);
title('Autocorrelation');
[h_w w]=DTFT_F(Rx,100);
subplot(2,1,2);
plot(w,abs(h_w));
title('PSD')

%%
a=co_LP(Rx,100);


%%
w_n=randn(200,1);
w_a=filt(w_n,a);
Ra=autocorraltion(w_a');
figure()
auto_plot(Ra)

[h_w_a w_a]=DTFT_F(Ra,100);
figure()
plot(w_a,abs(h_w_a));

sound(w_n,44.1*1000)

sound(Ra,44.1*1000)


%%
x_m=data_pkuh_pcap;
x_o=data_pcap;
x_o_t=data_pkuh;

x_o_t_a=autocorraltion(x_o_t);
[x_o_t_a_w w5]=DTFT_F(x_o_t_a,100);

x_c=coss_autocorr(x_o,x_m);
x_a_m=autocorraltion(x_m);
x_a_o=autocorraltion(x_o);

[x_c_psd w1]=DTFT_F(x_c,100);
[x_a_m_psd w2]=DTFT_F(x_a_m,100);
[x_a_o_psd w3]=DTFT_F(x_a_o,100);
figure()
auto_plot(x_c);

figure()
subplot(3,1,1)
plot(w1,abs(x_c_psd));
subplot(3,1,2)
plot(w2,abs(x_a_m_psd))
subplot(3,1,3)
plot(w3,abs(x_a_o_psd))


%%
a_w=co_weiner(x_a_o,x_c,100);

x_filter_out=filt(a_w,x_m);
x_filter_out_a=autocorraltion(x_filter_out');
[x_filter_out_w w4]=DTFT_F(x_filter_out_a,100);

figure()
subplot(2,1,1)
plot(w5,abs(x_o_t_a_w))
subplot(2,1,2)
plot(w4,abs(x_filter_out_w))

figure
subplot(3,1,1)
plot(x_o_t)
subplot(3,1,2)
plot(x_filter_out)

subplot(3,1,3)
plot(x_m)



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


function [Rx]=coss_autocorr(x,y)
    N=length(x); 
    n=0;
    m=-N+1;
     while m<N
         sum=0;
         n=max(0,m);
         while n<=N-1-abs(m)+max(0,m)
             sum=x(n+1,1)*y(n-m+1,1)+sum;
             n=n+1;
         end
         Rx(m+N,1)=sum/(N-abs(m));
         m=m+1;
     end
end




function [h_w w]=DTFT_F(h_n,K)
w=linspace(-pi,pi,K);
N=linspace(1,length(h_n),length(h_n));
co_e=exp(-1j.*w'*N);
h_w=co_e*h_n;
end


function a=co_weiner(Tx,Ty,k)
   N1=length(Ty);
   N1=(N1-1)/2;

   N=length(Tx);
   N=(N-1)/2;
   i=1;
   while i<=N
       Rx(:,i)=[flip(Tx(N+1:N+i,:));Tx(1+N+1:end-i,:)];
       i=i+1;
   end
   Rx(:,i)=flip(Rx(:,1));
   r=Ty(N1+1:N1+1+N);
   a=Rx(1:k,1:k)^(-1)*r(1:k);
end






function a=co_LP(Tx,k)
   x=Tx(2:end-1,:);
   N=length(x);
   N=(N-1)/2;
   i=1;
   while i<=N
       Rx(:,i)=[flip(x(N+1:N+i,:));x(1+N+1:end-i,:)];
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