#Andres Felipe Alba Hernandez 
#Northern Illinois University
#Hw19
#We have two channels and two walsh codes. 
clc
clear all
close all

#loading package-libraries
pkg load signal

#Generate random input of size n
n=100
k=0;
while k!=n
  if rand>0.5
    b=1;
  else
    b=-1;
  endif
  k=k+1;
  bin_input(k)=b;
endwhile
bin_input=bin_input';
bin_input=upsample(bin_input,4); #upsample by 4

#Split the input in two. 
bin_input0=bin_input(1:length(bin_input)/2);
bin_input1=bin_input(length(bin_input)/2+1:length(bin_input));

#Four tap code
w2=[1 1;-1 1]; #ortogonal codes
w4=[w2 w2;-w2 w2]; #This pattern will create ortogonal codes, as far as w2 are ortogonal.

##For the quiz porpuses the code comes frome 2nd and third colum of W4
C0=w4(:,2);
C1=w4(:,3);
dot(C0,C1) #must be zero, just for being sure

#Two codes means two different geolocations so different channels, multipath
h0=[0.1 -0.2];
h1=[-0.1 0.3];

#the whole path including channels
g0=conv(C0,h0);
g1=conv(C1,h1);

#the receive signal may be
r0=conv(bin_input0,g0);
r1=conv(bin_input1,g1);
R=r0+r1;

#########
#RECEIVER:
#code_lenght+channel_lenght-1;
L=length(C0)+length(h0)-1
for i=1:length(h0)
  vect_c0_1=R(i:i+L)*h0(0);
  vect_c0_2=R(i+1:i+L+1)*h0(1);
  vect_c1_1=R(i:i+L)*h1(0);
  vect_c0_2=R(i+1:i+L+1)*h1(1);
endfor

  



