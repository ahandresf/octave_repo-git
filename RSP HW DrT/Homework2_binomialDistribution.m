###Octave Program
#Program to test the Binomial distribution or Bernoulli process.
#Repeat a binary experiment "X variable that can take yes or no, 1,0" n times.
#probability of happening k times out of N times
#first clear the workspace
clear all;
clc;
#Defining Variables
n=1000;
k=100;
pk=0;
pbn=0;
#in order to create a random output I can use rand which generate a random number between
#"[0-1] with a uniform probability density function pdf
cV=zeros(10,1);#vector of number of occurance
for j=[1:10000] #to run 10 times the same experiment
  p=0.1; #probability of occurence
  ##initiating some variables
  c=0; #number of occurance
  x=zeros(1000,1); #maybe there is an easier way to initialize this but lest do it like that for know
  rV=zeros(1000,1);#vector of random numbers
  #Get the value of the random variable n number of times 
  for i=[1:n]
    r=rand;
    rV(i)=r;
    if (rand<=p)#generate a bernoulli trial of probability p
      x(i)=1;
      c=c+1; #increment the occurance value
    else
      x(i)=0;
    endif
  endfor
  cV(j)=c;
  pc=c/n; #occurance/number of evaluation of the random variable.
  #{
  disp("#########################################################")
  disp("experimental occurance is equal to"), disp(c)
  disp("the probability of occurrance is"), disp(pc)
  disp("end of iteration, random process #"), disp(j)
  disp("*********************************************************")
  #}
  if (c==k)
    pk=pk+1;
  endif
endfor 
pbn=pk/10000;
disp("Prob k times out of 1000, with 100 iterations"),disp(pbn)


