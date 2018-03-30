###Homework of the equilizer and target channel
clc
clear all
close all
targ_n=[zeros(9,1);1;0.5;1]; #The channel we want to have_window_system
xn=[0.53 0.80 0.13]'; #This is the actual value of the channel. 

targ_f=fftshift(fft(targ_n,256)); #Target channel in the frequency domain
f=-1/2+1/256:1/256:1/2; #This is the ferquency range
subplot(2,2,1);
plot(f,targ_f);
title('targ[f]')
Xf=fftshift(fft(xn,256));
subplot(2,2,2);
plot(f,Xf);
title('XD[f]')
cf=(targ_f./Xf);
subplot(2,2,3);
plot(f,cf)
title('Equalizer C[f]')
cn=ifft(cf,256);
n=-1/2+1/256:1/256:1/2;
subplot(2,2,4);
plot(n,cn)
title('C[n]');

subplot(2,1,1);
plot(n,cn)
title('C[n]');
subplot(2,1,2);
plot(f,cf)
title('C[f]')