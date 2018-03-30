###Homework estimation of a and b
clc
clear all
###Setting parametters
N=20;
w=0.001*randn(1,20);      #vector of random noise [w(0) w(1)...w(19)]
f1=4/N;                  #It should be multiply by the frecuency bw for example 1000*4/N for 1k?
f2=7/N;###Homework estimation of a and b
N=20; #number of divisions of the frecuency
A1=0.7
B1=0.6
A2=0.3
B2=0.1
###Setting parametters
w=0.01*randn(20,1);      #vector of random noise [w(0) w(1)...w(19)]
f1=4/N;        #It should be multiply by the frecuency bw for example 1000*4/N for 1k?
f2=7/N;
n=[0:N-1]';#discret time from 0 to 19
#x=A1*cos(2*pi*f1*n)+B1*sin(2*pi*f1*n)+A2*cos(2*pi*f2*n)+B2*sin(2*pi*f2*n)+w;
C1=cos(2*pi*f1*n);
S1=sin(2*pi*f1*n);
C2=cos(2*pi*f2*n);
S2=sin(2*pi*f2*n);
#x=x1+x2+x3+x4
x=A1*C1+B1*S1+A2*C2+B2*S2+w;#signal

####
#a1:a "hat" is equal to a1=(2/N)*sum(x[n]*cos(2*pi*f)) for a big N
av=real(fft(x,N));
bv=imag(fft(x,N));


a1=(1/((norm(C1))^2))*av(4);
b1=(1/((norm(S1))^2))*bv(4);
a2=(1/((norm(C2))^2))*av(7);
b2=(1/((norm(S2))^2))*bv(7);
                    #n=[0:1/1000:2*pi];
                    #n=[0:(2*pi/N):2*pi];

a1v=dot(x,C1)/((norm(C1))^2);
b1v=dot(x,S1)/((norm(S1))^2);
a2v=dot(x,C2)/((norm(C2))^2);
b2v=dot(x,S2)/((norm(S2))^2);


###In the vector way we will have
uc1=C1/norm(C1);
us1=S1/norm(S1);
uc2=C2/norm(C2);
us2=S2/norm(S2);
PC1=uc1*uc1';
PS1=us1*us1';
PC2=uc2*uc2';
PS2=us2*us2';

###We have that
disp("Estimation by vector approach")
a1_v_approach=C1'*PC1*x/((norm(C1)^2))
a2_v_approach=S1'*PS1*x/((norm(S1)^2))
b1_v_approach=C2'*PC2*x/((norm(C2)^2))
b2_v_approach=S2'*PS2*x/((norm(S2)^2))
disp("Estimation by Fourier approach")
a1
b1
a2
b2
disp("Estimation by formula, manual implementation")
a1v
b1v
a2v
b2v
disp("Real values")
A1
B1
A2
B2
#{#Xe=fft(x,20);
#a=(2/N)*real(Xe);
#imag(Xe);
x1=A1*cos(2*pi*f1*n);
x2=B1*sin(2*pi*f1*n);
x3=A2*cos(2*pi*f2*n);
x4=B2*sin(2*pi*f2*n);
#}