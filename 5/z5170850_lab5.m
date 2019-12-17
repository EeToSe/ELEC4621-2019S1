clear all;
close all;
%%
%question 1

x=randn(256,32);
x=x*0.5;
x_mean = mean(x);
x_var = var(x);
x_cov=cov(x);
x_atc2=autocorrelation(x,32);
figure()
plot(x_mean);
hold on
plot(x_var);
hold on
figure()
hold on
surf(linspace(1,32,32),linspace(-32,32,65),x_atc2);
% figure()
% imagesc(x_atc2);
figure()
hold on
surf(x_cov);

%%
%question 2
x_2=reshape(x,[16,512]);
x_2_mean=mean(x_2);
x_2_var=var(x_2);
x_2_cov=cov(x_2);
x_2_atc2=autocorrelation(x_2,32);

figure()
plot(x_2_mean);
hold on
plot(x_2_var);
hold on
figure()
hold on;
imagesc(x_2_atc2);
figure()
% hold on
% surf(x_2_cov);
imagesc(x_2_cov);
%%
%question 3
i=1;
x_t=x';
while(i<=256)
x_w(i,:)=DTFT_F(x_t(:,i),100);
i=i+1;
end
x_w_sq=abs(x_w).^2;

i=1;
while(i<=32)
x_atc_w(i,:)=DTFT_F(x_atc2(:,i),100);
i=i+1;
end
figure()
abs(x_atc_w)
plot(linspace(-pi,pi,100),x_w_sq./max(x_w_sq))
hold on
plot(linspace(-pi,pi,100),abs(x_atc_w),'o')

%%
%question 4




%%
%question 5
w=linspace(-pi,pi,100);
z=exp(1j*w);
h_w=((z.^2)-1.5.*z+1)./(z.^2-0.4*z+0.4);



%%
function x_atc=autocorrelation(x_n,m)
[row,colum]=size(x_n);
i=1;
j=1;
x_n=extend(x_n,m);
sum=0;
p_m=-m;
while(p_m<=m)
    j=1;
    i=1;
while(j<=colum)
    i=1;
while(i<=row)
    sum=sum+x_n(i,m+p_m+1)*x_n(i,j+m);
    i=i+1;
end
    x_atc(m+p_m+1,j)=1/(2*row+1)*sum;
    sum=0;
    j=j+1;
end
    p_m=p_m+1;
end

end


function x_extend=extend(x_n,L)
[row,colum]=size(x_n);
x_extend=[zeros(row,L) x_n zeros(row,L)]
end

function [h_w]=DTFT_F(h_n,K)
w=linspace(-pi,pi,K);
N=linspace(1,length(h_n),length(h_n));
co_e=exp(-1j.*w'*N);
h_w=co_e*h_n;
h_w=h_w';
end



function x_atc=autocorrelation1(x_n,m)
[row,colum]=size(x_n);
x_n=extend(x_n,m);
i=1;
j=1;
sum=0;
while(j<=colum)
    i=1;
while(i<=row)
    sum=x_n(i,1)*x_n(i,j)
    i=i+1;
end
    r(j,1)=1/row*sum;
    j=j+1
end
x_atc=[flip(r);r(2:end)]
end

