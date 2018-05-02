%Andres Felipe Alba
%Model of a system with 2 reference microphones, 2 error microphones and 2 loud speakers.

clc
clear all
close all

%loading libraries 
pkg load control 
pkg load signal 

#load ('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/Workspace_P2P');
load ('/home/leasanspy/Octave_Code/ARSP/P2P/Sencondarypath.mat');
load ('/home/leasanspy/Octave_Code/ARSP/HW4data/wn.mat'); %white noise given by the problem

load('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/S11_e.mat')
load('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/S21_e.mat')
load('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/S12_e.mat')
load('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/S22_e.mat')

x_ref1=wn';
d_n=1
delay=[zeros(d,1);1];
x_ref2=conv(x_ref1,delay);
x_ref2=x_ref2(1:length(x_ref1));
L_w=800;

%lets buid all the d[n] Signal that go from:
%microphone 1 and 2 to the error microphone=real channel
d11=filter(TF_P1,1,x_ref1);
d21=filter(TF_P2,1,x_ref2);

d12=filter(TF_P3,1,x_ref1);
d22=filter(TF_P4,1,x_ref2);

%Initializing the adaptive filters with zeros. 
W11=zeros(L_w,1);
W12=zeros(L_w,1);
W21=zeros(L_w,1);
W22=zeros(L_w,1);

%Filtering the input with the estimated secondary path
%Reference,error,speakers
%noise 1
%For W11
x_111=filter(S11_e,1,x_ref1);
x_121=filter(S21_e,1,x_ref1);
%For W12
x_112=filter(S12_e,1,x_ref1);
x_122=filter(S22_e,1,x_ref1);

%noise2
%ForW21
x_211=filter(S11_e,1,x_ref2);
x_221=filter(S21_e,1,x_ref2);

%ForW22
x_212=filter(S12_e,1,x_ref2);
x_222=filter(S22_e,1,x_ref2);

%Initializing input buffer
x_ref1_buff=zeros(L_w,1);
x_ref2_buff=zeros(L_w,1);

%Initializing Buffers of the filter after
%From reference 1
X_111_buf=zeros(L_w,1); #This one should go to W11 to speaker 1
X_121_buf=zeros(L_w,1); #This one should go to W11 to speaker 1
X_112_buf=zeros(L_w,1); #This one should go to W12 to speaker 2
X_122_buf=zeros(L_w,1); #This one should go to W12 to speaker 2

%From reference 2
X_211_buf=zeros(L_w,1); #This one should go to W21 tp speaker 1
X_221_buf=zeros(L_w,1); #This one should go to W21 to speaker 1
X_212_buf=zeros(L_w,1); #This one should go to W12 to speaker 2
X_222_buf=zeros(L_w,1); #This one should go to W22 to speaker 2

%Split the training into two error training
%Reference,error,speakers
while(power_err!=1e-5 && k!=10000)

  %
  e(k)=y_out-y_out_e;
  err_buff=[e(k);err_buff(1:L_w-1)]
  power_err=dot(err_buff,err_buff);
  %Updating m_u
  power_1=dot(x_ref1_buff,x_ref1_buff); #power of the input
  power_2=dot(x_ref2_buff,x_ref2_buff); #power of the input
  power_xn=(power_1+power_2)/2; #average of teh power of both input buffer
  m_u=0.1*(2/L_w*power_xn); 
  %Update filters
  W11=W11+m_u*(X_111_buf*e1(k)+X_121_buf*e2(k)); #going to speaker 1
  W12=W12+m_u*(X_112_buf*e1(k)+X_122_buf*e2(k)); #going to speaker 2
  W21=W21+m_u*(X_211_buf*e1(k)+X_121_buf*e2(k)); #going to speaker 1
  W22=W22+m_u*(X_111_buf*e1(k)+X_121_buf*e2(k)); #going to speaker 2
endwhile






