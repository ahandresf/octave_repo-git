clear all
clc
###Variance (1/12)*(b-a)^2
###Mean (b+a)/2
##If a=0
variance=1;
a=0;
b=sqrt(variance*12)
v10=b*(0.5-rand(1,10));
v50=b*(0.5-rand(1,50));
v100=b*(0.5-rand(1,100));
v1024=b*(0.5-rand(1,1024));
sd10=std(v10);
sd50=std(v50);
sd100=std(v100);
sd1024=std(v1024);
m10=mean(v10);
m50=mean(v50);
m100=mean(v100);
m1024=mean(v1024);

m_v=[m10 m50 m100 m1024]
s_d=[sd10 sd50 sd100 sd1024]

subplot (4, 1, 1)
hist(v10);
subplot (4, 1, 2)
hist(v50);
subplot (4, 1, 3)
hist(v100)
subplot (4, 1, 4)
hist(v1024);
