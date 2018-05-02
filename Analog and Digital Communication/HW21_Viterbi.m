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
n=3;
function Jo=cost_ini(n)
  Jo=(r(n-2)-I(n-2))^2+(r(n-1)-I(n-1)-0.5*I(n-1))^2+(r(n)-I(n)-0.5*I(n-1)-0.4*I(n-2))^2;
endfunction

for i=1:length(T)
  I=T(i,:);
  alpha(i)=(r(n-2)-I(n-2))^2+(r(n-1)-I(n-1)-0.5*I(n-1))^2+(r(n)-I(n)-0.5*I(n-1)-0.4*I(n-2))^2;
  #alpha(i)=cost_ini(3);
endfor

if alpha(1)>alpha(5)
  I_next(1,:)=T(5,:)
  cost(1)=alpha(5)
else
  I_next(1)=T(1,:)
  cost(1)=alpha(1)
  
if alpha(1)>alpha(5)
  I_next(1,:)=T(5,:)
  cost(1)=alpha(5)
else
  I_next(1)=T(1,:)
  cost(1)=alpha(1)
  



#{
 function Jc=mycost(n)
  Jc=Jc(n-1)+(r(n)-I(n)-0.5*I(n-1)+0.4*I(n-2)+0.1*randn;
endfunction
}#
