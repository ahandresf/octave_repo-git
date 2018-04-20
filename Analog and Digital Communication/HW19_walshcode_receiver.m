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
b0=bin_input(1:length(bin_input)/2);
b1=bin_input(length(bin_input)/2+1:length(bin_input));
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
h0=[0.1 -0.2]; ##Channel 1 impulse response
h1=[-0.1 0.3]; ##Channel 2 impulse response

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
L=length(C0)+length(h0)-1; #length of the superbuffer
Lc=length(C0); #length of code

limit=length(R)-L-2; #limit on the calculation
i=1;
k=1;#counter for the output

#My superbuffer is 5x1
#Two small buffer of 4x1


while (i<limit)

##For extract b0
  R0_1=R(i:i+Lc-1)*h0(1); #This vectore will be 4x1
  R0_2=R(i+1:i+Lc)*h0(2); #this vectore will be 4x1
  R0_t=R0_1+R0_2;
  bin_out0(k)=dot(R0_t,C0);
  #Quantization
  if (bin_out0(k)>0)
    bin_out0(k)=1;
  else
    bin_out0(k)=-1;
  endif

##For extract b1
  R1_1=R(i:i+Lc-1)*h1(1);
  R1_2=R(i+1:i+Lc)*h1(2);
  R1_t=R1_1+R1_2;
  bin_out1(k)=dot(R1_t,C1);

  #Quantization
  if (bin_out1(k)>0)
    bin_out1(k)=1;
  else
    bin_out1(k)=-1;
  endif

  i=i+L-1; #shift i by length of the supperbuffer -1
  k=k+1; #counter for the vectors
endwhile
bin_out0=bin_out0';
bin_out1=bin_out1';

figure
subplot(2,1,1)
stem(b0(1:length(bin_out0)))
title("input0")
subplot(2,1,2)
stem(bin_out0)
title("output0")

figure
subplot(2,1,1)
stem(b1(1:length(bin_out1)))
title("input1")
subplot(2,1,2)
stem(bin_out1)
title("output1")