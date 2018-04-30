%**************************************************************************
%  Author: Yang Li 02/13/2012
%  Transfer functions are measured by HP 35670A Analyzer     
%**************************************************************************
clc
close all
clear all


%% Load data.
% Primary pass.
P1_mag=10.^(importdata('/home/leasanspy/Octave_Code/ARSP/P2P/P1F.TXT')/20);
P1_phs=importdata('/home/leasanspy/Octave_Code/ARSP/P2P/P1P.TXT');
P2_mag=10.^(importdata('/home/leasanspy/Octave_Code/ARSP/P2P/P2F.TXT')/20);
P2_phs=importdata('/home/leasanspy/Octave_Code/ARSP/P2P/P2P.TXT');
P3_mag=10.^(importdata('/home/leasanspy/Octave_Code/ARSP/P2P/P3F.TXT')/20);
P3_phs=importdata('/home/leasanspy/Octave_Code/ARSP/P2P/P3P.TXT');
P4_mag=10.^(importdata('/home/leasanspy/Octave_Code/ARSP/P2P/P4F.TXT')/20);
P4_phs=importdata('/home/leasanspy/Octave_Code/ARSP/P2P/P4P.TXT');
% Secondary pass.
S11_mag=10.^(importdata('/home/leasanspy/Octave_Code/ARSP/P2P/S11F.TXT')/20);
S11_phs=importdata('/home/leasanspy/Octave_Code/ARSP/P2P/S11.TXT');
S21_mag=10.^(importdata('/home/leasanspy/Octave_Code/ARSP/P2P/S21F.TXT')/20);
S21_phs=importdata('/home/leasanspy/Octave_Code/ARSP/P2P/S21P.TXT');
S12_mag=10.^(importdata('/home/leasanspy/Octave_Code/ARSP/P2P/S12F.TXT')/20);
S12_phs=importdata('/home/leasanspy/Octave_Code/ARSP/P2P/S12P.TXT');
S22_mag=10.^(importdata('/home/leasanspy/Octave_Code/ARSP/P2P/S22F.TXT')/20);
S22_phs=importdata('/home/leasanspy/Octave_Code/ARSP/P2P/S22P.TXT');


%% Frequency response
fs=importdata('/home/leasanspy/Octave_Code/ARSP/P2P/fs.TXT');
TF_fs=2*fs(end);

P1_theta=P1_phs/180*pi;
P2_theta=P2_phs/180*pi;
P3_theta=P3_phs/180*pi;
P4_theta=P4_phs/180*pi;

S11_theta=S11_phs/180*pi;
S21_theta=S21_phs/180*pi;
S12_theta=S12_phs/180*pi;
S22_theta=S22_phs/180*pi;


H_P1_p=P1_mag.*exp(1j*P1_theta);
H_P2_p=P2_mag.*exp(1j*P2_theta);
H_P3_p=P3_mag.*exp(1j*P3_theta);
H_P4_p=P4_mag.*exp(1j*P4_theta);

H_S11_p=S11_mag.*exp(1j*S11_theta);
H_S21_p=S21_mag.*exp(1j*S21_theta);
H_S12_p=S12_mag.*exp(1j*S12_theta);
H_S22_p=S22_mag.*exp(1j*S22_theta);



H_P1=[real(H_P1_p(1)); H_P1_p(2:401); flipud(conj(H_P1_p(2:401)))];
H_P2=[real(H_P2_p(1)); H_P2_p(2:401); flipud(conj(H_P2_p(2:401)))];
H_P3=[real(H_P3_p(1)); H_P3_p(2:401); flipud(conj(H_P3_p(2:401)))];
H_P4=[real(H_P4_p(1)); H_P4_p(2:401); flipud(conj(H_P4_p(2:401)))];

H_S11=[real(H_S11_p(1)); H_S11_p(2:401); flipud(conj(H_S11_p(2:401)))];
H_S21=[real(H_S21_p(1)); H_S21_p(2:401); flipud(conj(H_S21_p(2:401)))];
H_S12=[real(H_S12_p(1)); H_S12_p(2:401); flipud(conj(H_S12_p(2:401)))];
H_S22=[real(H_S22_p(1)); H_S22_p(2:401); flipud(conj(H_S22_p(2:401)))];


%%

TF_P1=ifft(H_P1)';
TF_P2=ifft(H_P2)';
TF_P3=ifft(H_P3)';
TF_P4=ifft(H_P4)';

TF_S11=ifft(H_S11)';
TF_S21=ifft(H_S21)';
TF_S12=ifft(H_S12)';
TF_S22=ifft(H_S22)';


%% Save TF in workspace.
save('Sencondarypath','TF_fs','TF_P1','TF_P2','TF_P3','TF_P4','TF_S11','TF_S21','TF_S12','TF_S22');

