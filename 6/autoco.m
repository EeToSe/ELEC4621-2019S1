function [R,M]=autoco(X)
    N=length(X);
    R=zeros(1,2*N-1);
    temp=1;
    M=(-N+1:N-1);
    for m=(-N+1):(N-1)
        i=abs(m);
        A=X(i+1:N);
        B=X(1:N-i);
        R(temp)=A*B';
        temp=temp+1;
        m=m+1;
    end
end
