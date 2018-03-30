clc
clear all
x1=[-3:0.3:3];
x2=[-3:0.3:3];
[x,y]=meshgrid(x1,x2);
k=1/(2*pi*sqrt(0.12));
a=0.91*(x-0.5).^2;
b=2*0.75*(y-0.3)*(x-0.5);
c=(y-0.3).^2;
z=a-b+c;
fz=k*exp(-0.5*1e-10*z);
mesh(x1,x2,fz);

