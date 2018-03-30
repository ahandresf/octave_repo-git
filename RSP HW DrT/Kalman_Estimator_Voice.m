####Kalman Estimator
clc
#clear all
close all

#The model of the system is 
#x[n]=h[n]*Theta+w[n] Where h[n] =voice frame 

#For the voice case Q is the variance of the voice noise 
#The given model in class was:
#for this specific case Q=var_u

iteration=0;
np=10;#number of parameters, should be a variable of the function. 10 for voice case 
alpha=10;#Parameter that will determine memory, speed of the convergencing
max_num_iterations=160; #assure an out of the loop if not convergence
epsilon_er=100; #big number, depends on application 
var_n=0; #the variance of my noise in the system it should be measuare from my voice sample. 
pe=zeros(np,1)
Ip=eye(np);
#endfor
B=[1;zeros(np-1,1)]
h=[1 0 0 0 0 0 0 0 0 0]' 

last_frame=floor(length(voice)/160)#number of frames
for iteration=0:last_frame
  voice_frame=voice(1+(iteration*160):((iteration*160)+160));#move my voice 160 frames with every iteration
  
###Block for calculate the coefficeint of this specific frame 
  rp=zeros(11,1);
  for j=0:10
    acum=0;
      for i = 1:160-j
        acum=acum+(voice_frame(i)*voice_frame(j+i));
      endfor
    rp(j+1)=acum/10; #av is a vector from [1 to 11] where rv[1]=r(0)....rv[11]=r(10)
  endfor
  rm=rp(1:10);
  rv=rp(2:11);
  R=toeplitz(rm);
  av=inv(R)*rv;
  var_u=rp(1)-av'*rv;
###Now you get the first 160 samples coefficient in av and the variance var_u

###Now we are going to get the samples one by one. Sequential. 
##The model is:
#x[n]= [1 0 0 ...0] [sn sn-1 ...sn-9]' + wn
#theta = sn sn-1 ...sn-9= [av;I]
  A=[av';Ip(1:9,:)] #vector that generate the change of the parameters all pole system
  pep=A*pe;#how do I calculate this A may be 10x10 
  ####A10x1 * pe10x1
  xe=h'*pe; ##
  e=x-xe; #####x come from my system
  ###I need Q which he s
  M=A*M*A'+B*Q*B';###
  Knum=M*h;
  Kdem=h'*M*h+var_n;
  K=(1/Kden)*Knum;
  pe=pe+k*e;
  M=(Ip-K*h')*M;
  iteration=iteration+1;
endfor





