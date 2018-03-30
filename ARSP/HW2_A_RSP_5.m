####
#A random variable x-N(10,3), find P(5<x<11) by using the function erf.
X=3*randn(1,1000)+10;

#
x5=(5-10)/(3*sqrt(2))
x11=(11-10)/(3*sqrt(2))
p=0.5*(1+erf(x11))-0.5*(1+erf(x5)) ### CDF(11)-CDF(5)

#P=1-(1-erf(11-10)/sqrt(3))+1-erf(abs(5-10)/sqrt(3))