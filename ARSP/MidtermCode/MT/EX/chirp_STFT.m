%% chirp signal
T = 0:0.001:2;
X = chirp(T,100,1,200,'q');
figure;
plot(X);

%% shorttime FT
spectrogram(X,128,120,128,1E3,'yaxis')
title 'Quadratic chirp'

%% another chirp signal
T = 0:0.001:2;
X = chirp(T,0,1,150);
[S,F,T,P] = spectrogram(X,256,250,256,1E3);
surf(T,F,10*log10(P),'edgecolor','none')
axis tight, view(0,90)
xlabel 'Time (s)', ylabel 'Frequency (Hz)', title 'Linear chirp'