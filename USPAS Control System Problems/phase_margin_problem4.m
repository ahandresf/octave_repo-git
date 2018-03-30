s=tf('s')
G=1000
Td=10^-3
kp=30
a=50
sys=((G*kp)/(s+a))*exp(-s*Td)
[GAMMA, PHI, W_GAMMA, W_PHI] = margin(sys)

