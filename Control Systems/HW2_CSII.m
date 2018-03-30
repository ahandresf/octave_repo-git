###
#Homework II Control System II 480/580
#TA Solution Felipe Alba
#Excersice III
clc
close all
clear all
pkg load control
A=[1 1 0;0 1 1;-5 -4 -3];
B=[0 1 1]';
C=[5 3 1];

#a) Find the controllability matrix
P=ctrb(A,B)

#b) Asset the controllability of the system
r=rank(P) #the matrix is controllable because the result was 3

#c) Find the polinomios
p=poly(A) #a3=1 a2=1 a1=-1 a0=4 from sI-A matrix
Pinv=[-1 1 1;1 1 0;1 0 0] #Canonical form using the coefficients 

#d) Now using P and Pinv we find the Transformation matrix
T=P*Pinv
Ti=inv(T)
Accf=Ti*A*T
Bccf=Ti*B
Cccf=C*T
D=0

