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
max_num_iterations=10000; #assure an out of the loop if not convergence
epsilon_er=100; #big number, depends on application 
var_n=0; #the variance of my noise in the system model
var_u=0.01; #Variance of the noise in the parameter model. IS THIS ALWAYS THE SAME
Q=var_u; #for this specific case

###Initiating variables
err_vector=null(max_num_iterations,1); #vector for save the error of each step
pe=zeros(np,1);
Ip=eye(np);
M=alpha*Ip;
Wn=var_n*randn;

#This part is specific for the voice case.

#autocorrelation_of_frame I am calculating coefficients separated
A=[av;Ip]; #First row is the coefficients find from the autocorrelation of the voice. 
B=[1;zeros((np-1),1];

while(epsilon_er>0.00001 && iteration!=max_num_iterations)
  pep=A*pe; #I still do not know what is A but it should come from the autocorrelation
  h=voice_frame(1+(iteration*160):((iteration*160)+160));#move my voice 160 frames with every iteration
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





