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

##Input generator: This just generate random binary numbers imaginary,
## eg. 1+j or -1-j3
## 3+3j or 1+1j
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
  In(counter,1)=a+b;
endwhile
####

#h=rand(10,1);
#h=randn(10,1)+randn(10,1)*i; #Creating a random 10 tap channel real
h=[0.1+0.2i  0.2-0.1i 0.2+0.2i 03-0.1i 0.3-0.7i 0.4+0.6i 0.5-0.7i 0.2+0.5i 0.8+0.4i 0.5+0.5i]


#pil_s=[1.5-4i;-1.5+4i;-1.5+1.5i;1.5-1.5i];
pil_s=[1-3i;-1+3i;-1+i;1-i]; #Vector of pilots. pick always real different sign from imaginary
pilot=[pil_s;pil_s;pil_s;pil_s]; #16x1 of repetition
#pilot=[0.1+0.2i  0.2-0.1i 0.2+0.2i 03-0.1i 0.3-0.7i 0.4+0.6i 0.5-0.7i 0.2+0.5i 0.8+0.4i 0.5+0.5i]

#Inserting pilots in the In vector
for j=0:15
  In(j*4+1)=pilot(j+1);
  position(j+1)=j*4+1;
endfor

mod_In=ifft(In,64); 
mod_cp=[mod_In(64-8:64);mod_In];### should I add something in the right
S=conv(mod_In,h);   #64+10-1=73
R=fft(S,64); #what happend when I do 64 fft

for j=0:15
  He(j+1,1)=R(j*4+1)/pilot(j+1);
endfor

he=ifft(He,16);

disp("the channel is")
h;
disp("The estimated channes is")
he(1:10);




