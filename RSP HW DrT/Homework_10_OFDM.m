# This homework request to generate
# x[n]=a1*cos(2*pi*f1*n)+b1*sin(2*pi*f1*n)+a2*cos(2*pi*f2*n)+b2*sin(2*pi*f2*n).....+w[n]
# w[n] is noise
# For N divisions of the frequency 

clear all
clc
N=20; #the number of division of frequency we are going to do in our bandwidth
f1=4/N;
f2=7/N;
xf=[zeros(1,3) (0.7/2)+(0.6*i/2) 0 0 (0.3/2)-(i*0.1/2) zeros(1,13)]; #signal in the frequency domain
disp("length Xf = ")
length(xf)
w=randn(1,20); #noise in the time domain
subplot (3, 1, 1)
plot(abs(xf),"*")
subplot (3, 1, 2)
plot(w,"*");
xt=ifft(xf)+w; #this is my signal 
#x[n]=a1*cos(2*pi*f1*n)+b1*sin(2*pi*f1*n)+a2*cos(2*pi*f2*n)+b2*sin(2*pi*f2*n)+w[n]
xfm=fft(xt,20);
subplot(3,1,3)
plot(abs(xfm),"*")
##################3
a=(2/N)*real(xfm)
b=(2/N)*imag(xfm)







