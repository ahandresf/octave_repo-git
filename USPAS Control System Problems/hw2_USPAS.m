clear all
k=4
ko=0.3
l=1
m1=5
m2=30
A=[0 0 1 0;0 0 0 1;(-k-ko)/m1 ko/m1 -l/m1 0;-ko (1-k)/m2 0 -l/m2]
eig(A)

ko=3
A=[0 0 1 0;0 0 0 1;(-k-ko)/m1 ko/m1 -l/m1 0;-ko (1-k)/m2 0 -l/m2];
eig(A)

ko=100
A=[0 0 1 0;0 0 0 1;(-k-ko)/m1 ko/m1 -l/m1 0;-ko (1-k)/m2 0 -l/m2];
eig(A)


