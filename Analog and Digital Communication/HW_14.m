#Andres Felipe Alba Hernandez
clc
clear all
close all
SN=[10 15 20 25 30 35 40 45 50];
a=1
for iter=1:9
  IR=zeros(10000,1);
  M=16;
  #Generating Information bits 
  #real part
  for n=1:10000
      j=randn(10000,1);
      for x=1:10000
          if j(x)>=2
            IR(x)=3;
          elseif j(x)<=-2 
            IR(x)=-3;
          elseif j(x)<2 && j(x)>0
            IR(x)=1;
          else IR(x)=-1;
          endif
      endfor
  endfor

  #Imaginary part
  II=zeros(10000,1);
  for n=1:10000
      j=randn(10000,1);
     for x=1:10000
          if j(x)>=2
              II(x)=3;
          elseif j(x)<=-2 
              II(x)=-3;
          elseif j(x)<2 && j(x)>0
              II(x)=1;
          else II(x)=-1;
          endif
      endfor
  endfor

  I=IR+i*II;
  sigmac=sqrt(((0.64*2*(M-1))/3)/SN(a));
  sigma=sigmac/1.414;

  #Noise 
  WR=randn(10000,1);
  WR=sqrt(sigma)*WR;
  WI=rand(10000,1);
  WI=sqrt(sigma)*WI;

  W=WR+i*WI;
  V=(0.8*I)+W;
  VR=(real(V))/0.8;
  VI=(imag(V))/0.8;

  #output real part
  IHR=zeros(10000,1);
  for s=1:10000
    if VR(s)>2
      IHR(s)=3;
    elseif  VR(s)>0 && VR(s)<2
      IHR(s)=1;
    elseif   VR(s)<-2
      IHR(s)=-3;
    else 
      IHR(s)=-1; 
    endif
  endfor

  #output imaginary part
  IHI=zeros(10000,1);
  for r=1:10000
    if VI(r)>2
      IHI(r)=3;
    elseif  VI(r)>0 && VI(r)<2
      IHI(r)=1;
    elseif   VI(r)<-2
      IHI(r)=-3;
    else IHI(r)=-1; 
    endif
  endfor
  IH=IHR+i*IHI;
  error=0;

  for z=1:10000
    errorR=IHR(z)-IR(z);
    errorI=IHI(z)-II(z);
    error=errorR+errorI;
    if error!=0
       error=error+1
    endif
  endfor
  Per(iter)= error./10000
endfor
plot(SN,Per)
