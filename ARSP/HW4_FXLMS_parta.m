#Andres Felipe Alba Hernandez
#FxMLS with feedback
clc
clear all
close all

###
#Rutine Activations
offline=false
online_train=true
feedbak=true;

#loading libraries 
pkg load control
pkg load signal


#Loading the Data
dir="/home/leasanspy/Octave Code/ARSP/HW4data/";
n_ref1=importdata("/home/leasanspy/Octave Code/ARSP/HW4data/SEC13R.mat");
n_ref2=importdata("/home/leasanspy/Octave Code/ARSP/HW4data/SEC18R.mat");
load ("/home/leasanspy/Octave Code/ARSP/HW4data/wn.mat"); #white noise given by the problem
load ("/home/leasanspy/Octave Code/ARSP/HW4data/TF.mat"); #P_p, P_z,S_p,S_z 
load ("/home/leasanspy/Octave Code/ARSP/HW4data/BPF.mat"); #band pass filter
load ("/home/leasanspy/Octave Code/ARSP/HW4data/LPF.mat"); #low pass filter

sysP=filt(P_z,P_p); 
sysS=filt(S_z,S_p); 
[Simp,t]=impulse(sysS);#impulse response of S
Pimp=impulse(sysP); #impulse response of P


#load TF.mat; #loas P_p, P_z,S_p,S_z Functions

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
#x=0.5-rand(iter_filt,1); #the vector of inputs white noise 
#x=randn(200,1); #gaussian noise
xbuffer=zeros(L,1);
n=25;
err_ye(1:n)=1;
err_energy=(1/n)*dot(err_ye(1:length(err_ye)),err_ye(1:length(err_ye)))
ej=0;

###
#Inputs (noise for example)
x=wn(1:iter_filt); #Input offlineline training
#n_ref=wn; #Input online train training white noise
n_ref=n_ref1; #Input online train training noise amplitud 8000 peak to peak
#n_ref=n_ref2; #Input online train training noise amplitud 3000 peak to peak
#n_ref_filt=conv(n_ref,LPF);


y=filter(S_z,S_p,x); #output of direct path for online trian
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
  figure;
  plot(err_ye);
  title("Error offline_train err ye");
  xlabel ("discrete time");
  ylabel ("err ye[n]");
else
    disp("no offline training")
endif

if online_train
  if offline
    disp("we train in this rutine");
  else
    disp("we load S from the workspace");
    load offline_train
  endif
  #d=filter(P_z,P_p,n_ref);
  #noise_s=filter(S_z,S_p,n_ref1);

  disp("this is FxMLS with feedback")
  #noise_s_e=filter(s_e,1,n_ref); #The input filtered with S_h
  L=100; #length of my filter
  w=zeros(L,1); #filter that will be addapted by LMS

  ###
  y_in_buffer=zeros(length(S_z),1);
  y_in_buffer2=zeros(length(s_e),1);
  y_out_buffer=zeros(length(S_p)-1,1); #buffer of 24
  d_e_buffer=zeros(L,1);
  #Buffer for other possible implementations but not now
  #n_buffer=zeros(L,1); #
  #n_buffer_s=zeros(L,1); #
  d_buffer=zeros(length(s_e),1); #with ref microphone
  n_buffer_s_e=zeros(length(s_e),1); # with ref microphone
  #y_out_e_buffer=zeros(length(S_p)-1,1); #buffer of 24 for the estimated value
  ###
  
  #m_u=0.0000000012; #m_u=1.2*1e-9;
  m_u=1.2*1e-9;
  max_iter_online=length(n_ref)-L;

  for k=1:max_iter_online
  #for k=1:10
    y_in=dot(d_e_buffer,w); #input buffer, right after w and before s
    #y_in=dot(d_buffer,w); #with ref microphone
    y_in_buffer=[y_in;y_in_buffer(1:24)]; #buffer of the output after filter with S
    
    y_out=(dot(y_in_buffer,S_z)-dot(y_out_buffer,S_p(2:25)))/S_p(1);#generating yout=conv(yin,S)
    y_out_buffer=[y_out;y_out_buffer(1:23)]; #rotating buffer, buffer of 24
    y_out_e=dot(y_in_buffer2,s_e); #My estimation of y_out
      #n_buffer=[n_ref(k);n_buffer(1:length(n_buffer)-1)]; #putting one noise sample in one out
      #d[k]=dot(Pimp,n_buffer);#output of the real channel
    d(k)=n_ref(k); #in other case can be filter that is why I just change variable. 
    e(k)=d(k)-y_out;
    d_e=y_out_e+e(k); 
    d_e_buffer=[d_e;d_e_buffer(1:length(d_e_buffer)-1)];
    w=w+m_u*d_e_buffer*e(k);
      ##
      #d_buffer=[d(k);d_buffer(1:length(d_buffer)-1)]; #with ref microphone
      #noise_s_e=dot(d_buffer,s_e); #with ref microphone
      #n_buffer_s_e=[noise_s_e;n_buffer_s_e(1:length(n_buffer_s_e)-1)]; #with ref microphone
      #w=w+m_u*n_buffer_s_e*e(k); #with ref microphone

  endfor
  #plot(e);
  #figure;
  #title("Error e=d-y_inout");
endif

plot(e)
title("The error is")
xlabel ("discrete time [n]");
ylabel ("e[n]")

#{
cWS=conv(w,Simp);


figure
plot(e)
title("error: d[n]-y out[n]")
xlabel ("discrete time");
ylabel ("e[n]")


figure
subplot(1,1,1);
plot(cWS)
subplot(2,1,1);
plot(cWS(1:100))
xlabel ("discrete time");
ylabel ("conv(W,S)[n]")
title("Convolution W and S")
subplot(2,1,2);
plot(Pimp(1:100))
xlabel ("discrete time");
ylabel ("P[n]")
title("impulse response of P")
#}






