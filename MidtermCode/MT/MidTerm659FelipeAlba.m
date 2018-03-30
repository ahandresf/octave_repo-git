#Andres Felipe Alba Hernandez
clc
clear all
close all

###
#Rutine Activations
offline=true
online_train=true

#loading libraries 
pkg load control
pkg load signal


#Loading the Data
load TF.mat; #loas P_p, P_z,S_p,S_z Functions
n_ref1=importdata('SEC13R.mat');
n_ref2=importdata('SEC18R.mat');

###Data loaded is:

#S=S_z/S_p
#S_z Coefficient of the numerator
#S_p Coefficient of the denominator

#P=P_z/P_p
#P_z Coefficient of the numerator
#P_p Coefficient of the denominator


#Lets estimate S offline LMS
i=1
u=0.0005;
#L=length(S_z);
L=100;
iter_filt=L*5000;
s_e=zeros(L,1);
max_num_iterations=iter_filt;
epsilon_err=1e-6;
x=0.5-rand(iter_filt,1); #the vector of inputs white noise 
#x=randn(200,1); #gaussian noise
y=filter(S_z,S_p,x);
xbuffer=zeros(L,1);
n=25;
err_ye(1:n)=1;
err_energy=(1/n)*dot(err_ye(1:length(err_ye)),err_ye(1:length(err_ye)))
ej=0;

if offline

  #First training
  while(err_energy>epsilon_err && i!=max_num_iterations)
    #while(abs_err>epsilon_err)
    xbuffer=[x(i);xbuffer(1:length(xbuffer)-1)];
    ej=ej+1;
    ye=s_e'*xbuffer; #Lets get the estimated value
    #test(i)=y
    #test_e(i)=ye;
    err_ye(i)=y(i)-ye;
    s_e=s_e+u*xbuffer*err_ye(i); #update w 
    i=i+1;
    #x=[(0.5-rand);x(1:length(x)-1)]; #For gaussian noise
    #x=[randn;x(1:length(x)-1)]; # For gaussian noise
    if ej==n
      err_energy=(1/n)*dot(err_ye(length(err_ye)-n+1:length(err_ye)),err_ye(length(err_ye)-n+1:length(err_ye)));
      ej=0;
    endif
  endwhile
  save ('offline_train');
  history -w 'my_history';
  plot(err_ye);
  figure;
  title("Error offline_train err_ye");
else
    disp("no offline training")
endif

##
#Second Training
if online_train
  if offline
    disp("we train in this rutine");
  else
    disp("we load S from the workspace");
    load offline_train
  endif
  L=100;
  d=filter(P_z,P_p,n_ref1);
  #noise_s=filter(S_z,S_p,n_ref1);
  noise_s_e=filter(s_e,1,n_ref1); #The input filtered with S_h
  n_buffer=zeros(L,1);
  n_buffer_s=zeros(L,1);
  n_buffer_s_e=zeros(L,1);
  y_in_buffer=zeros(25,1);
  y_out_buffer=zeros(24,1);
  w=zeros(L,1);
  m_u=0.0000000012;
  max_iter_online=length(n_ref1)-L;
  #max_iter_online=1;


  for k=1:max_iter_online
  #for k=1:3

    #disp("hola")
    n_buffer=[n_ref1(k);n_buffer(1:length(n_buffer)-1)]; #buffer of whatever size for my filter
    y_in=dot(n_buffer,w); #input buffer, right after w and before s
    y_in_buffer=[y_in;y_in_buffer(1:24)]; #buffer of the output after filter with S
    y_out=(dot(y_in_buffer,S_z)-dot(y_out_buffer,S_p(2:25)))/S_p(1);#
    y_out_buffer=[y_out;y_out_buffer(1:23)]; #buffer of 24
    #y=filter(S_z,S_p,y_in);
    #y(1)
    e(k)=d(k)-y_out;
    n_buffer_s_e=[noise_s_e(k);n_buffer_s_e(1:length(n_buffer_s_e)-1)];
    w=w+m_u*n_buffer_s_e*e(k);
    #w=w+m_u*n_buffer_s_e*e(j);
  endfor
  #plot(e);
  #figure;
  #title("Error e=d-y_inout");
endif
figure
plot(e)
title("error: d[n]-y_out[n]")
sysP=filt(P_z,P_p);
sys=filt(S_z,S_p);
[Stime,t]=impulse(sys);
cWS=conv(w,Stime);
Pimp=impulse(sysP);

figure
subplot(1,1,1);
plot(cWS)
subplot(2,1,1);
plot(cWS(1:100))
title("Convolution W and S")
subplot(2,1,2);
plot(Pimp(1:100))
title("impulse response of P")







