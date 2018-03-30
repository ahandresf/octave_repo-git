%%% MT Pj
%% clean up
clear all
close all
clc
%% load data
n1 = importdata('SEC13R.mat');
n2 = importdata('SEC18R.mat');
load('TF.mat'); 
%% set up
STP = 700;               %700    %off line training steps
L_s = 100;               %100     %Second pass lenth
u_s = 0.007;             %0.007   %miu

%noise = wgn(1,L_TEST,1);
noise = n1';
T = length(n1);
L_TEST =T;%T
noise = noise(1:L_TEST);
L_w = 100; %100
%u_w = 0.006; %0.006
u_w =0.0000000012;%0.0000000122

%window = 10; %for wn
%window = 3500;% for n2
window = 5000;%for n1
%% off-line 
Train = wgn(1,STP,1);              %white noise
Y1 = filter(S_z,S_p,Train);        %original result
% define the vector
Sh=zeros(1,L_s);                   %define second pass hat
e_s=zeros(1,STP);                  %prepare for error
In=zeros(1,L_s);                   %set the buffer as all zeros start
% adapt filter
for n=1:STP
    In = [Train(n),In(1:L_s-1)];  %updata the buffer
 
    y = In*Sh';
    e_s(n)= Y1(n)- y;
    Sh = Sh+u_s*In*e_s(n);            %updata the S_hat
        
%     figure(1)
%     plot(Sh) 
%     axis([0 L_s -2 1.5]);
%     legend('off-line training')
%     %pause(0.01)                 %delay the cycle
end
 figure(2)
 plot(e_s)
%% on line test No.3 amplifire without Sz
%% amplifire
%ap = 1; % amplifire 700/1500
%noisein  = noise./ap;
%% define the vector
W = zeros(1,L_w);                   %define W
e = zeros(1,L_TEST);                %prepare for error
In = zeros(1,L_w);                  %set the buffer as all zeros start
d = filter(P_z,P_p,noise);        %original Out put
X1 = filter(Sh,1,noise); 
YB = zeros(1,25);
Yo = zeros(1,24);
In_s = zeros(1,L_w);
%% adaptive filter
for n=1:L_TEST
%     In = [noisein(n),In(1:L_w-1)];  %updata the buffer
%     y = In*W';
%     e(n)= d(n)- y*ap;
%     W = W+u_w*In*(e(n)/ap);            %updata the W
    
    In = [noise(n),In(1:L_w-1)];
    y = In*W';
    YB = [y YB(1:24)]; ###new buffer 
    Y = (dot(YB,S_z) - dot(Yo,S_p(2:25)))/S_p(1);
    Yo = [Y Yo(1:23)];
    e(n) = d(n) - Y;
    
    In_s =[X1(n) In_s(1:L_w-1)];
    W = W + u_w*In_s*e(n);
    
    
    
    
%     figure(1)
%     subplot(1,2,1)
%     ONE=ones(1,100);
%     OUT = filter(P_z,P_p,ONE);
%     OUT2 = filter(W,1,ONE);
%     plot(OUT,'color',[1 0 0])
%     hold on 
%     plot(OUT2,'color',[0 0 1])
%     hold off
%     subplot(1,2,2)
%     plot(noise,'Color',[1 0 0])
%     axis([0 L_TEST -window window])
%     hold on
%     line([n+1 n+1],[-window window],'Color',[0 1 0])
%     plot(e,'Color',[0 0 1])
%     hold off
    
end

    figure(3)
    subplot(1,2,1)
    %ONE=ones(1,100);
    %OUT = filter(P_z,P_p,ONE);
    %OUT2 = filter(W,1,ONE);
    %plot(OUT,'color',[1 0 0])
    %hold on
    %plot(OUT2,'color',[0 0 1])
    plot(W)
    
    
    subplot(1,2,2)
    plot(noise,'Color',[1 0 0])
    hold on
    axis([0 L_TEST -window window])
    plot(e,'Color',[0 0 1])