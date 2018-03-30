N=[20 50 100 200 ];
for t=1:4
  m=0;
  A=0;
  for k=1:100
    wn(1:N(t))=sqrt(0.1)*rand(1,N(t));
      for i=1:N(z)
        xn(i)=0.7*cos(2*pi*0.1*i)+wn(i);
        A=A+(xn(i)*cos(2*pi*0.1*i));
      end
    A=(2/N(z))*A;
    Ae(k)=A;
    m=(m+Ae(k));
    vector(k)=Ae(k);
  end
  subplot(2,2,t);hist(Ae,k)
  mean_A = m/100
  v=0;
  for j=1:100
    v=v+(vector(j)- mean_A).^2;
  end
  var_Ae=(1/100)*v
end
