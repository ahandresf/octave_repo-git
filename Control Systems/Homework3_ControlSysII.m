#2b)
clear all
Qiocf=[2 1;1 0]
Q=[1 2;-6 -3]
Tocf=inv(Qiocf*Q)
A=[0 1;-3 -2];
B=[0;1]
C=[1 2]
Aocf=inv(Tocf)*A*Tocf
Bocf=inv(Tocf)*B
Cocf=C*Tocf
clc
clear all

#3) 
pkg load control
A=[1 2 3;0 6 1;-2 -4 -3]
B=[2;0;1]
C=[1 2 1]
#a)
Q=obsv(A,C)

#b)
rank(Q)

#c)
chpol=poly(A)
#a3 a2 a1 a0 where a3 must be one
a0=chpol(4)
a1=chpol(3)
a2=chpol(2)
a3=chpol(1)
###Answer:
Qocf_inv=[a1 a2 1;a2 1 0;1 0 0]

#d)
Tocf=inv(Qocf_inv*Q)

Aocf=inv(Tocf)*A*Tocf
Bocf=inv(Tocf)*B
Cocf=C*Tocf