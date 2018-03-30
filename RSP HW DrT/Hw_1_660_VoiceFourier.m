#I load an previous audio recorded

#I use a good frame
var_audio=voice_frame(14000:14000+160);
plot(var_audio);

#I take fourier transform
N=256; ##To adjust the fourier DFT
f_var=fft(var_audio,N);
f_var_shift=fftshift(f_var);#getting it center into the lower frequencies.
plot(abs(f_var))

####
f=1000; #frequency you want to find the coefficient
k=(f+4000)*256/8000; #array position where you find the coefficient for f
ak=real(f_var_shift(k)); 
bk=imag(f_var_shift(k));
