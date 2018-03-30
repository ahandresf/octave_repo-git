#POINT3 HW1 CONTROL SYSTEM II
#Andres Felipe Alba Teaching Assistant Spring 2018
#Northern Illinois University.


clear all
clc
close all
#Loading appropiate packages
pkg load control
pkg load signal

##
#Part A
s=tf('s');
A=[0 1 0;0 0 1;-52 -30 -4];
B=[0;0;1];
C=[20 1 0];
D=0;
sys = ss(A, B, C, D)
### H=C*inv(s*I-A)*B+D <===> C*(inv((s*eye(length(A)))-A))*B+D
### Htf=C*(inv((s*eye(length(A)))-A))*B+D Apparently this one does not work
[num,den]=ss2tf(sys)
my_sys=tf(num,den)

##
#Part B
xo=[1,2,3]';
t=[0:0.01:5]';
Yzs=step(my_sys,t);
plot(t,Yzs)
title("Answer using the step(my_sys,t) command")

##
#Part C
#xo=[1,2,3]';
i=1;
for ti=0:0.01:5
    m_sys_time(i)=C*expm(A*ti)*xo;#ths is going to be 3x1
    i=i+1;
end
Yzi=m_sys_time;
plot(t,Yzi)
title("This is Yzs")
##
#Part D
Yt=Yzs+Yzi';
subplot(2,1,1)
plot(t,Yt)
title("Yt is the output of Yzs+Yzi")
u=ones(1,length(t))';
lsys=lsim(sys,u,t,xo);
subplot(2,1,2)
plot(t,lsys)
title("Yt is the output using lsim command")



##
#Part E
[T lampda]=eig(A); ### V=Eig Vector and lampda=Eig Values. 
Ti=inv(T)
Adcf=Ti*A*T
Bdcf=Ti*B
Cdcf=C*T
Ddcf=D

###Canon function non implemented in Octave. 









