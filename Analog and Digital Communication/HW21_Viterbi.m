#Andres Felipe Alba Hernandez
#r[n]=I[n]+0.5*I[n-1]+0.4I[n-2]+w[n]
clear all
clc
close all
##Input vector
bn=[-1 1 1 -1 1 -1 -1 1 -1 1 -1 1 -1 1 -1 -1 -1 -1 1 -1]';
r(1)=bn(1)+0.1*randn;
r(2)=bn(2)+0.5*bn(1)+0.1*randn;
L=length(bn);

for n=3:L
  r(n)=bn(n)+0.5*bn(n-1)+0.4*bn(n-2)+0.1*randn;
endfor
r=r';


#table of possibilities. 
     T=[-1 -1 -1; 
       -1 -1 1;
       -1 1 -1;
       -1 1 1;
       1 -1 -1;
       1 -1 1;
       1 1 -1;
       1 1 1;] 

#Starting first iteration for N=2.
#n=3;
function Jo=cost_ini(n)
  Jo=(r(n-2)-I(n-2))^2+(r(n-1)-I(n-1)-0.5*I(n-1))^2+(r(n)-I(n)-0.5*I(n-1)-0.4*I(n-2))^2;
endfunction

T_res=cost_ini(n);

function Jc=mycost(n)
  Jc=Jc(n-1)+(r(n)-I(n)-0.5*I(n-1)+0.4*I(n-2)+0.1*randn;
endfunction

for i=1:length(Table)
  I

J=mycost(5);



#{
I(n-2)=-1;
I(n-1)=-1;
I(n)=-1;

I(n-2)=1;
I(n-1)=-1;
I(n)=-1;

I(n-2)=-1;
I(n-1)=1;
I(n)=-1;

I(n-2)=1;
I(n-1)=1;
I(n)=-1;

I(n-2)=-1;
I(n-1)=-1;
I(n)=1;

I(n-2)=1;
I(n-1)=-1;
I(n)=1;

I(n-2)=-1;
I(n-1)=1;
I(n)=1;

I(n-2)=1;
I(n-1)=1;
I(n)=1;
#}