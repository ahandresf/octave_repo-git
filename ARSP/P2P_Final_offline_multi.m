%Andres Felipe Alba Hernandez
%Model of a system with 2 reference microphones, 2 error microphones and 2 loud speakers.

clc
clear all
close all

%loading libraries 
pkg load control 
pkg load signal 

load ('/home/leasanspy/Octave_Code/ARSP/Workspaces_ARSP/Workspace_P2P');
load ('/home/leasanspy/Octave_Code/ARSP/P2P/Sencondarypath.mat');
load ("/home/leasanspy/Octave_Code/ARSP/HW4data/wn.mat"); #white noise given by the problem


t=[0:800];
#{
figure
subplot(4,1,1);
plot(t,TF_S11)
ylabel ('S11[n]')

subplot(4,1,2);
plot(t,TF_S21)
ylabel ('S21[n]')

subplot(4,1,3);
plot(t,TF_S12)
ylabel ('S12[n]')

subplot(4,1,4);
plot(t,TF_S22)
xlabel ('discrete time');
ylabel ('S22[n]')
#}

super_TF=[TF_S11;TF_S12;TF_S21;TF_S22];

#clear wn
#wn=0.1*(0.5-rand(10000,1));
L_w=800; #window filter size
#S_e=zeros(4,L_w);
S_e=zeros(L_w,1);



#for j=1:4
k=1;
#S=super_TF(j,:);
S=TF_S22;
L_s=length(S);
x_in_buff=zeros(L_w,1);
x_in_buff_S=zeros(length(S),1);
err_buff=ones(L_w,1);#buffer of error fill with ones, power = N^2
power_err=dot(err_buff,err_buff);

while (power_err!=1e-5 && k!=10000)
  x_in_buff=[wn(k);x_in_buff(1:L_w-1)];
  x_in_buff_S=[wn(k);x_in_buff_S(1:L_s-1)];
  y_out=dot(x_in_buff_S,S); #output of real filter
  y_out_e=dot(x_in_buff,S_e);#Output of estimated filter
  e(k)=y_out-y_out_e;
  err_buff=[e(k);err_buff(1:L_w-1)];
  power_err=dot(err_buff,err_buff);
  power_xn=dot(x_in_buff_S,x_in_buff_S); #power of the input
  m_u=0.1*(2/L_w*power_xn); ##max mu=2/(L_w*Px) where Px power of the input.
  S_e=S_e+m_u*x_in_buff*e(k);
  k=k+1;
endwhile
S_e22=S_e;
#endfor
figure
plot(e)
figure
plot(e(length(e)-100:length(e)))

figure
subplot(2,1,1);
plot(S(1:800))
title('S22')
subplot(2,1,2);
plot(S_e(1:800))
title('S22e')


save S22_e.mat S_e22


#Se=offline_train;
#{
function Jo=cost_ini(n)
  Jo=(r(n-2)-I(n-2))^2+(r(n-1)-I(n-1)-0.5*I(n-1))^2+(r(n)-I(n)-0.5*I(n-1)-0.4*I(n-2))^2;
endfunction
}#


