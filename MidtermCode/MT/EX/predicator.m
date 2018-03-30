clear all;
sd = 12357; rng(sd);               % Set seed value
% Set seed value using older versions of MATLAB as following
%rand('seed',12376);               % Seed for noise generator 

% define parameters
Fs = 1000; 
f0 = 150; 
L =64;
N=256; 
A=sqrt(2); 
w0=2*pi*f0/Fs; 
n = [0:N-1];                       % Time index
sn = A*sin(w0*n);                  % Sine sequence
vn = 0.1*(rand(1,N)-0.5)*sqrt(12); % Zero-mean white noise
x = sn+vn;                         % Sinewave embedded in white noise
d  = [0, x(2:256)];                % Desired signal d(n)
mu = 0.001;                        % Step size mu
h = adaptfilt.lms(L,mu);           % LMS algorithm
[y,e] = filter(h,x,d);             % Adaptive filtering
plot(n,y,':',n,e,'-');
axis([1 N -inf inf]);
xlabel('Time index, n'); 
ylabel('Amplitude');