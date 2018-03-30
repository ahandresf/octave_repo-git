###Do an adaptive filter 
clc
close all
clear all

####
#Option
only_real=false; #if I put true is only real binary sequence as input, false then imaginary binary sequence
plotting=true; #True means plot

xn=[0.1 -0.2 0.2]';     #My Channel
j=1;                #counter
n=180;               #Error Energy samples for average ¿¿¿How many samples???
C=3;                #length of my channel
L=3;                #length of my filter
wn=zeros(1,L)';       #My adaptive filter, my estimated channel
I=zeros(1,C)';       #assuming zero before the sample. 
max_num_iterations=100000;

targ_n=[zeros(9,1);1;0.5;1]; #Defining my target channel. 
f_split=256;        #number of divisions in frequency

if only_real
  e(1:n)=1;     #Initialize the vector for store the error
else
  e(1:n)=1+1i;
endif
err_energy=(1/n)*dot(e(1:length(e)),e(1:length(e)));#I initialize the energy error by 5 times the minimum
epsilon_er=1e-6;    #the minimum amount of energy.     ¿¿¿How do you pick this number???

#Loop
while (err_energy>epsilon_er && j!=max_num_iterations)

##Input generator: This just generate random binary numbers imaginary, eg. 1+j or -1-j
  if rand>0.5
    a=1;
  else
    a=-1;
  endif

  if only_real
    b=0;
  else
    if rand>0.5
      b=1i;
    else
      b=-1i;
    endif
  endif
  Ij=a+b;
  j=j+1;
  I=[Ij;I(1:length(I)-1)];
  testIj(j)=Ij;


##Filter adaptation
  ye=(conj(wn))'*I(1:L); #estimated output 
  #testye(j)=ye; #just for testing
  y=(conj(xn))'*I(1:C);  #real output
  #testy(j)=y;
  e(j+n-1)=y-ye;   #error in this iteration
  wn=wn+e(j+n-1)*conj(I)./(norm(I)^2); #adapting the filter
  err_energy=(1/n)*dot(e(length(e)-n+1:length(e)),e(length(e)-n+1:length(e)));#calculating the error energy in n samples
  #err_energy=e(length(e)-n:length(e))'*e(length(e)-n:length(e));#calculating the error energy in n samples
  #err_energy=(1/n)*err_energy;


##Equalizer
  if err_energy<epsilon_er
    wf=fft(wn);
    targ_f=targ_f=fftshift(fft(targ_n,f_split));  ###256 is assuming 128 samples
    wf=fftshift(fft(targ_n,f_split)); #the estimated channel in frequency
    cf=(targ_f./wf); #The equilizer in frequency
    cn=ifft(cf,f_split); #The equilizer in time domain
  endif

end
#End loop

##
alpha=1/8;
Rc=(sin(pi*t/T)/(pi*t/T))*(Cos(alpha*pi*t))

### Plot rutine
if plotting
  figure(3)
  plot(abs(e(n:length(e))))
  title("Error");
  
  f=linspace((-1/2)+(1/f_split),(1/2)-(1/f_split),f_split);
  t=0:f_split-1;
  
  figure(1)
  subplot(2,1,1)
  plot(t,cn);
  title("Equilizer Cn in the time domain");

  subplot(2,1,2)
  plot(f,cf);
  title("Equilizer Cf in the frecuency domain");
  
  figure(2)
  subplot(2,1,1)
  stem(xn);
  title("Real channel");

  subplot(2,1,2)
  stem(wn);
  title("Estimated channel");
  
else
  disp("I am not ploting, change the value plotting to true")
endif

