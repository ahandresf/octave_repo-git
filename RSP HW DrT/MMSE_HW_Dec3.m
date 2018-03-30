## MMSE
C1=[0.5 -0.9 2]'
C2=[0.3 -0.8 0.45]'
C3=[-0.25 0.5 -0.4]'
w=[-0.05 0.07 0.04]'
Cw=0.01*eye(3)
a=(C1*C1')
b=(C2*C2')
c=(C3*C3')
Cx=a+b+c+Cw;
Cxi=inv(Cx)
x=(1)*C1+(-1)*C2+(-1)*C3+w
g1=(inv(C1'*Cxi*C1))*Cxi*C1;
b1e=g1'*x

g2=(inv(C2'*Cxi*C2))*Cxi*C2;
b2e=g2'*x

g3=(inv(C3'*Cxi*C3))*Cxi*C3;
b3e=g3'*x
