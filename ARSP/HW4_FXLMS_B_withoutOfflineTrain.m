#Author: Andres Felipe Alba Hernandez
#Northern Illinois University
#aalbahernandez1@niu.edu
#FxMLS with feedback PART B Using only delays for the paths for active noise cancellation

clc
clear all
close all

#loading libraries 
pkg load control
pkg load signal


#Data loaded is:
dir="/home/leasanspy/Octave Code/ARSP/HW4data/";
n_ref1=importdata("/home/leasanspy/Octave Code/ARSP/HW4data/SEC13R.mat");
n_ref2=importdata("/home/leasanspy/Octave Code/ARSP/HW4data/SEC18R.mat");
load ("/home/leasanspy/Octave Code/ARSP/HW4data/wn.mat"); #white noise given by the problem
load ("/home/leasanspy/Octave Code/ARSP/HW4data/TF.mat"); #P_p, P_z,S_p,S_z 
load ("/home/leasanspy/Octave Code/ARSP/HW4data/BPF.mat"); #band pass filter
load ("/home/leasanspy/Octave Code/ARSP/HW4data/LPF.mat"); #low pass filter

disp("we load S from the workspace");
load offline_train
disp("this is FxMLS with feedback and only delay")

#Inputs (noise for example)
  n_ref=wn; #Input online train training white noise
    #n_ref=n_ref1; #Input online train training noise amplitud 8000 peak to peak SEC13R
    #n_ref=n_ref2; #Input online train training noise amplitud 3000 peak to peak SEC18R
    #n_ref_filt=conv(n_ref,LPF);

#Filter the input
  filter_noise=LPF(19,:); #The first row is the LPF with better Q
  nf=conv(n_ref,filter_noise); #Input noise filter = color noise

#Set Paramaters of the filter and LMS (Least Mean Square)
  L=500; #length of my filter
  w=zeros(L,1); #filter that will be addapted by LMS inializing with zeros
  #m_u=1.2*1e-13;
  max_iter_online=length(n_ref)-L; #max number of iterations

#Set the delay 
  d_f=5; #this is the delay apply for each input, MUST BE SMALLER OR EQUAL TO L

  #Z filter pure delay at d_f
  z_filter=zeros(d_f,1);
  z_filter(d_f)=1; #Maybe this filter is not even need it.
  z_filter_L=zeros(L,1);#
  z_filter_L(d_f)=1; #Maybe this filter is not even need it.


#Buffers
  y_in_buffer=zeros(d_f,1); #same length of z_filter
  nf_e_buffer=zeros(L,1); #buffer of estimated nf
  nf_e_buffer_z=zeros(L,1); #for convolve with the delay, same length of z_filter

for k=1:max_iter_online
#for k=1:3
    y_in=dot(nf_e_buffer,w); 
    y_in_buffer=[y_in;y_in_buffer(1:length(y_in_buffer)-1)]; #buffer of size d_f

    y_out=dot(y_in_buffer,z_filter); #this is only the last sample
    y_out_test(k)=y_in_buffer(d_f);

    e(k)=nf(k)-y_out;
    nf_e=y_out+e(k);
    nf_e_buffer=[nf_e;nf_e_buffer(1:length(nf_e_buffer)-1)]; #moving one position all element and inserting one, size L
    nf_power=dot(nf_e_buffer,nf_e_buffer);
    m_u=0.1/nf_power; ##max mu=2/(L_w*Px) where Px power of the input. 

    nf_z=dot(nf_e_buffer_z,z_filter_L); #Producing a sample filter by z
    nf_e_buffer_z=[nf_z;nf_e_buffer_z(1:length(nf_e_buffer_z)-1)]; #Moving the buffer for next iteration

    w=w+m_u*nf_e_buffer_z*e(k); #new w for iteration k+1
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
ylabel ("e[n]")

figure;
time=[1:length(e)];
subplot(2,1,1);
plot(e(length(e)-1000:length(e)));
title("Noise Output last 1000")
xlabel ("discrete time [n]");
ylabel ("e[n]")
subplot(2,1,2);
plot(n_ref(length(n_ref)-1000:length(n_ref)));
title("Noise Input last 1000")
xlabel ("discrete time [n]");
ylabel ("nref[n]")

#{

plot_filters='True'
if plot_filters

f=LPF(1,:);
subplot(6,1,1);
plot(fftshift(abs(fft(f))))


f=LPF(3,:);
subplot(6,1,2);
plot(fftshift(abs(fft(f))))



f=LPF(6,:);
subplot(6,1,3);
plot(fftshift(abs(fft(f))))



f=LPF(12,:);
subplot(6,1,4);
plot(fftshift(abs(fft(f))))



f=LPF(15,:);
subplot(6,1,5);
plot(fftshift(abs(fft(f))))



f=LPF(19,:);
subplot(19,1,6);
plot(fftshift(abs(fft(f))))

else
disp("not plots")
}#

#{
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
ylabel ("e[n]")
#}


