####Kalman Estimator
clc
#clear all
close all

#The model of the system is 
#x[n]=h[n]*Theta+w[n] Where h[n] =voice frame 

#For the voice case Q is the variance of the voice noise 
#The given model in class was:
#Theta[n]=(0.99^i)*Theta[n-1]+U[n] where U[n] is mean zero and var_u=0.01
#for this specific case Q=var_u

iteration=0;
np=10;#number of parameters, should be a variable of the function. 10 for voice case 
alpha=10;#Parameter that will determine memory, speed of the convergencing
max_num_iterations=40000; #assure an out of the loop if not convergence
epsilon_er=100; #big number, depends on application 
var_n=0; #the variance of my noise in the system it should be measuare from my voice sample. 
#endfor
B=[1;zeros(np-1,1)]
h=[1 0 0 0 0 0 0 0 0 0]' 

#B=ones(np,1);

while(epsilon_er>0.00001 && iteration!=max_num_iterations)
  pep=A*pe;#how do I calculate this A may be 10x10 
  ####A10x1 * pe10x1
  voice_frame=voice(1+(iteration*160):((iteration*160)+160));#move my voice 160 frames with every iteration
  ##now I need to calculate the coefficients
  n=160
  limit=160
  rv1=zeros(1,limit+1);
  for j=0:limit
    acum=0;
      for i = 1:n-j
    #acum=acum+(my_audio(i)*my_audio(j+i));
    acum=acum+(frame3(i)*frame3(j+i));
  #do i need to calculate again the coefficients av????. 
  xe=h'*pe; ##
  e=x-xe; #####x come from my system
  M=A*M*A'+B*Q*B';###
  Knum=M*h;
  Kdem=h'*M*h+var_n;
  K=(1/Kden)*Knum;
  pe=pe+k*e;
  M=(Ip-K*h')*M;
  iteration=iteration+1;





