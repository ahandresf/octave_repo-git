####
clear all
clc
load VoiceSampleWith5Frames


z=zeros(1,16);

F=[0 z 0.5 1 ones(1,28) 0.5 z];
sF=fftshift(F)
sFi=ifft(sF,64);####time domain
#sFi=fftshift(Fi);
sFir=real(sFi);


figure
plot(abs(sFi))
var=0;
j=1;
for i=1:2*length(voice_frame)
  if(var==0)
    voice_frame2x(i)=voice_frame(j);
    var=1;
    j=j+1;
  else
    voice_frame2x(i)=0;
    var=0;
  endif
endfor
cVF=conv(voice_frame2x,real(sFi));
t=1:80063;
figure
subplot(2,1,1)
plot(voice_frame)
subplot(2,1,2)
plot(cVF(1:80000))
sound(voice_frame)
sleep(2)
sound(cVF,16000)


poly1=sFir(1:2:64);
poly2=sFir(2:2:64);



#real(sFi)


############
#{
D=fft(real(sFi),512);
D=fftshift(D);
freq1=-8000:16000/512:8000-16000/512;
plot(freq1,abs(D))

freq = -8000:16000/64:8000-16000/64;
plot(freq,F)

f=[-8000:16000/64:8000-16000/64];
plot(f,D)



h=real(sFi);
HD=fft(h,512);
HD=fftshift(HD);


freq = -8000:16000/64:8000-16000/64;
figure(1)
plot(freq,sFi)
hold on
plot(freq1,abs(HD))
figure(2)
t1=1:64
plot(t1,h)
figure(3)
plot(freq,H)
t=1:80063;
convolution=conv(voice_frame2x,real(h));
figure(4)
plot(t,convolution)
#}

