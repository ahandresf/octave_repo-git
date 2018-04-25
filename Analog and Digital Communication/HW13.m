#Unquantize vs Quantize symbols
n=100 #number of symbols
while(counter!=n)
  if rand>0.5
    a=1;
  else
    a=-1;
  endif

  if rand>0.5
     b=1i;
  else
     b=-1i;
  endif
  counter=counter+1;
  Vn(counter,1)=a+b;
endwhile

h=[0.2;0.5;0.8;0.7;0.4]

Ioutbuffer=Vn(j)-In?
Ibuffer=[0.5*I(j-1)+0.8*I(j-2)+....
Icurrent=Vbuffer-Ibuffer

I[j]=0.2

