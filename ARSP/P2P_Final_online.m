%Andres Felipe Alba
%Model of a system Active Noice Cancellation system
%with 2 reference microphones, 2 error microphones and 2 loud speakers.
%The sintax of this code may run in MATLAB and Octave

clc
clear all
close all

%loading libraries 
pkg load control 
pkg load signal 

%load ('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/Workspace_P2P');
load ('/home/leasanspy/Octave_Code/ARSP/P2P/Sencondarypath.mat');
load ('/home/leasanspy/Octave_Code/ARSP/HW4data/wn.mat'); %white noise given by the problem

load('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/S11_e.mat')
load('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/S21_e.mat')
load('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/S12_e.mat')
load('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/S22_e.mat')

x_ref1=wn';
d_n=1
delay=[zeros(d_n,1);1];
x_ref2=conv(x_ref1,delay);
x_ref2=x_ref2(1:length(x_ref1));
L_w=800;
L_s=length(TF_S11);

%lets buid all the d[n] Signal that go from:
%microphone 1 and 2 to the error microphone=real channel
%For d the reference is ref,error
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
%For W11 as input
x_111=filter(S_e11,1,x_ref1);
x_121=filter(S_e21,1,x_ref1);
%For W12 as input
x_112=filter(S_e12,1,x_ref1);
x_122=filter(S_e22_e,1,x_ref1);

%noise2
%ForW21
x_211=filter(S_e11,1,x_ref2);
x_221=filter(S_e21,1,x_ref2);

%ForW22
x_212=filter(S_e12,1,x_ref2);
x_222=filter(S_e22,1,x_ref2);

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

%Power err buffers
err_buff1=ones(L_w,1);
err_buff2=ones(L_w,1);

%


%Split the training into two error training
%Reference,error,speakers
while(power_err1!=1e-5 && power_err2!=1e-5 && k!=100)

  %reference input
  x_ref1_buff=[x_ref1(k);x_ref1_buff(1:L_w-1);
  x_ref2_buff=[x_ref2(k);x_ref2_buff(1:L_w-1);

  %Moving all buffer with the filter samples conv(r_noise,Se)
  X_111_buf=[x_111(k);X_111_buf(1:length(X_111_buf))]; 
  X_121_buf=[x_121(k);X_121_buf(1:length(X_121_buf))]; 
  X_112_buf=[x_112(k);X_112_buf(1:length(X_112_buf))]; 
  X_122_buf=[x_122(k);X_122_buf(1:length(X_122_buf))]; 
  X_211_buf=[x_211(k);X_211_buf(1:length(X_211_buf))]; 
  X_221_buf=[x_221(k);X_221_buf(1:length(X_221_buf))]; 
  X_212_buf=[x_212(k);X_212_buf(1:length(X_212_buf))]; 
  X_222_buf=[x_222(k);X_222_buf(1:length(X_222_buf))]; 

  %Outputs of the filters to go into the secondary path
  %Reference,speakers The error microphone may be whatever. 
  yin1x1=dot(x_ref1_buff,W11);
  yin1x2=dot(x_ref1_buff,W12);
  yin2x1=dot(x_ref2_buff,W21);
  yin2x2=dot(x_ref2_buff,W22);
  
  %Updating buffer with the filters outputs.
  %Reference,speakers The error microphone may be whatever. 

  yin1x1_buff=[yin1x1;yin1x1_buff(1:L_s-1);
  yin1x2_buff=[yin1x2;yin1x2_buff(1:L_s-1);
  yin2x1_buff=[yin2x1;yin2x1_buff(1:L_s-1);
  yin2x2_buff=[yin2x2;yin2x2_buff(1:L_s-1);

  %Sending Yin through the secondary path, maybe is eight 
  %Reference,error,speakers
  yo111=dot(yin1x1_buff,TF_S11); 
  yo121=dot(yin1x1_buff,TF_S21);

  yo112=dot(yin1x2_buff,TF_S11); 
  yo122=dot(yin1x2_buff,TF_S21);

  yo211=dot(yin2x1_buff,TF_S11); 
  yo121=dot(yin2x1_buff,TF_S21);

  yo212=dot(yin2x2_buff,TF_S11); 
  yo222=dot(yin2x2_buff,TF_S21);

  %Joining the ones that belong to the same speaker
  

  %Guetting the error
  e1(k)=d11+d21-yo11-yo21;
  e2(k)=d12+d22-yo12-yo22;
  err_buff1=[e1(k);err_buff1(1:L_w-1)];
  err_buff2=[e2(k);err_buff2(1:L_w-1)];
  power_err1=dot(err_buff1,err_buff1);
  power_err2=dot(err_buff2,err_buff2);

  %Updating m_u
  power_1=dot(x_ref1_buff,x_ref1_buff); #power of the input
  power_2=dot(x_ref2_buff,x_ref2_buff); #power of the input
  power_xn=(power_1+power_2)/2; #average of teh power of both input buffer
  m_u=0.1*(2/L_w*power_xn); 

  %Update filters LMS using e1 and e2
  %W(ref,speaker)
  W11=W11+m_u*(X_111_buf*e1(k)+X_121_buf*e2(k)); #going to speaker 1
  W12=W12+m_u*(X_112_buf*e1(k)+X_122_buf*e2(k)); #going to speaker 2
  W21=W21+m_u*(X_211_buf*e1(k)+X_221_buf*e2(k)); #going to speaker 1
  W22=W22+m_u*(X_212_buf*e1(k)+X_222_buf*e2(k)); #going to speaker 2

  k=k+1
endwhile






