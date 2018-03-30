clc
close all
clear all
s=tf('s')
#**********
#Variables
L=0.8;
R=1.33;
ki=10.355/2;
kp=0.4;


#Controller
C=kp+(ki/s);

#Plant, sensor, and actuator
P=1/(R+s*L); #Plant
Hi=(1/80); #Sensor
Hv=137; #Actuator

OL=C*P*Hv*Hi #open loop
CL=C*P*Hv/(1+C*P*Hv*Hi) #close loop


[GAMMA, PHI, W_GAMMA, W_PHI] = margin (OL)
title("Open loop")
bode(OL)
#figure;
#bode(CL)



