##Andres Felipe Alba 
##Homework 3

#Least mean square algorithm 
close all
clear all
clc
load hw3.mat
i=1
err_ye=2^16;
abs_err=err_ye
u=0.1;
L=200;
w=zeros(L,1);
max_num_iterations=200;
epsilon_err=1e-6;
x=(0.5-rand(200,1)); #the vector of inputs white noise 
#x=randn(200,1); #gaussian noise
while(abs_err>epsilon_err && i!=max_num_iterations)
#while(abs_err>epsilon_err)
  y=TF_S*x; #the real output
  ye=w'*x(1:L); #Lets get the estimated value
  #test(i)=y
  #test_e(i)=ye;
  err_ye(i)=y-ye;
  abs_err=abs(err_ye(i));
  w=w+u*x(1:L)*err_ye(i); #update w 
  i=i+1; 
  x=[(0.5-rand);x(1:length(x)-1)]; #For gaussian noise
  #x=[randn;x(1:length(x)-1)]; # For gaussian noise
  plot(w)#test
  title("")
endwhile

figure
subplot(3,1,1)
plot(TF_S(1:L))
title(("Real Filter"));
subplot(3,1,2)
plot(w)
title(("Estimated Filter"));
subplot(3,1,3)
plot(err_ye)
title(("Error"));


