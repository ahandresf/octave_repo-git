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
delay=[0;1];
x_ref2=conv(x_ref1,delay);
x_ref2=x_ref2(1:length(x_ref1));
L_w=800;

%lets buid all the d[n] Signal that go from:
%microphone 1 and 2 to the error microphone=real channel
d11=filter(TF_P1,1,x_ref1);
d21=filter(TF_P2,1,x_ref2);

d12=filter(TF_P3,1,x_ref1);
d22=filter(TF_P4,1,x_ref2);


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


%Creating the filters. 












