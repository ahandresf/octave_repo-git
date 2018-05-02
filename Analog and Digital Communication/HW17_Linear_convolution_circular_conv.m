#Andres Felipe Alba Hernandez
#Northern Illinois University
#2018
#####
#Question a is to perform linear convolution
close all
clear all
clc
pkg load signal

x_input=[0.1 0.2 0.3 0.6];
h_channel=[-0.1 0.2 -0.3];
n=[1:6]


output_lconv=conv(x_input,h_channel); #Output
figure;
subplot(3,1,1)
plot(output_lconv,'r')
title("Results from linear convolution")
#hold on

#Question b is to circular convolution
output_cconv=cconv(x_input,h_channel)
subplot(3,1,2)
plot(output_cconv,'g')
title("Results from circular convolution")


#Point c is solving the problem in frequency domain to compare. 
x_f=fft(x_input,4);
h_f=fft(h_channel,4);
y_f=x_f.*h_f;
output_ifft=ifft(y_f,4);
#figure
subplot(3,1,3)
plot(output_ifft,'g')
title("Results from inverse fft")


