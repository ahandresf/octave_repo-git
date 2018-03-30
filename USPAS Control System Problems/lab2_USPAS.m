clc
close all
clear all
s=tf('s')
Td=1.7e-6
Ht=(1-s*Td);
Htt=1/(1+s*Td);
Hp=(1-s*Td)/(1+s*Td)
bode(Ht)
bode(Htt)
bode(Hp)

