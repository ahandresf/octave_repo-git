clear all
clc


v10=randn(1,10);
v50=randn(1,50);
v100=randn(1,100);
v1024=randn(1,1024);

sd10=std(v10);
sd50=std(v50);
sd100=std(v100);
sd1024=std(v1024);

m10=mean(v10);
m50=mean(v50);
m100=mean(v100);
m1024=mean(v1024);

r_v10=xcorr(v10);
r_v50=xcorr(v50);
r_v100=xcorr(v100);
r_v1024=xcorr(v1024);

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

figure
subplot (4, 1, 1)
plot(r_v10)
subplot (4, 1, 2)
plot(r_v50)
subplot (4, 1, 3)
plot(r_v100)
subplot (4, 1, 4)
plot(r_v1024)

