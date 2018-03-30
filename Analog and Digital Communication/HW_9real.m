###Do an adaptive filter 
clc
close all
clear all

x=[0.5 1 0.5]';
w=[0 0 0]';
i=1;
n=10

epsilon_er=0.01;
err_energy=5*epsilon_er;
e(1:n)=5*epsilon_er;
I=[0 0 0]'; #assuming zero before the sample. 

###Generate binary random sequence. 
while err_energy>epsilon_er
#for h=1:1000
#for i=1:10
  if rand>0.5
    b=1;
  else
    b=-1;
  endif

  #input(i)=b;
  i=i+1;
  I=[b;I(1:length(I)-1)];
  ye=dot(I,w);
  y=dot(I,x);
  e(i+n)=y-ye;
  w=w+e(i+n)*I./(norm(I)^2);
  err_energy=(1/n)*dot(e(length(e)-n:length(e)),e(length(e)-n:length(e)));
end
plot(e(n:length(e)))
