#w_voice_frame=frame3
n=length(w_voice_frame) #number of samples
limit=10 #number of coefficients 
rv1=zeros(1,limit+1);
for j=0:limit
  acum=0;
  for i = 1:n-j
    #acum=acum+(my_audio(i)*my_audio(j+i));
    acum=acum+(w_voice_frame(i)*w_voice_frame(j+i));
  endfor
  rv1(j+1)=acum/n;
endfor
figure;
#plot(rv1)
rm=rv1(1:limit);
rv=rv1(2:limit+1);
R=toeplitz(rm);
av=inv(R)*rv';