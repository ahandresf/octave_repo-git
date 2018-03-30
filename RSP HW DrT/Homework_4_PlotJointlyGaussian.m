clear all
clc
C=[0.75 0.75;0.75 0.91]; #Covariance Matrix
iC=inv(C); #Inverse of the covariance Matrix
mx1=0.5;
mx2=0.3;
mx=[mx1;mx2]; #Main Vector
det(C); #determinant
constant=1/(2*pi*sqrt(dC));
tx=ty=linspace(-8,8,41);
[xx,yy]=meshgrid(tx,ty);
xx=(xx-mx1)
yy=(yy-mx2)
tz=constant*exp(v'*iC*v)   ###The function I want to plot in function of tx and ty. 
mesh(tx,ty,tz);
xlabel("X1");
ylabel("X2");
zlabel("fx(X1,X2) Jointly Gaussian");

