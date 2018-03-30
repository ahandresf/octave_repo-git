clear all;
sd = 12357; rng(sd);      % Set seed value
% Set seed value using older versions of MATLAB as following
%rand('seed',12357);      % Seed for noise generator 

x  = randn(1,200);     % Reference signal x(n)
b  = [0.05, -0.1, 0.15, -0.2, 0.25, -0.2, 0.15, -0.1, 0.05];  
                       % FIR system to be identified
d  = filter(b,1,x);    % Desired signal d(n)
mu = 0.05;             % Step size mu
h = adaptfilt.lms(9,mu); % LMS algorithm
[y,e] = filter(h,x,d); % Adaptive filtering
plot(e);               % Plot e(n)
xlabel('Time index, n'); 
ylabel('Amplitude'); 

pause;
figure
x = 1:9;
y = [b;h.coefficients]';
h = stem(x,y);
set(h(1),'MarkerFaceColor','blue')
pause;
set(h(2),'MarkerFaceColor','red','Marker','square')
legend('Unknown system','Adaptive model');
xlabel('Coefficient index'); 
ylabel('Coefficient values'); 
v=[1 9 -0.3 0.3];
axis(v);
grid on;
