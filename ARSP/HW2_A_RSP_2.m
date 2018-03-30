
#{
Generate 1000 set of 2, 10, 100 and 200 samples of random numbers
uniform distribution, zero mean, variance one. Calculate the sum of each set. 
Then use std, mean, and hist for verify Central Limit Theorem.
#}

###Variance (1/12)*(b-a)^2
###Mean (b+a)/2
##If a=0
clear all
clc
variance=1;
a=0;
b=sqrt(variance*12);


M2=b*(0.5-rand(1000,2));
M10=b*(0.5-rand(1000,10));
M100=b*(0.5-rand(1000,100));
M200=b*(0.5-rand(1000,200));


v2=sum(M2(:,:));
v10=sum(M10(:,:));
v100=sum(M100(:,:));
v200=sum(M200(:,:));

sd2=std(v2);
sd10=std(v10);
sd100=std(v100);
sd200=std(v200);
m2=mean(v2);
m10=mean(v10);
m100=mean(v100);
m200=mean(v200);

m_v=[m2 m10 m100 m200]
s_d=[sd2 sd10 sd100 sd200]

subplot (4, 1, 1)
hist(v2);
subplot (4, 1, 2)
hist(v10);
subplot (4, 1, 3)
hist(v100)
subplot (4, 1, 4)
hist(v200);
