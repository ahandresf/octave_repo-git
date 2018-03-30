##Andres Felipe Alba 
##Homework 3

#Least mean square algorithm 
close all
clear all
clc
load hw3.mat
err_ye=2^16;
u=0.001;
L=200;
w=zeros(L,1);
max_num_iterations=2000;
i=1
epsilon_err=0.001
while(abs(err_ye)>epsilon_err && i!=max_num_iterations)
  x=(0.5-rand(200,1)); #the vector of inputs
  #y=conv(TF_S,x);
  #ye=conv(w,x);
  y=TF_S*x;
  #y=(TF_S(i:i+L-1))*x; #the real value of y
  ye=w'*x(1:L); #Lets get the estimated value, 
  err_ye(i)=y-ye;
  w=w-u*x(1:L)*err_ye(i);
  i=i+1;
endwhile

figure
subplot(3,1,1)
plot(TF_S(1:L))
subplot(3,1,2)
plot(w)
subplot(3,1,3)
plot(err_ye)

