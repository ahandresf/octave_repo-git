#Homework 15 
#Andres Felipe Alba Hernandez
pkg load communications
SN=[0:5:50];
sn=10.^(SN/10); 
M=4; %constalation
sig_c=(2*(M-1)/3)./sn;
sM=sqrt(M);
for i=1:11
  Q=qfunc(1/sqrt(sig_c(i)/2));
  Per(i)=(2*(sM-1)/sM)*Q;
endfor
plot(SN,log10(Per),'r')
hold on

M=16; %constalation
sig_c=(2*(M-1)/3)./sn;
sM=sqrt(M);
for i=1:11
  Q=qfunc(1/sqrt(sig_c(i)/2));
  Per(i)=(2*(sM-1)/sM)*Q;
endfor
plot(SN,log10(Per),'g')
hold on

M=32; %constalation
sig_c=(2*(M-1)/3)./sn;
sM=sqrt(M);
for i=1:11
  Q=qfunc(1/sqrt(sig_c(i)/2));
  Per(i)=(2*(sM-1)/sM)*Q;
endfor
plot(SN,log10(Per),'b')
hold on
title("RED M=4, GREEN M=16, BLUE M=64 ");
xlabel ("S/N in DB");
ylabel ("Per");

#{
M=8; %constalation
sig_c=(2*(M-1)/3)./sn;
sM=sqrt(M);
for i=1:6
  Q=qfunc(1/sqrt(sig_c(i)/2));
  Per(i)=(2*(sM-1)/sM)*Q;
endfor
plot(SN,Per,'g')
hold on


M=16; %constalation
sig_c=(2*(M-1)/3)./sn;
sM=sqrt(M);
for i=1:6
  Q=qfunc(1/sqrt(sig_c(i)/2));
  Per(i)=(2*(sM-1)/sM)*Q;
endfor
plot(SN,Per,'b')
#}