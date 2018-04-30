%% HW20                         Yunlong Wang
%                               Z1807787
clear all
close all
clc
%% random
L=7;
I0=randn(1,100);
for n=1:L
    if I0(n)>0
        I(n)=1;
    else
        I(n)=-1;
    end
end
e=0.1*randn(1,L);
%% r
r(1)=I(1)+e(1);
r(2)=I(2)+0.5*I(1)+e(2);
for n=3:6
    r(n)=I(n)+0.5*I(n-1)+0.4*I(n-2)+e(n);
end
%% J0
I012=[-1 -1 -1 -1 1 1 1 1; -1 -1 1 1 -1 -1 1 1;-1 1 -1 1 -1 1 -1 1];
for n=1:8
    J0(n)=(r(1)-I012(1,n))^2+(r(2)-I012(2,n)-0.5*I012(1,n))^2+(r(3)-I012(3,n)-0.5*I012(2,n)-0.4*I012(1,n))^2;
end
%% compare 00-0 01-1 10-2 11-3
for m=1:4
    if J0(m)>J0(m+4)
        C(m)=m+4;
    else
        C(m)=m;
    end
end
II=[1.9 -0.1 0.9 -1.1 1.1 -0.9 0.1 -1.9];
rk=r(4);
    for n=1:8
        J(n)=(rk-II(n))^2;
    end
    J1=J+[J0(C(1)) J0(C(1)) J0(C(2)) J0(C(2)) J0(C(3)) J0(C(3)) J0(C(4)) J0(C(4))];
%% compare 00-0 01-1 10-2 11-3
for m=1:4
    if J1(m)>J1(m+4)
        C(m)=m+4;
    else
        C(m)=m;
    end
end
rk=r(5);
    for n=1:8
        J(n)=(rk-II(n))^2;
    end
    J2=J+[J1(C(1)) J1(C(1)) J1(C(2)) J1(C(2)) J1(C(3)) J1(C(3)) J1(C(4)) J1(C(4))];
