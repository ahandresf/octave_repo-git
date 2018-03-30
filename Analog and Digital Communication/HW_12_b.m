clc
clear all
close all
T=1;
alpha=1/8;
t=linspace(-8,8,32);
f=linspace(-1,1-1/512,512);
rc_sin=sin(pi*t/T)./(pi*t/T);
rc_cos=cos(alpha*pi*t)./(1-(4*alpha^2*t.^2)/T^2);
rc=rc_sin.*rc_cos;
figure
plot(t,rc)
title("Raise cosine filter in time domain")
Rc=fftshift(fft(rc,512));
figure
plot(f,abs(Rc))
title("Raise cosine filter in frequency")
RcdB=20*log10(Rc);
figure
plot(f,abs(RcdB))
title("Raise cosine filter in frequency in DB")
