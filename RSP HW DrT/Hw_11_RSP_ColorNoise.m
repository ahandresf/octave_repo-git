#Homework 11
clc
clear all
N=20;
white_noise=randn(N,1);
color_noise=(0.9).^(abs(white_noise));
###My model is x=a1+w
a1=3;
A1=a1*ones(N,1);
x=A1+color_noise;
Ae=(1/N)*sum(x);
###########################
N=200;
white_noise=randn(N,1);
color_noise=(0.9).^(abs(white_noise));
###My model is x=a1+w
A1=a1*ones(N,1);
x=A1+color_noise;
Ae2=(1/N)*sum(x);
###########################
N=2000000;
white_noise=randn(N,1);
color_noise=(0.9).^(abs(white_noise));
###My model is x=a1+w
A1=a1*ones(N,1);
x=A1+color_noise;
Ae3=(1/N)*sum(x);
xw=A1+white_noise;
Ae4=(1/N)*sum(xw);



