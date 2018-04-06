#Andres Felipe Alba Hernandez
#FxMLS with feedback
clc
clear all
close all

#loading libraries 
pkg load control
pkg load signal

#Loading the Data
#load TF.mat; #loas P_p, P_z,S_p,S_z Functions
###Data loaded is:
dir="/home/leasanspy/Octave Code/ARSP/HW4data/";
n_ref1=importdata("/home/leasanspy/Octave Code/ARSP/HW4data/SEC13R.mat");
n_ref2=importdata("/home/leasanspy/Octave Code/ARSP/HW4data/SEC18R.mat");
load ("/home/leasanspy/Octave Code/ARSP/HW4data/wn.mat"); #white noise given by the problem
load ("/home/leasanspy/Octave Code/ARSP/HW4data/TF.mat"); #P_p, P_z,S_p,S_z 
load ("/home/leasanspy/Octave Code/ARSP/HW4data/BPF.mat"); #band pass filter
load ("/home/leasanspy/Octave Code/ARSP/HW4data/LPF.mat"); #low pass filter

#{
sysP=filt(P_z,P_p); 
sysS=filt(S_z,S_p); 
[Simp,t]=impulse(sysS);#impulse response of S
Pimp=impulse(sysP); #impulse response of P
#}

###
#Inputs (noise for example)
  #n_ref=wn; #Input online train training white noise
  n_ref=n_ref1; #Input online train training noise amplitud 8000 peak to peak SEC13R
  #n_ref=n_ref2; #Input online train training noise amplitud 3000 peak to peak SEC18R
  #n_ref_filt=conv(n_ref,LPF);


disp("we load S from the workspace");
load offline_train
disp("this is FxMLS with feedback")
L=100; #length of my filter
w=zeros(L,1); #filter that will be addapted by LMS

  ###
  y_in_buffer=zeros(length(S_z),1);
  y_in_buffer2=zeros(length(s_e),1);
  y_out_buffer=zeros(length(S_p)-1,1); #buffer of 24
  d_e_buffer=zeros(L,1);
  d_e_buffer_s=zeros(length(s_e),1);
  #d_buffer=zeros(length(s_e),1); #with ref microphone
  #n_buffer_s_e=zeros(length(s_e),1); # with ref microphone
  ##
m_u=1.2*1e-13;
max_iter_online=length(n_ref)-L;

for k=1:max_iter_online
#for k=1:100000
    #k=1;
    y_in=dot(d_e_buffer,w); #output of filter in this iteration used in the block below

    y_in_buffer=[y_in;y_in_buffer(1:24)]; #buffer of size 25, using y_in
    y_out=(dot(y_in_buffer,S_z)-dot(y_out_buffer,S_p(2:25)))/S_p(1);#generating yout=conv(yin,S)
    y_out_buffer=[y_out;y_out_buffer(1:23)]; #rotating buffer, buffer of 24

    y_in_buffer2=[y_in;y_in_buffer2(1:length(y_in_buffer2)-1)]; #buffer of size of s_e 100, using y_in
    y_out_e=dot(y_in_buffer2,s_e); #My estimation of y_out

    d(k)=n_ref(k); #in other case can be filter that is why I just change variable. 
    e(k)=d(k)-y_out;
    d_e=y_out_e+e(k); 
    #d_e_buffer=[d_e;d_e_buffer(1:length(d_e_buffer)-1)]; #new buffer d_e for iteration k+1


    d_e_s=dot(d_e_buffer,s_e); #convolution between the input and estimate S
    d_e_buffer_s=[d_e_s;d_e_buffer_s(1:length(d_e_buffer_s)-1)]; #use as input for LMS

    input_power=dot(d_e_buffer_s,d_e_buffer_s); #similar to the power of the buffer
    if k==1
      disp("First iteration");
      m_u=0.1
    else
      m_u=0.1/input_power;
    endif

    w=w+m_u*d_e_buffer_s*e(k); #new w for iteration k+1
    d_e_buffer=[d_e;d_e_buffer(1:length(d_e_buffer)-1)]; #new buffer d_e for iteration k+1
end

figure;
time=[1:length(e)];
subplot(2,1,1);
plot(time,e);
title("Noise Output")
xlabel ("discrete time [n]");
ylabel ("e[n]")
subplot(2,1,2);
plot(time,n_ref(1:length(e)));
title("Noise Input")
xlabel ("discrete time [n]");
ylabel ("nref[n]")


figure;
time=[1:length(e)];
subplot(2,1,1);
plot(e(length(e)-1000:length(e)));
title("Noise Output last 1000")
xlabel ("discrete time [n]");
ylabel ("e[n]")
subplot(2,1,2);
plot(n_ref(length(e)-1000:length(e)));
title("Noise Input last 1000")
xlabel ("discrete time [n]");
ylabel ("nref[n]")


