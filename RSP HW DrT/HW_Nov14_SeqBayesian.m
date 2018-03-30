#Sequential Bayesian
#Wn=0.001*randn(1,20);
clc
clear all
close all
i=0
np=4; #number of parameters
p=[0.1 0.2 0.3 0.4]';
pe=zeros(np,1);
#M=p*p'; #pxp matrix
w1=2*pi*0.1;
w2=2*pi*0.2;
var_n=0.00001;
Ip=eye(np);
alpha=0.001;
M=alpha*Ip;
max_num_iterations=10000;
epsilon_er=100000;
err_vector=null(max_num_iterations,1);
while(epsilon_er>0.00001 && i!=max_num_iterations)
#while (i<10)
  Wn=var_n*randn;
  h=[cos(w1*i) sin(w1*i) cos(w2*i) sin(w2*i)]'; #h[n]
  x=h'*p+Wn;   #x[n]
  xe=h'*pe;   #x[b] Estimated 
  e=x-xe;     #error of my estimation
  Knum=M*h;   #it is a vector
  Kden=h'*M*h+var_n; #Kdenominator
  K=(1/Kden)*Knum;
  pe=pe+e*K;  #update the estimation
  M=Ip-K*h'*M
  i=i+1;
  epsilon_er=abs(e);
  err_vector(i)=norm(p-pe);
endwhile
i
epsilon_er
pe
plot(err_vector)
figure
new_vector=err_vector((length(err_vector)-10:length(err_vector)));
plot(new_vector)
