%Andres Felipe Alba
%Model of a system with 2 reference microphones, 2 error microphones and 2 loud speakers.

clc
clear all
close all

%loading libraries 
pkg load control 
pkg load signal 

load ('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/Workspace_P2P');
load ('/home/leasanspy/Octave_Code/ARSP/P2P/Sencondarypath.mat');
load ("/home/leasanspy/Octave_Code/ARSP/HW4data/wn.mat"); %white noise given by the problem

load ('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/Workspace_P2P');
