close all
n=160
limit=10
#{
Rf=zeros(limit);
for j=1:limit
  #n=0;
  acum=0;
  for i = 1:40000-j
    #n=n+1;
    acum=my_audio(i)*my_audio(j+i);
  endfor
  Rf(j)=acum/n;
endfor
figure;
plot(Rf)

#}

Rf1=zeros(160);
for j=1:160
  #n=0;
  acum=0;
  for i = 1:160-j
    #n=n+1;
    acum=acum+(frame1(i)*frame1(j+i));
  endfor
  Rf1(j)=acum/n;
endfor
figure;
plot(Rf1)

Rf2=zeros(160);
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


Rf3=zeros(160);
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


Rf4=zeros(160);
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

Rf5=zeros(160);
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

big_corr=xcorr(voice_frame);
plot(big_corr)
v1024=randn(1,1024)
cross_voice=xcorr(voice_frame,v1024);

figure
subplot (3, 1, 1)
plot(voice_frame)
subplot (3, 1, 2)
plot(v1024)
subplot (3, 1, 3)
plot(cross_voice)

