####
clc
clear all
#f=-(1/2+1/128):1/128:1/2-1/128;
f=linspace((-1/2)+(1/128),(1/2)-(1/128),128);
Cf=1./(1+cos(2*pi*f));
Cn=ifftshift(ifft(Cf,128));
t=0:127;
subplot(2,1,1)
plot(t,Cn);
subplot(2,1,2)
plot(f,Cf);

