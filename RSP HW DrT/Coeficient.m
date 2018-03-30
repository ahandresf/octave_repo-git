close all


#n=40000 #number of samples
#limit=50 # tau that you are going move.
n=160
limit=160
rv1=zeros(1,limit+1);
for j=0:limit
  acum=0;
  for i = 1:n-j
    #acum=acum+(my_audio(i)*my_audio(j+i));
    acum=acum+(frame3(i)*frame3(j+i));

  endfor
  rv1(j+1)=acum/n;
endfor
figure;
#plot(rv1)
rm=rv1(1:limit);
rv=rv1(2:limit+1);
R=toeplitz(rm);
a=-1*inv(R)*rv';
Az=[1;a];
Azf=fft(-1*Az);
#rap=roots(ap);
Pxx=1/(abs(1+Azf)).^2; ###PSD due to the linear predictive coding 
Pxxx=(abs(fft(1/Az))).^2;

###The parameters of the model determine the spectral envelope. 
###This should be compare with the magniture square of the fouresr transform
###divided by the number of samples

#Hs=((abs(fft(frame3))).^2)/n;

#Hs=((abs(fft(my_audio))).^2)/n;

subplot (2, 1, 1)
plot(Pxx);
subplot (2, 1, 2)
plot (Pxxx);




#rap=roots(ap);
#fap=fft(ap);



#{
n=160 #number of samples
limit=160 # tau that you are going move. 

rv1=zeros(1,limit+1);
for j=0:limit
  acum=0;
  for i = 1:n-j
    #n=n+1;
    acum=acum+(frame5(i)*frame5(j+i));
  endfor
  rv1(j+1)=acum/n;
endfor
figure;
plot(rv1)
#}



#{
Rf2=zeros(1,160);
for j=1:159
  #n=0;
  acum=0;
  for i = 1:160-j
    #n=n+1;
    acum=acum+(frame2(i)*frame2(j+i));
  endfor
  Rf2(j)=acum/n;
endfor
figure;
plot(Rf2)


Rf3=zeros(1,160);
for j=1:159
  #n=0;
  acum=0;
  for i = 1:160-j
    #n=n+1;
    acum=acum+(frame3(i)*frame3(j+i));
  endfor
  Rf3(j)=acum/n;
endfor
figure;
plot(Rf3)


Rf4=zeros(1,160);
for j=1:159
  #n=0;
  acum=0;
  for i = 1:160-j
    #n=n+1;
    acum=acum+(frame4(i)*frame4(j+i));
  endfor
  Rf4(j)=acum/n;
endfor
figure;
plot(Rf4)

Rf5=zeros(1,160);
for j=1:159
  #n=0;
  acum=0;
  for i = 1:160-j
    #n=n+1;
    acum=acum+(frame5(i)*frame5(j+i));
  endfor
  Rf5(j)=acum/n;
endfor
figure;
plot(Rf5)
#}
