#Initializing values
#x=A*sin(2*pi*0.1*n)+w where w is color noise
iteration=100;
A=10 # If I choose A as 10
for j=1:iteration
  A=10;
  n=4;
  w=zeros(n,1);
  x=zeros(n,1);
  h=zeros(n,1);
  w_n=0;

  #Lets generate the color noise vector from w[1:4]
  #the model for the color noise is w[n]=k*u[n]+0.9*w[n-1]
  #w_n=w[n-1]
  k=sqrt(1-0.9^2);
  for i=1:n
    w_n=w_n*0.9+k*randn; #noise updated
    w(i)=w_n;
    h(i)=sin(2*pi*0.1*i);
    x(i)=A*h(i)+w(i);
  end
  cw=[1 0.9 (0.9).^2 (0.9).^3 ; 0.9 1 (0.9) (0.9).^2 ; (0.9).^2 0.9 1 0.9 ; (0.9).^3 (0.9).^2 0.9 1];cwi=inv(cw);
  A_hat = inv(h'*cwi*h)*h'*cwi*x;
  pe(j)=A_hat;
end
plot(pe)
mean(pe)



