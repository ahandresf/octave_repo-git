#Andres Felipe Alba Hernandez
#Analog and Digital Communications
#Northern Illinois University
#Implement pilot insertion for 16 QAM and 10 tap channel to estimate channel.
#System characteristics:
#64OFDM
#16QAM=-3+j
#10 tap channel

clear all
clc
close all

##Input generator: This just generate random binary numbers imaginary, eg. 1+j or -1-j4
counter=0
while(counter!=64)
  if rand>0.5
    a=1;
  else
    a=-1;
  endif

  if rand>0.5
     b=1i;
  else
     b=-1i;
  endif
  
  if rand>0.5
    a=a*3;
  else
    a=a;
  endif
  
  if rand>0.5
    b=b*3;
  else
    b=b;
  endif
  
  counter=counter+1;
  In(counter)=a+b;
endwhile

#h=rand(10,1)
h=randn(10,1)+randn(10,1)*i; #Creating a random 10 tap channel real

pil_s=[1-3i;-1+3i;-1+i;1-i]; #Vector of pilots. pick always real different sign from imaginary
pilot=[pil_s;pil_s;pil_s;pil_s]; #16x1 of repetition

#Inserting pilots in the In vector
for j=0:15
  In(j*4+1)=pilot(j+1);
endfor

mod_In=ifft(In,64);
S=conv(mod_In,h);   #64+10-1=73
R=fft(S,64);

for j=0:15
  He(j+1)=R(j*4+1)/pilot(j+1);
endfor

he=ifft(He,16);

disp("the channel is")
h
disp("The estimated channes is")
he



